package a;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.management.MBeanServer;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;
import javax.management.Query;
import net.lingala.zip4j.exception.ZipException;

public class DownloadDB {

    private Connection con = null;
    private PreparedStatement stmt = null;
    private Statement cstmt = null;
    private String tbls = "";
    private String bckPath = null;
    private String tempPath = null;
    private String dia_hoje = "";
    private String fnlr = "";
    private String vlsgetpath = "";
    private String flpth = "";
    private String zipflnm = "";
    private String zp = "";
    private String lnk_dwnld = "";
    Values vls = null;
    client_session cssn;
    directories_mngmnt dirmng;
    language lang;
    String current_lang = "";

    public DownloadDB() {
        vls = new Values();   
        cssn = new client_session();
        dirmng = new directories_mngmnt();
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        if ((cssn.getPathIrprt()).contains("Apache Tomcat 8.0.27")) {
                vlsgetpath = "C:\\SGRB";
        } else {
                vlsgetpath = "" + cssn.getPathIrprt();
        }
        bckPath = vlsgetpath + "\\webapps\\SGRB\\BCKUPS";
        tempPath = "C:\\SGRB\\TEMPPATH";
        java.util.Date date = new java.util.Date();
        Format formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        dia_hoje = formatter.format(date);
        zipflnm = bckPath + "\\" + Strngs.cz + dia_hoje + ".zip";
        zp = Strngs.cz + dia_hoje + ".zip";
        dirmng.checkIfDrctyExistandCreateIt(cssn.getPathIrprt());
    }

    public synchronized String DwnRrtn() {
        //sgrbtbls(); Only for mysql
        tbls = "appversion_registration,categories,clients,clients_duplicate,clients_events,clients_requests,clients_requests_duplicate,clients_requests_events,deposits,deposits_duplicate,deposits_events,depositslist,depositslist_duplicate,depositslist_events,expenses,expenses_duplicate,expenses_events,groups_factories,groups_factories_duplicate,groups_factories_events,language,ms,ms_duplicate,ms_events,ms_requests,ms_requests_duplicate,ms_requests_events,ms_states,ms_states_duplicate,ms_states_events,organization,organization_duplicate,organization_events,prefered_language,prices_sales,prices_sales_duplicate,prices_sales_events,product_type,products_purchases,products_purchases_duplicate,products_purchases_events,purchases,purchases_duplicate,purchases_events,purchases_not_used,purchases_not_used_duplicate,purchases_not_used_events,sales,sales_duplicate,sales_events,used_products,used_products_duplicate,used_products_events,users,users_duplicate,users_events";
        tablesInDB(tbls);
        lnk_dwnld();
        process_file(lnk_dwnld);
        notifyAll();
        return fnlr;
    }

