package org.example.shroomsanalyzer.service;

import lombok.Getter;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.utils.UpdateStatus;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;

@Service
public class DatabaseUpdateService {

    @Getter
    private volatile UpdateStatus status = UpdateStatus.IDLE;

    @Getter
    private volatile String message = "Not started";

    @Value("${spring.datasource.url}")
    private String dbURL;

    @Value("${spring.datasource.username}")
    private String dbUsername;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    @Async
    public void startUpdate() {
        try {
            status = UpdateStatus.RUNNING;
            message = "Update started";

            updateDatabase();

            status = UpdateStatus.SUCCESS;
            message = "Update finished successfully";

        } catch (Exception e) {
            status = UpdateStatus.FAILED;
            message = e.getMessage();
        }
    }

    private void updateDatabase() throws SQLException {
        final String DBurl = dbURL;
        final Properties props = new Properties();
        props.setProperty("user", dbUsername);
        props.setProperty("password", dbPassword);

        Connection conn = DriverManager.getConnection(DBurl, props);
        Statement st = conn.createStatement();

        st.execute("""
                    TRUNCATE TABLE
                        analysis_result,
                        fungi_occurrence,
                        soil_data,
                        weather_data
                    RESTART IDENTITY CASCADE
                """);

        conn.close();

        fungiOccurrence(DBurl, props);
        soilData(DBurl, props);
        weatherData(DBurl, props);
    }

