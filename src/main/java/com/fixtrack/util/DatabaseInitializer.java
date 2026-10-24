package com.fixtrack.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;

public class DatabaseInitializer {
    private static final String dbURL = "jdbc:mysql://localhost:3306/";
    private static final String user = "root";
    private static final String password = "";

    private static final Path dbPath = Path.of("database", "jaypee.sql");

    public static void init() {
        try {
            Connection dbCon = DriverManager.getConnection(dbURL, user, password); 
            Statement stmt = dbCon.createStatement();

            String script = Files.readString(dbPath, StandardCharsets.UTF_8);

            for (String sql : script.split(";")){
                String statement = sql.trim();

                if (!statement.isEmpty()){
                    stmt.execute(statement);
                }
            }
            System.out.println("Database created...");
        } catch (SQLException | IOException e){
            System.out.println("error");
            throw new RuntimeException("Database setup failed...", e);
        }
    }
}
