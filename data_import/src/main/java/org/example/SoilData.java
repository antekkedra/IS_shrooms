package org.example;

import org.json.JSONObject;

import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class SoilData {

    public static void soilData(String DBurl, Properties props) {

        String selectLocations =
                "SELECT DISTINCT latitude, longitude " +
                        "FROM fungi_occurrence " +
                        "WHERE latitude <> 0 AND longitude <> 0 " +
                        "ORDER BY latitude, longitude " +
                        "LIMIT 10;";

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

                    // IMPORTANT: handle null explicitly
                    if (values.isNull("mean")) {
                        return 0.0; // or Double.NaN if you prefer
                    }

                    return values.getDouble("mean");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}