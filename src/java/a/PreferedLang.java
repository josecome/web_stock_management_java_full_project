/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Admin
 */
public class PreferedLang {
    private Connection con = null;
    private Statement stmt = null;
    public String getPreferedLang(){
       String a = "Default"; 
       try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select language from prefered_language");            
            while (rs.next()) {
                a = rs.getString("language");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException eb) {
                //System.out.println("" + eb.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
       //System.out.println("Lng: " + a);
       return a;    
    }
}
