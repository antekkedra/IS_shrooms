package org.example;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

public class FungiOccurrence {

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
            throw new RuntimeException("Nie znaleziono pliku occurrences.csv");
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
        System.out.println("Connected to PostgreSQL database!");
        Statement st = conn.createStatement();
        st.execute("DELETE FROM fungi_occurrence");
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
            System.out.println("Dane zostały wstawione do bazy.");
        }


    }
}