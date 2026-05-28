package org.example;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

public class Main {
    public static void main(String[] args) throws SQLException {
        final String DBurl = "jdbc:postgresql://localhost:5432/shroomsDB";
        final Properties props = new Properties();
        props.setProperty("user", "postgres");
        props.setProperty("password", "haslo");

        FungiOccurrence fo = new FungiOccurrence();

        fo.fungiOccurrence(DBurl, props);


        SoilData so = new SoilData();
        so.soilData(DBurl, props);
    }
}