    private synchronized void sgrbtbls() {
        /*Sabendo quais formularios importar seus dados*/
        try {
            con = cdb.getConnection();
            String qr = "show full tables where Table_Type != 'VIEW'";
            cstmt = con.createStatement();
            ResultSet rs = cstmt.executeQuery(qr);
            while (rs.next()) {
                tbls += rs.getString("Tables_in_sgrb") + ",";
            }
            try {
                rs.close();
            } catch (Exception e) {
            }
        } catch (Exception e) {
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                cstmt.close();
            } catch (Exception e) {
            };
        }
        //System.out.println("tbls: " + tbls);
        notifyAll();
    }

    private synchronized void tablesInDB(String s) {
        try {
            wait(500);
        } catch (InterruptedException e) {
        };
        String output_res = "";
        String erros = "";
        /*Cria-se diretorio que o caminho acima*/
        try {
            File directory = new File(Strngs.fl);
            if (!directory.exists()) {
                directory.mkdir();
            } else {
                dirmng.deleteAllfiles();
            }
        } catch (Exception ex) {
        }
        for (String z : s.split(",")) {
            if (z == null || z.trim().length() == 0) {
            } else {
                try {
                    con = cdb.getConnection();
                    String q = "SELECT * from " + z;
                    stmt = con.prepareStatement(
                            q,
                            ResultSet.TYPE_FORWARD_ONLY,
                            ResultSet.CONCUR_READ_ONLY);
                    stmt.setFetchSize(Integer.MIN_VALUE);
                    ResultSet rs = stmt.executeQuery();
                    ResultSetMetaData rsmd = rs.getMetaData();
                    String metdata = "";
                    try {
                        /*Nome de cada ficheiro a ser criado*/
                        String pathbk = Strngs.fl + "\\" + z + ".csv";
                        /*Esta linha de codigo cria o ficheiro*/
                        PrintWriter writer = new PrintWriter(pathbk, "UTF-8");
                        int i = 0;
                        int k = 0;
                        /*A medida que se le os dados na base de dados os mesmos sao escritos no ficheiro criado*/
                        while (rs.next()) {
                            String usrn = "a";
                            if (z.startsWith("users")) {
                                try {
                                    String uu = rs.getString("username");
                                    usrn = uu;
                                } catch (Exception e) {
                                }
                            }
                            if (z.startsWith("organization")) {
                                try {
                                    String uu = rs.getString("id");
                                    usrn = uu;
                                } catch (Exception e) {
                                }
                            }
                            if ((z.startsWith("users") && usrn.equalsIgnoreCase("Admin")) || (z.startsWith("organization") && usrn.equalsIgnoreCase("0"))) {
                            } else {
                                output_res = "";
                                /*Apenas a primeira vez as colunas devem ser lidas depois nao*/
                                if (i == 0) {
                                    try {
                                        for (int j = 0; j < 900; j++) {
                                            k = j + 1;
                                            metdata = rsmd.getColumnName(k);
                                            try {
                                                metdata = metdata.replaceAll("\",\"", "_");
                                            } catch (Exception e) {
                                            }
                                            output_res += "\"" + metdata + "\",";
                                        }
                                    } catch (Exception e) {
                                        output_res += "\"\"";
                                    }
                                    writer.println(output_res);
                                }
                                output_res = "";
                                /*Leitura dos valores de cada variavel em cada linha*/
                                try {
                                    for (int j = 0; j < 200; j++) {
                                        k = j + 1;
                                        String data = rs.getString(k);
                                        String dt = "";
                                        try {
                                            dt = data.replaceAll("\",\"", "_");
                                            data = dt;
                                        } catch (Exception e) {
                                        }
                                        try {
                                            dt = data.replaceAll(",", "_");
                                            data = dt;
                                        } catch (Exception e) {
                                        }
                                        if (data == null || data.equalsIgnoreCase("null")) {
                                            data = "";
                                        }
                                        output_res += "\"" + data + "\",";
                                    }
                                } catch (Exception e) {
                                    output_res += "\"\"";
                                }
                                writer.println(output_res);
                                i = i + 1;
                            }
                        }
                        i = 0;
                        /*Depois de se criar o ficheiro deve-se encerar o despositivo que cria ficheiro*/
                        writer.close();
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                        } catch (SQLException eex) {
                            erros += eex.getMessage() + "\n";
                        }
                    } catch (IOException e) {
                        erros += e.getMessage() + "\n";
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    output_res = "::: " + e.getMessage();
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
                //System.out.println("tbls: " + tbls);
                //System.out.println("erros: " + erros);
                notifyAll();
            }
        }
    }

    private synchronized void lnk_dwnld() {
        lnk_dwnld = "";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            //System.out.println("vv" + vv);
            String q = "select lnk_download from organization order by id desc limit 1";
            stmt = con.prepareStatement(
                    q,
                    ResultSet.TYPE_FORWARD_ONLY,
                    ResultSet.CONCUR_READ_ONLY);
            stmt.setFetchSize(Integer.MIN_VALUE);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                lnk_dwnld = rs.getString("lnk_download");
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
        if (lnk_dwnld == null || lnk_dwnld.trim().length() == 0 || lnk_dwnld.equalsIgnoreCase("null") || lnk_dwnld.equalsIgnoreCase("NA")) {
            lnk_dwnld = "localhost";
        }
        notifyAll();
    }

    private synchronized void process_file(String lnk_dwnld2) {
        String r = "";
        String prt = "";
        try {
            try {
                wait(500);
            } catch (InterruptedException e) {
            };
            /*Chamase a classe o metodo responsavel pelo zip do ficheiro a ser baixado*/
            AppZipbs appZip = new AppZipbs();
            appZip.zipIt(zipflnm, Strngs.pwd2, Strngs.fl);
            dirmng.cpybckflToCFloldr(cssn.getPathIrprt());
            r += lang.lng(current_lang, "the_file_was_created") + "!\n";
            try {
                prt = getIpAddressAndPort();
            } catch (MalformedObjectNameException ex) {
                Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
            } catch (NullPointerException ex) {
                Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
            } catch (UnknownHostException ex) {
                Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
            }
            r = "<span style='color: green;'>" + lang.lng(current_lang, "click_m") + " <a href='http://" + lnk_dwnld2 + ":" + prt + "/SGRB/BCKUPS/" 
                    + zp + "'  style='text-decoration: none;'>" + lang.lng(current_lang, "click") + "</a> " 
                    + lang.lng(current_lang, "to_download_the_file") + "!</span>\n<br>"
                    + "<span style='color: blue;'>" + lang.lng(current_lang, "the_same_file_can_be_found_on_the_server_in_the_folder") 
                    + " 'C:\\SGRB\\BCKUPS'</span><br>";
            //System.out.println("t2: " + r);
            /*
            try {
                System.out.println("Your Host addr: " + InetAddress.getLocalHost().getHostAddress());  // often returns "127.0.0.1"
            } catch (UnknownHostException ex) {
                Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
            }

            Enumeration<NetworkInterface> n = null;
            try {
                n = NetworkInterface.getNetworkInterfaces();
            } catch (SocketException ex) {
                Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
            }
            for (; n.hasMoreElements();) {
                NetworkInterface e = n.nextElement();

                Enumeration<InetAddress> a = e.getInetAddresses();
                for (; a.hasMoreElements();) {
                    InetAddress addr = a.nextElement();
                    r = "Clique <a href='http://" + lnk_dwnld + ":" + prt + "/SGRB/BCKUPS/" + zp + "'  style='text-decoration: none;'>aqui</a> para baixar o ficheiro!\n<br>";
                    System.out.println("  " + addr.getHostAddress());
                }
            }*/
            dirmng.deleteAllfiles();
        } catch (ZipException ex) {
            //System.out.println("ex: " + ex);
            Logger.getLogger(DownloadDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        fnlr = r;
        notifyAll();
    }

    public String getIpAddressAndPort() throws MalformedObjectNameException, NullPointerException,
            UnknownHostException {

        MBeanServer beanServer = ManagementFactory.getPlatformMBeanServer();

        Set<ObjectName> objectNames = beanServer.queryNames(new ObjectName("*:type=Connector,*"),
                Query.match(Query.attr("protocol"), Query.value("HTTP/1.1")));

        String host = InetAddress.getLocalHost().getHostAddress();
        String port = objectNames.iterator().next().getKeyProperty("port");

        //System.out.println("IP Address of System : " + host);
        //System.out.println("port of tomcat server : " + port);
        return "" + port;

    }

}
