package org.example;

import java.sql.*;
import java.util.Properties;

public class Main {
    public static void main(String[] args) throws SQLException {
        final String DBurl = "jdbc:postgresql://localhost:5432/shroomsDB";
        final Properties props = new Properties();
        props.setProperty("user", "postgres");
        props.setProperty("password", "haslo");

        Connection conn = DriverManager.getConnection(DBurl, props);
        Statement st = conn.createStatement();

        st.execute("""
    TRUNCATE TABLE
        analysis_result,
        fungi_occurrence,
        soil_data
    RESTART IDENTITY CASCADE
""");

        conn.close();

        FungiOccurrence fo = new FungiOccurrence();
        SoilData so = new SoilData();


        fo.fungiOccurrence(DBurl, props);
        so.soilData(DBurl, props);
    }
}