    public static void weatherData(String DBurl, Properties props) {

        String selectLocations =
                """
                        SELECT DISTINCT latitude, longitude, event_date::date AS event_date
                        FROM fungi_occurrence
                        WHERE latitude <> 0
                          AND longitude <> 0
                          AND event_date IS NOT NULL;
                        """;

        String insertWeather =
                """
                        INSERT INTO weather_data
                        (latitude, longitude, weather_date,
                         temperature_mean, precipitation_sum, wind_speed_mean)
                        VALUES (?, ?, ?, ?, ?, ?)
                        """;

        try (Connection conn = DriverManager.getConnection(DBurl, props);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(selectLocations);
             PreparedStatement pst = conn.prepareStatement(insertWeather)) {

            System.out.println("Importing weather data.");

            while (rs.next()) {
                double lat = rs.getDouble("latitude");
                double lon = rs.getDouble("longitude");
                LocalDate date = rs.getDate("event_date").toLocalDate();

                String apiUrl =
                        "https://archive-api.open-meteo.com/v1/archive" +
                                "?latitude=" + lat +
                                "&longitude=" + lon +
                                "&start_date=" + date +
                                "&end_date=" + date +
                                "&daily=temperature_2m_mean,precipitation_sum,windspeed_10m_mean" +
                                "&timezone=UTC";

                HttpURLConnection connApi =
                        (HttpURLConnection) new URL(apiUrl).openConnection();
                connApi.setRequestMethod("GET");
                connApi.setConnectTimeout(15000);
                connApi.setReadTimeout(15000);

                if (connApi.getResponseCode() != 200) {
                    System.out.println("Weather API error for " + lat + "," + lon);
                    continue;
                }

                StringBuilder jsonText = new StringBuilder();
                try (Scanner sc = new Scanner(connApi.getInputStream())) {
                    while (sc.hasNext()) {
                        jsonText.append(sc.nextLine());
                    }
                }

                JSONObject json = new JSONObject(jsonText.toString());
                JSONObject daily = json.getJSONObject("daily");

                double temp =
                        daily.getJSONArray("temperature_2m_mean").optDouble(0, 0.0);
                double rain =
                        daily.getJSONArray("precipitation_sum").optDouble(0, 0.0);
                double wind =
                        daily.getJSONArray("windspeed_10m_mean").optDouble(0, 0.0);

                pst.setDouble(1, lat);
                pst.setDouble(2, lon);
                pst.setDate(3, Date.valueOf(date));
                pst.setDouble(4, temp);
                pst.setDouble(5, rain);
                pst.setDouble(6, wind);

                pst.addBatch();

                Thread.sleep(1200); // API rate limiting
            }

            pst.executeBatch();
            System.out.println("Weather data imported successfully.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void soilData(String DBurl, Properties props) {

        String selectLocations =
                "SELECT DISTINCT latitude, longitude " +
                        "FROM fungi_occurrence " +
                        "WHERE latitude <> 0 AND longitude <> 0 " +
                        "ORDER BY latitude, longitude ";

        String insertSoil =
                "INSERT INTO soil_data " +
                        "(ph, organic_carbon, clay, sand, silt, soil_moisture, depth, longitude, latitude) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                        "ON CONFLICT (depth, longitude, latitude) DO NOTHING";

        try (Connection conn = DriverManager.getConnection(DBurl, props);
             Statement st = conn.createStatement()) {
            System.out.println("Importing soil data.");
            // st.execute("TRUNCATE TABLE soil_data RESTART IDENTITY CASCADE");

            try (ResultSet rs = st.executeQuery(selectLocations);
                 PreparedStatement pst = conn.prepareStatement(insertSoil)) {


                while (rs.next()) {
                    double lat = rs.getDouble("latitude");
                    double lon = rs.getDouble("longitude");

                    String apiUrl =
                            "https://rest.isric.org/soilgrids/v2.0/properties/query" +
                                    "?lat=" + lat +
                                    "&lon=" + lon +
                                    "&property=phh2o&property=soc&property=clay" +
                                    "&property=sand&property=silt&property=wv0033" +
                                    "&depth=0-5cm&value=mean";

                    HttpURLConnection connApi = (HttpURLConnection) new URL(apiUrl).openConnection();
                    connApi.setRequestMethod("GET");
                    connApi.setConnectTimeout(15000);
                    connApi.setReadTimeout(15000);

                    int responseCode;
                    try {
                        responseCode = connApi.getResponseCode();
                    } catch (java.net.SocketTimeoutException e) {
                        System.out.println("Timeout for: " + lat + ", " + lon + " – skipped");
                        continue;
                    }

                    if (responseCode != 200) {
                        System.out.println("API error " + responseCode + " for: " + lat + ", " + lon);
                        continue;
                    }

                    StringBuilder jsonText = new StringBuilder();
                    try (Scanner sc = new Scanner(connApi.getInputStream())) {
                        while (sc.hasNext()) {
                            jsonText.append(sc.nextLine());
                        }
                    }

                    JSONObject json = new JSONObject(jsonText.toString());
                    JSONObject propsJson = json.getJSONObject("properties");


                    pst.setDouble(1, getValue(propsJson, "phh2o"));
                    pst.setDouble(2, getValue(propsJson, "soc"));
                    pst.setDouble(3, getValue(propsJson, "clay"));
                    pst.setDouble(4, getValue(propsJson, "sand"));
                    pst.setDouble(5, getValue(propsJson, "silt"));
                    pst.setDouble(6, getValue(propsJson, "wv0033"));
                    pst.setInt(7, 5);
                    pst.setDouble(8, lon);
                    pst.setDouble(9, lat);


                    pst.addBatch();

                    Thread.sleep(1200); // API rate limiting
                }

                pst.executeBatch();
                System.out.println("Soil data imported successfully.");

                String updateRelation =
                        """
                                UPDATE fungi_occurrence f
                                SET soil_data_id = s.id
                                FROM soil_data s
                                WHERE f.latitude = s.latitude
                                  AND f.longitude = s.longitude
                                """;

                try (
                        Statement updateStmt = conn.createStatement()) {
                    int updatedRows = updateStmt.executeUpdate(updateRelation);
                    System.out.println("Updated relations: " + updatedRows);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static double getValue(JSONObject properties, String key) {
        try {
            for (Object obj : properties.getJSONArray("layers")) {
                JSONObject layer = (JSONObject) obj;

                if (layer.getString("name").equals(key)) {

                    JSONObject values = layer
                            .getJSONArray("depths")
                            .getJSONObject(0)
                            .getJSONObject("values");

                    if (values.isNull("mean")) {
                        return 0.0;
                    }

                    return values.getDouble("mean");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public static List<String[]> records = new ArrayList<>();
    public static int latitudeIndex = 40;
    public static int longitudeIndex = 41;

    public static void fungiOccurrence(String DBurl, Properties props) throws SQLException {
        String COMMA_DELIMITER = ",";

        int scientificNameIndex = 46;
        int genusIndex = 53;
        int familyIndex = 52;
        int eventDateIndex = 27;
        int countryIndex = 35;


        InputStream is = FungiOccurrence.class.getClassLoader()
                .getResourceAsStream("occurrences.csv");

        if (is == null) {
            throw new RuntimeException("File was not found");
        }
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is))) {
            String line;
            boolean isFirstLine = true;
            while ((line = br.readLine()) != null) {
                if (isFirstLine) {
                    isFirstLine = false;
                    continue;
                }
                String[] values = line.split(COMMA_DELIMITER, -1);
                records.add(values);
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        Connection conn = DriverManager.getConnection(DBurl, props);
        System.out.println("Importing fungi data.");
        Statement st = conn.createStatement();
        //st.execute("TRUNCATE TABLE fungi_occurrence RESTART IDENTITY");
        String insertSQL = "INSERT INTO fungi_occurrence (species, genus, family, latitude, longitude, event_date, country) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pst = conn.prepareStatement(insertSQL)) {
            for (String[] record : records) {
                if (record.length > Math.max(Math.max(scientificNameIndex, genusIndex), Math.max(familyIndex, Math.max(latitudeIndex, Math.max(longitudeIndex, Math.max(eventDateIndex, countryIndex)))))) {
                    String species = record[scientificNameIndex].trim();
                    String genus = record[genusIndex].trim();
                    String family = record[familyIndex].trim();
                    String latitude = record[latitudeIndex].trim();
                    String longitude = record[longitudeIndex].trim();
                    String eventDate = record[eventDateIndex].trim();
                    String country = record[countryIndex].trim();

                    pst.setString(1, species);
                    pst.setString(2, genus);
                    pst.setString(3, family);
                    pst.setDouble(4, latitude.isEmpty() ? 0.0 : Double.parseDouble(latitude));
                    pst.setDouble(5, longitude.isEmpty() ? 0.0 : Double.parseDouble(longitude));
                    pst.setString(6, eventDate);
                    pst.setString(7, country);

                    pst.addBatch();
                }
            }
            pst.executeBatch();
            System.out.println("Fungi data imported successfully.");
        }


    }
}
