/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author alunocmc
 */
public class ConectaBanco {
    
    public static Connection getConnection(){
        Connection conexao = null;
        
        try{
            Class.forName("org.postgresql.Driver");            
            conexao = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/usuario","postgres", "postgres");
        } catch(ClassNotFoundException erro1){
         throw new RuntimeException(erro1);
        } catch (SQLException erro2) {
        throw new RuntimeException(erro2);

        }
        return conexao;
    }

   
    
}
