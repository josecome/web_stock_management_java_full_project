package a;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class RestoreDB {

    /*Please to restore database call method processrstr()*/
    private Connection con = null;
    private Statement stmt = null;
    private String flnms = "";
    Values vls = new Values();
    private int expected = 0;
    private int processed = 0;
    private String file_folder_to_read = "";
    private String clns_sqlr2 = "";
    private boolean withfrstrcrd = false;
    client_session cssn;
    PreferedLang plng; 
    language lang;
    String current_lang = "";
    public RestoreDB(String flnm) {
        cssn = new client_session();
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
        Restore(flnm);
    }

    public boolean dbIsEmpty() throws SQLException, ClassNotFoundException {
        boolean a = true;
        //Mysql
        /*DatabaseMetaData md = con.getMetaData();
        ResultSet rs = md.getTables(null, null, "%", null);
        while (rs.next()) {
            a = false;
        }*/
        //System.out.println("dbIsEmpty: " + a);
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select id from groups_factories");
            while (rs.next()) {
                a = false;
                //System.out.println("dbIsEmpty2: " + a);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            //a = true;
            System.err.println(e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.err.println(e.getMessage());
            }
        }
        //System.out.println("dbIsEmpty3: " + a);
        return a;
    }
    
    private String Restore(String flnm) {
        String r = "";
        String flnm2 = "";
        try {
            String fln = flnm.replaceAll("\\.", "");
            flnm2 = fln;
        } catch (Exception e) {
        }
        try {
            String fln = flnm2.replaceAll("zip", "");
            flnm2 = fln;
        } catch (Exception e) {
        }
        AppZipbs azp = new AppZipbs();
        file_folder_to_read = "" + cssn.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH\\" + flnm2;
        //System.out.println("file_folder_to_read: " + file_folder_to_read);
        try {
            azp.extractzip("" + cssn.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH\\" + flnm, Strngs.pwd2, file_folder_to_read);
        } catch (ZipException ex) {
            //System.out.println("e: " + ex.getMessage());
        }
        //file_folder_to_read = "" + cssn.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH\\" + flnm2 + "\\" + flnm2;
        //File folder = new File("" + vls.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH\\" + flnm2 + "\\SOURF");
        //File[] listOfFiles = folder.listFiles();
        String tbls = "users,users_duplicate,users_events,groups_factories,groups_factories_duplicate,groups_factories_events,"
                + "products_purchases,products_purchases_duplicate,products_purchases_events,product_type,categories,prices_sales,prices_sales_duplicate,"
                + "prices_sales_events,clients,clients_duplicate,clients_events,clients_requests,clients_requests_duplicate,"
                + "clients_requests_events,ms,ms_duplicate,ms_events,ms_requests,"
                + "ms_requests_duplicate,ms_requests_events,appversion_registration,language,"
                + "deposits,deposits_duplicate,deposits_events,depositslist,depositslist_duplicate,depositslist_events,"
                + "expenses,expenses_duplicate,expenses_events,"
                + "organization,organization_duplicate,organization_events,prefered_language,"
                + "purchases,purchases_duplicate,purchases_events,"
                + "purchases_not_used,purchases_not_used_duplicate,purchases_not_used_events,sales,sales_duplicate,sales_events,"
                + "used_products,used_products_duplicate,used_products_events";
        flnms = tbls;
        //for (File listOfFile : listOfFiles) {
        //for (String listOfFile : tbls.split(",")) {
        /*if (listOfFile.isFile()) {
                flnms = "" + listOfFile.getName() + ",";
                expected = expected + 0;
            }*//* else if (listOfFile.isDirectory()) {
                System.out.println("Directory " + listOfFile.getName());
            }*/
        //}
        return r;
    }

    public String processrstr() throws ClassNotFoundException {
        try {
            if (dbIsEmpty()) {
                try {
                    for (String d : flnms.split(",")) {
                        if (d == null || d.trim().length() == 0) {
                        } else {
                            try {
                                readFile(d);
                            } catch (Exception e) {
                                System.out.println("Ew: " + e.getMessage());
                            }
                            expected = expected + 1;
                        }
                    }
                } catch (Exception e) {
                }
                deleteUploadRestoreFile();
                return "<span style='color: green;'>" + lang.lng(current_lang, "expected_items") + ": " 
                        + expected + ", " + lang.lng(current_lang, "processed") + ": " + processed + "!</span>";
            } else {
                deleteUploadRestoreFile();
                return "<span style='color: green;'>" + lang.lng(current_lang, "the_database_has_tables") + "!</span>";
            }
        } catch (SQLException ex) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred_please_try_again") + "!</span>";
        }
    }

    private void readFile(String tb) throws FileNotFoundException, IOException {
        /*try{
            String c = tb.split("\\.")[0];
            tb = c;
        }catch(Exception e){}*/
        String sqlr = "";
        String clns = "insert into " + tb + " (";
        try {
            con = cdb.getConnection();
            if (con == null) {
                return;
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            int i = 0;
            boolean rnbtch = false;
            //System.out.println("file: " + file_folder_to_read + "\\SOURF\\" + tb + ".csv");
            try (FileInputStream fstream = new FileInputStream("" + file_folder_to_read + "\\SOURF\\" + tb + ".csv")) {
                BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
                String strLine;
                String sqlvls = "";                
                while ((strLine = br.readLine()) != null) {
                    rnbtch = false;
                    //System.out.println("tb: " + tb);
                    try {
                        for (String w : strLine.split("\",\"")) {
                            if (w == null || w.trim().length() == 0 || w.equalsIgnoreCase("null")) {
                                sqlvls += "null,";
                            } else {
                                sqlvls += "'" + w + "',";
                            }
                        }
                    } catch (Exception e) {
                    }
                    sqlvls += "',";
                    try {
                        String p = sqlvls.replaceAll(",,", "");
                        sqlvls = p;
                    } catch (Exception e) {
                    }
                    sqlvls += ")";
                    if (i == 0) {
                        //System.out.println("c: " + sqlvls);
                        clns += strLine + ") values (";
                        clns = clns.toLowerCase();
                        try {
                            String zz = clns.replaceAll(Pattern.quote("\""), "");
                            clns = zz;
                        } catch (Exception e) {
                        }
                        try {
                            String zz = clns.replaceAll(Pattern.quote(",)"), ")");
                            clns = zz;
                        } catch (Exception e) {
                        }
                    } else {
                        sqlr = sqlvls;
                        //System.out.println("sqlr: " + sqlr);
                        try {
                            String zz = sqlr.replaceAll(Pattern.quote("\""), "");
                            sqlr = zz;
                        } catch (Exception e) {
                        }
                        String clns_sqlr = clns + sqlr;
                        //System.out.println("sqlr2: " + sqlr);
                        try {
                            String zz = clns_sqlr.replaceAll(Pattern.quote(",'')"), ")");
                            clns_sqlr = zz;
                        } catch (Exception e) {
                        }
                        try {
                            String zz = clns_sqlr.replaceAll(Pattern.quote(",'',',)"), ")");
                            clns_sqlr = zz;
                        } catch (Exception e) {
                        }
                        //System.out.println("sqlr3: " + clns_sqlr);
                        if(tb.equalsIgnoreCase("users") && clns_sqlr.contains("'Admin'"))
                        {
                            withfrstrcrd = true;
                        }
                        try{
                            String abc = clns_sqlr.replaceAll("'null'", "null");
                            clns_sqlr = abc;
                        }catch(Exception e){}
                        try{
                            String abc = clns_sqlr.replaceAll("'NULL'", "null");
                            clns_sqlr = abc;
                        }catch(Exception e){}
                        try{
                            String abc = clns_sqlr.replaceAll("'Null'", "null");
                            clns_sqlr = abc;
                        }catch(Exception e){} 
                        /*if((tb.toUpperCase()).startsWith("PURCHASE")){
                            try{
                                String abc = clns_sqlr.replaceAll("null", "'NA'");
                                clns_sqlr = abc;
                            }catch(Exception e){
                               System.out.println("Ex: " + e);
                            }      
                            System.out.println("Purchase");
                        }*/                        
                        if (i == 1 && !(tb.equalsIgnoreCase("users") && clns_sqlr.contains("'Admin'"))) {
                            stmt.executeUpdate(clns_sqlr);
                        } else {
                            if(i == 2 && withfrstrcrd == true && (tb.equalsIgnoreCase("users") || tb.equalsIgnoreCase("organization"))){
                                if(tb.equalsIgnoreCase("organization")){
                                     try{String wj = clns_sqlr.replaceAll("base64_", "base64, "); clns_sqlr = wj;}catch(Exception e){}
                                     stmt.executeUpdate(clns_sqlr);
                                }else{
                                     stmt.executeUpdate(clns_sqlr);
                                }                                    
                            } else {
                                    stmt.addBatch(clns_sqlr);
                                    rnbtch = true;
                            }
                        }
                        clns_sqlr2 = clns_sqlr;
                        //if(tb.startsWith("purchase")){
                           //System.out.println("clns_sqlr:" + tb + ":" + clns_sqlr);
                        //}
                    }
                    sqlvls = "";
                    i = i + 1;
                }
            }
            if (rnbtch) {
                stmt.executeBatch();
            }
            con.setAutoCommit(true);
            processed = processed + 1;
        } catch (IOException | ClassNotFoundException | SQLException e) {
            //System.out.println("es: " + e.getMessage() + "," + clns_sqlr2);
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                System.out.println("ey: " + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
    }

    public void insert() throws IOException {
        Connection con = null;
        Statement stmt = null;
        int result = 0;
        int c = 0;
        try {
            con = cdb.getConnection();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RestoreDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            stmt = con.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(RestoreDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        String pthfl = Strngs.pth_current_java_f_local;
        if (!(cssn.getPathIrprt()).contains("Apache Tomcat 8.0.27")) {
            pthfl = cssn.getPathIrprt() + "\\webapps\\SGRB\\WEB-INF\\classes\\a";
        }
        //String str = FileUtils.readFileToString(new File("C:\\Users\\Admin\\Documents\\P\\Personal Project\\zz.sql"), "utf-8"); hdb
        //String str = FileUtils.readFileToString(new File("C:\\Users\\Admin\\Documents\\P\\Personal Project\\vw.sql"), "utf-8");
        String str = FileUtils.readFileToString(new File(pthfl + "\\hdb.sql"), "utf-8");
        try {
            //System.err.println("Connected Successfully!");
            try {
                String a = str.replaceAll("\n", " ");
                str = a;
            } catch (Exception e) {
            }
            try {
                String a = str.replaceAll("\r", " ");
                str = a;
            } catch (Exception e) {
            }
            /*str = "update groups_factories set sector = 'Restaurant';update groups_factories_duplicate set sector = 'Restaurant';"
                    + "update groups_factories_events set sector = 'Restaurant';"
                    + "update products_purchases set sector = 'Restaurant';update products_purchases_duplicate set sector = 'Restaurant';"
                    + "update products_purchases_events set sector = 'Restaurant'";*/
            //str = "DROP SCHEMA PUBLIC CASCADE;";
            for (String command : str.split(";")) {
                try {
                    String a = command.replaceAll("\n", " ");
                    command = a;
                } catch (Exception e) {
                }
                try {
                    String a = command.replaceAll("data:image/bmpbase64", "data:image/bmp;base64");
                    command = a;

                } catch (Exception e) {
                }
                //System.out.println("b: " + command);
                result += stmt.executeUpdate(command);
                c = c + 1;
                //break;
            }
            // remember to call shutdown otherwise hsqldb will not save your data
            con.commit();
            stmt.close();
        } catch (SQLException e) {
            //System.out.println("ee: " + e.getMessage());
            //e.printStackTrace(System.out);
        }
        //System.out.println(c + " rows effected");
        //System.out.println("Rows inserted successfully");
    }

    private void deleteUploadRestoreFile() {
        try {
            File directory = new File( "" + cssn.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH");
            if (directory.exists()) {
                File[] listOfFiles = directory.listFiles();
                try {
                    for (int i = 0; i < listOfFiles.length; i++) {
                        File fld = new File(Strngs.fl + File.separator + listOfFiles[i].getName());
                        try {
                            fld.delete();
                        } catch (Exception e) {
                        }
                    }
                } catch (Exception e) {
                }
            }
        } catch (Exception ex) {
        }
    }
}
