package org.example;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.sql.*;
import java.util.List;
import java.util.Properties;
import java.util.Scanner;

import static org.example.FungiOccurrence.*;

public class SoilData {
    public static void soilData(String DBurl, Properties props) throws SQLException {
        String temp;
        try (Connection conn = DriverManager.getConnection(DBurl, props)) {
            System.out.println("Connected to PostgreSQL database!");
            Statement st = conn.createStatement();
            st.execute("DELETE FROM soil_data");
            String insertSQL = "INSERT INTO soil_data (ph, organic_carbon, clay, sand, silt, soil_moisture, depth) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(insertSQL);
                for (String[] record : records) {
                    temp = "https://rest.isric.org/soilgrids/v2.0/properties/query?lon=" + record[longitudeIndex].trim() + "&lat=" + record[latitudeIndex].trim() + "&property=clay&property=phh2o&property=sand&property=silt&property=soc&depth=0-5cm&property=wv0033&value=mean";
                    URL url = new URL(temp);
                    HttpURLConnection apiConn = (HttpURLConnection) url.openConnection();
                    apiConn.setRequestMethod("GET");
                    apiConn.connect();
                    int responsecode = apiConn.getResponseCode();

                    if (responsecode != 200) {
                        throw new RuntimeException("HttpResponseCode: " + responsecode);
                    } else {

                        String inline = "";
                        Scanner scanner = new Scanner(url.openStream());

                        while (scanner.hasNext()) {
                            inline += scanner.nextLine();
                        }
                        System.out.println(inline);
                    }

                    System.out.println("Dane zostały wstawione do bazy.");
                }

        } catch (ProtocolException e) {
            throw new RuntimeException(e);
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
