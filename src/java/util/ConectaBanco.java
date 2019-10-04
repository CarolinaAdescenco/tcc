package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectaBanco {
    
    public static Connection getConnection(){
        try{
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection("jdbc:postgresql://localhost:15432/postgres", "postgres", "Postgres2019!");
        } catch(ClassNotFoundException | SQLException erro1){
            throw new RuntimeException(erro1);
        }
    }
}
