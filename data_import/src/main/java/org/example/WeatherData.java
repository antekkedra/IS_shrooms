package org.example;

import org.json.JSONObject;

import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;
import java.util.Scanner;

public class WeatherData {

    public static void weatherData(String DBurl, Properties props) {

        String selectLocations =
                """
                SELECT DISTINCT latitude, longitude, event_date::date AS event_date
                FROM fungi_occurrence
                WHERE latitude <> 0
                  AND longitude <> 0
                  AND event_date IS NOT NULL
                LIMIT 50;
                """;

        String insertWeather =
                """
                INSERT INTO weather_data
                (latitude, longitude, weather_date,
                 temperature_mean, precipitation_sum, wind_speed_mean)
                VALUES (?, ?, ?, ?, ?, ?)
                ON CONFLICT (latitude, longitude, weather_date) DO NOTHING
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
}