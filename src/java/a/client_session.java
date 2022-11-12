/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import ed.encr;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;
import javax.servlet.http.HttpSession;
import org.joda.time.Days;

/**
 *
 * @author Admin
 */
public class client_session {

    private Connection con = null;
    private Statement stmt = null;
    HttpSession sessao;
    Values vls = new Values();
    PreferedLang plng;
    encr ec;
    language lang;
    String current_lang = "";

    public client_session() {
        ec = new encr();
        get_lng_file glng = new get_lng_file();
        try {
            lang = new language(glng.getlngs());
        } catch (IOException ex) {

        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
    }

    public String[] keystatus() {
        String[] k = new String[12];
        int i = 0;
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            //System.out.println("tme0");
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select *,"
                    + "CAST(datev AS DATE) as datevv,"
                    + "(select a.datev from ksts a where a.id = 0) as datey, "
                    + "(select a.ky from ksts a where a.id = 0) as kyy,"
                    + "(select a.user_system_subscr from ksts a where a.id = 0) as user_system_subscr0,"
                    + "(select a.user_system_subscr_e from ksts a where a.id = 0) as user_system_subscr_e0,"
                    + "(select a.user_system_subscr_day from ksts a where a.id = 0) as user_system_subscr_day0,"
                    + "(select a.user_system_subscr_day_e from ksts a where a.id = 0) as user_system_subscr_day_e0,"
                    + "(select a.user_system_rdys from ksts a where a.id = 0) as user_system_rdys0,"
                    + "(select a.user_system_rdys_e from ksts a where a.id = 0) as user_system_rdys_e0 "
                    + " from ksts order by id desc limit 1");
            while (rs.next()) {
                String s = rs.getString("sts");
                String d = rs.getString("datevv");
                String dy = rs.getString("datey");
                String ds = "0";//rs.getString("dateexp"); Today minus datev
                String prd = rs.getString("prd");
                //System.out.println("prd: " + prd);
                String cnmc = rs.getString("cnmc");
                String cnmc2 = rs.getString("cnmc2");
                String cnmc3 = rs.getString("cnmc3");
                String cnmc4 = rs.getString("cnmc4");
                String kyy = rs.getString("kyy");
                try {
                    java.util.Date datev = new java.util.Date();
                    Format formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String datevv = formatter.format(datev);
                    LocalDate d1 = LocalDate.parse(d, DateTimeFormatter.ISO_LOCAL_DATE);
                    LocalDate d2 = LocalDate.parse(datevv, DateTimeFormatter.ISO_LOCAL_DATE);
                    Duration diff = Duration.between(d1.atStartOfDay(), d2.atStartOfDay());
                    long diffDays = diff.toDays();
                    ds = "" + diffDays;
                    //System.out.println("ds: " + ds + "," + d + "," + datevv);
                } catch (Exception e) {
                }
                String user_system_id = rs.getString("user_system_id");
                String user_system_status = rs.getString("user_system_status");
                String user_system_subscr = rs.getString("user_system_subscr0");
                String user_system_rdys = rs.getString("user_system_rdys0");
                String user_system_subscr_day = rs.getString("user_system_subscr_day0");
                String user_system_subscr_e = rs.getString("user_system_subscr_e0");
                String user_system_rdys_e = rs.getString("user_system_rdys_e0");
                String user_system_subscr_day_e = rs.getString("user_system_subscr_day_e0");
                //System.out.println("user_system_subscr_day: " + user_system_subscr_day);
                //System.out.println("user_system_rdys1: " + user_system_rdys);
                try {
                    String aa = ec.dec(user_system_subscr_day_e);
                    user_system_subscr_day_e = aa;
                } catch (Exception e) {
                }
                //System.out.println("a0: " + user_system_subscr);
                user_system_subscr = "" + vls.minIntV(ec.encdecsub(user_system_subscr, "d"), ec.encdecsub(user_system_subscr_e, "d"));
                user_system_rdys = vls.minIntV(ec.encdecsub(user_system_rdys, "d"), ec.encdecsub(user_system_rdys_e, "d"));
                user_system_subscr_day = user_system_subscr_day == null || user_system_subscr_day.trim().length() == 0 || user_system_subscr_day.equalsIgnoreCase("null") ? "0" : ec.dec(user_system_subscr_day);//vls.minIntV(ec.encdecsub(user_system_subscr_day, "d"), user_system_subscr_day_e);
                String user_system_subscr_daya = user_system_subscr_day;
                String user_system_subscr_day2 = user_system_subscr_daya;//vls.minIntV2(user_system_subscr_daya, user_system_subscr_day_e);
                //System.out.println("Subscription: " + user_system_subscr + "," + user_system_subscr_day + "," + user_system_rdys);

                try {
                    String usrsystsubdyj = user_system_rdys;
                    user_system_rdys = usrsystsubdyj;
                } catch (Exception e) {
                }
                try {
                    String usrsystsubdy = user_system_subscr_day;
                    user_system_subscr_day = usrsystsubdy;
                } catch (Exception e) {
                }
                //System.out.println("user_system_subscr_day2: " + user_system_subscr_day);
                //System.out.println("user_system_rdys2: " + user_system_rdys);
                //110
                k[0] = s;//ky
                k[1] = d;//date
                k[2] = chky(s, d);//validation date are kept in sts as letter; datev as original date if changed invalidate
                k[4] = "" + i;
                k[5] = ec.dec(cnmc) + ec.dec(cnmc2) + ec.dec(cnmc3) + ec.dec(cnmc4);
                k[6] = user_system_id;
                k[7] = "1";// chkStatus(user_system_status, user_system_subscr, user_system_rdys, user_system_subscr_day, user_system_subscr_day_e);
                k[8] = user_system_subscr.equalsIgnoreCase("0") ? "4" : user_system_subscr;
                //Data de subscricao, primeira vez, cada mes acrescenta-se 1 nos dias que se multiplica com 30. ao completar 99 deve se voltar para 1.
                k[10] = user_system_subscr_day;
                k[11] = kyy;

                String usrsysdys = (user_system_rdys == null || user_system_rdys.trim().length() == 0 || user_system_rdys.equalsIgnoreCase("null")) ? "-100" : user_system_rdys;
                int usrsysd = 0;
                int usrsysdys2 = 0;
                try {
                    int kj = Integer.parseInt(usrsysdys);
                    usrsysdys2 = kj;
                } catch (Exception e) {
                }
                /*if (usrsysdys2 == 0) {
                    usrsysd = 7;
                } else {
                    usrsysd = usrsysdys2 * 31;
                }*/
                //Treating subscriptiond date
                if (dy == null || dy.trim().length() == 0 || dy.equalsIgnoreCase("null")) {
                    dy = "2000-01-01";
                }
                java.util.Date datevsbscr = new java.util.Date();
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    datevsbscr = formatter.parse("" + dy);
                } catch (Exception e) {
                }
                int user_system_subscr_dayint = 0;
                try {
                    int usrsubid = Integer.parseInt(user_system_subscr_day);
                    user_system_subscr_dayint = usrsubid * 30;
                    //System.out.println("d: " + user_system_subscr_dayint + ", datevsb: " + datevsbscr);
                } catch (Exception e) {
                }
                Calendar csbscr = Calendar.getInstance();
                csbscr.setTime(datevsbscr);
                csbscr.add(Calendar.DATE, user_system_subscr_dayint);
                user_system_subscr_day = "" + csbscr.getTime();
                /*All process ignored, user_system_subscr_day is date given direct when renew subscription */

                //End of treating subscription date
                //System.out.println("u1: " + user_system_subscr_day2 + "," + usrsysdys + "," + user_system_rdys);
                k[9] = "" + days_remaining(user_system_subscr_day2, usrsysdys);

                int prdd = 0;
                int dss = 0;
                try {
                    prdd = Integer.parseInt(prd);
                } catch (Exception e) {
                    prdd = 0;
                }
                try {
                    dss = Integer.parseInt(ds);
                } catch (Exception e) {
                    dss = 0;
                }
                //System.out.println("P1: " + prdd +","+ dss);
                int tm = 0;
                if (prdd == 0) {
                    tm = 7;
                } else if (prdd == 1) {
                    tm = 37;
                } else {
                    tm = prdd * 30;
                    tm = tm + 7;
                }
                int tme = dss - tm;
                //System.out.println("P2: " + tme + "," + dss + "," + tm);
                //System.out.println("tme: " + tme + ",user_system_subscr_day: " + user_system_subscr_day + ",usrsysdys:" + usrsysdys);
                //tme = -1;
                k[3] = "" + tme;//validation
                i = i + 1;
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
        if (i == 0) {
            k[0] = "0";//status
            k[1] = "0";//date
            k[2] = "0";//validation        
            k[3] = "100";//validation 
            k[4] = "0";
            k[5] = "b";
        }
        return k;
    }

    private String chky(String s, String d) {
        String z = "";
        try {
            String w = d.replaceAll(":", "");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll(" ", "");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("0", "a");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("1", "b");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("2", "c");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("3", "d");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("4", "e");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("5", "f");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("6", "g");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("7", "h");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("8", "i");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("9", "j");
            d = w;
        } catch (Exception e) {
        }

        try {
            String jj = s.replaceAll("-", "");
            s = jj;
        } catch (Exception e) {
        }
        try {
            String jj = s.replaceAll(" ", "");
            s = jj;
        } catch (Exception e) {
        }
        try {
            String jj = s.replaceAll(":", "");
            s = jj;
        } catch (Exception e) {
        }
        try {
            String jj = s.replaceAll("\\.", "");
            s = jj;
        } catch (Exception e) {
        }

        try {
            String jj = d.replaceAll("-", "");
            d = jj;
        } catch (Exception e) {
        }
        try {
            String jj = d.replaceAll(" ", "");
            d = jj;
        } catch (Exception e) {
        }
        try {
            String jj = d.replaceAll(":", "");
            d = jj;
        } catch (Exception e) {
        }
        try {
            String jj = d.replaceAll("\\.", "");
            d = jj;
        } catch (Exception e) {
        }
        //System.out.println("sd: " + s + "," + d);
        if (s.contains(d)) {
            z = "1";
        } else {
            z = "0";
        }
        return z;//1: aproved, 0: not aproved. sts come in letters. Validation date are kept in sts as letter; datev as original date if changed invalidate
    }

    private String ConToValKey(String k, String c, String sb) {
        String krst = "";
        try {
            SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
            URL url = new URL(sb + "pds.php?k=" + k + "&cnmc=" + c + "&vrsn=" + versionapp() + "&ap=" + Strngs.app_category);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(sslsocketfactory);
            InputStream inputstream = conn.getInputStream();
            InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
            BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
            //System.out.println("c2");
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                //System.out.println("Received " + string);
                krst += string;
            }
        } catch (MalformedURLException e) {
            return "a";//IOException
        } catch (IOException e) {
            return "a";//
        }
        return krst;
    }

    private String ConToValKey2(String k, String c, String sb) {
        String krst = "";
        String urlParameters = "k=" + k + "&cnmc=" + c + "&vrsn=" + versionapp() + "&ap=" + Strngs.app_category;
        HttpURLConnection connection = null;

        try {
            //Create connection
            URL url = new URL(sb + "pds.php");
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded");

            connection.setRequestProperty("Content-Length",
                    Integer.toString(urlParameters.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");

            connection.setUseCaches(false);
            connection.setDoOutput(true);

            //Send request
            DataOutputStream wr = new DataOutputStream(
                    connection.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.close();

            //Get Response  
            InputStream is = connection.getInputStream();
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(is));
            //System.out.println("c2");
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                //System.out.println("Received2 " + string);
                krst += string;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "a";
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        return krst;
    }

    public String getKeyValidation(String k) {
        try {
            String ke = k.trim();
            k = ke;
        } catch (Exception e) {
        }

        computer_registration c = new computer_registration();
        String dys = keystatus()[3];
        int dyss = 0;
        try {
            dyss = Integer.parseInt(dys);
        } catch (Exception e) {
            dyss = 0;
        }
        /*For test*/
        //if(1 == 1){return "valido";}
        /*End of For test*/
        if (dyss < 0 && !"0".equalsIgnoreCase(keystatus()[4])) {
            return "" + lang.lng(current_lang, "has_an_active_key_this_has_not_been_used_yet") + "";
        }
        String g = "";
        //System.out.println("c1");
        String ss = "";
        ss = ConToValKey(k, c.computer_name_mac_address(), "/");
        if (ss.equalsIgnoreCase("a") || ss.contains("Moved Permanently")) {
            ss = ConToValKey2(k, c.computer_name_mac_address(), "/");
        }

        //System.out.println("c3: " + ss);
        //try{String sj = ss.replaceAll("[^a-zA-Z]+", ""); ss = sj;}catch(Exception e){}
        //try{String sj = ss.replace("\n", "").replace("\r", ""); ss = sj;}catch(Exception e){}
        String[] srst = ss.split("::::");
        String test_rsp = "w";
        try {
            String ttpp = srst[1];
            test_rsp = ttpp.trim();
        } catch (Exception e) {
            return "" + lang.lng(current_lang, "an_error_occurred_please_wait_and_try_again_later") + "!";
        }
        if (test_rsp.equalsIgnoreCase("atualize")) {
            return "atualize";
        }
        String sss = srst[0];
        //System.out.println("Krst: " + srst[1]);
        //if(1 == 1){return "atualize";}
        //System.out.println("ss: " + sss);
        String[] ars = sss.split(",");
        String p = ars[0];
        String d = ars[3];
        String s = ars[1];
        String dsrv = ars[3];
        String dd = d;
        if (s.equalsIgnoreCase("1")) {
            return "usada";
        }
        try {
            String w = d.replaceAll("0", "a");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("1", "b");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("2", "c");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("3", "d");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("4", "e");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("5", "f");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("6", "g");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("7", "h");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("8", "i");
            d = w;
        } catch (Exception e) {
        }
        try {
            String w = d.replaceAll("9", "j");
            d = w;
        } catch (Exception e) {
        }
        String m2 = "";
        String m3 = "";
        String m4 = "";
        String[] mcs = null;
        try {
            mcs = c.computer_name_mac_addresses();
        } catch (SocketException ex) {
        }
        if (mcs == null) {
            m2 = "azzzzzzzzzzw";
            m3 = "azzzzzzzzzzw";
            m4 = "azzzzzzzzzzw";
        } else {
            m2 = mcs[0] == null || mcs[0].trim().length() == 0 ? "azzzzzzzzzzw" : mcs[0];
            m3 = mcs[1] == null || mcs[1].trim().length() == 0 ? "azzzzzzzzzzw" : mcs[1];
            m4 = mcs[2] == null || mcs[2].trim().length() == 0 ? "azzzzzzzzzzw" : mcs[2];
        }
        java.util.Date date_current = new java.util.Date();
        Format formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dia_hoje = formatter.format(date_current);
        String q = "insert into ksts (ky,prd,datev,sts,cnmc,cnmc2,cnmc3,cnmc4,lastu) values ('" + k + "','" + p + "','" + dd + "','" + d + "',"
                + "'" + ec.enc(c.computer_name_mac_address()) + "',"
                + "'" + ec.enc(m2) + "',"
                + "'" + ec.enc(m3) + "',"
                + "'" + ec.enc(m4) + "',"
                + "'" + dia_hoje + "')";
        //System.out.println("p: " + p);
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            if (!r.equalsIgnoreCase("0")) {
                g = "valido";
            }
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return g;
    }

    private String ssacthttps(String k, String idsys, String pwdsys, String sb) {
        String krst = "";
        //System.out.println("id: " + idsys + ", pwdsys: " + pwdsys);
        try {
            SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
            URL url = new URL(sb + "pds.php?q=sessionact&id=" + idsys + "&pwd=" + pwdsys + "&k=" + k);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(sslsocketfactory);
            InputStream inputstream = conn.getInputStream();
            InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
            BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
            //System.out.println("c2");
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                //System.out.println("Received " + string);
                krst += string;
            }
        } catch (MalformedURLException e) {
            //System.out.println("Erro1: " + e.getMessage());
            return "a";//IOException
        } catch (IOException e) {
            //System.out.println("Erro2: " + e.getMessage());
            return "a";//
        }
        return krst;
    }

    private String ssacthttp(String k, String idsys, String pwdsys, String sb) {
        String krst = "";
        String urlParameters = "q=sessionact&id=" + idsys + "&pwd=" + pwdsys + "&k=" + k;
        HttpURLConnection connection = null;

        try {
            //Create connection
            URL url = new URL(sb + "pds.php");
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded");

            connection.setRequestProperty("Content-Length",
                    Integer.toString(urlParameters.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");

            connection.setUseCaches(false);
            connection.setDoOutput(true);

            //Send request
            DataOutputStream wr = new DataOutputStream(
                    connection.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.close();

            //Get Response  
            InputStream is = connection.getInputStream();
            BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(is));
            //System.out.println("c2");
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                //System.out.println("Received2 " + string);
                krst += string;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "a";
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        return krst;
    }

    public String sessionactivation(String idsys, String pwdsys) {
        String a = "";
        String ss = "";
        String k = "";
        String r = "";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select ky from ksts where id = 0");
            while (rs.next()) {
                k = rs.getString("ky");
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
        ss = ssacthttps(k, idsys, pwdsys, "/");
        //System.out.println("ss1: " + ss);
        if (ss.equalsIgnoreCase("a") || ss.contains("Moved Permanently")) {
            ss = ssacthttp(k, idsys, pwdsys, "/");
        }
        //System.out.println("ss2: " + ss);
        String[] z = null;
        try {
            z = ss.split(",");
        } catch (Exception e) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred") + "!</span>";
        }
        try{
            String w = z[1];
        }catch(Exception e){
            return "<span style='color: red;'>" + ss + "!</span>";
        }
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            String q = "update ksts set user_system_id = '" + z[0] + "',user_system_status = '" + z[1]
                    + "',user_system_subscr = '" + ec.encdecsub(z[2], "e")
                    + "',user_system_rdys = '" + ec.encdecsub(z[4], "e")
                    + "',user_system_subscr_day = '" + ec.enc(z[3])
                    + "',user_system_subscr_e = '" + ec.encdecsub(z[2], "e")
                    + "',user_system_rdys_e = '" + ec.encdecsub(z[4], "e")
                    + "',user_system_subscr_day_e = '" + ec.enc(z[3])
                    + "'  where ky = '" + z[5] + "'";
            //System.out.println("q: " + q);
            stmt = con.createStatement();
            r = "" + stmt.executeUpdate(q);
            if (!r.equalsIgnoreCase("0")) {
                ss = "processado com sucesso";
            }
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        if (ss.contains("rocessado com sucesso")) {
            a = "<span style='color: green;'>Processado com sucesso: sessao activada (refresque a p&aacute;gina)!</span>";
        } else {
            a = "<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred") + "!</span>";
        }
        if (!r.equalsIgnoreCase("0")) {
            insert_last_server_contact();
        }
        return a;
    }

    public void last_status_of_user_system(String k, String idsys, String pwdsys) {
        String ss = "";
        String r = "";
        ss = ssacthttps(k, idsys, pwdsys, "/");
        if (ss.equalsIgnoreCase("a") || ss.contains("Moved Permanently")) {
            ss = ssacthttp(k, idsys, pwdsys, "/");
        }
        //System.out.println("ss: " + ss + ",id: " + idsys + ", pwd: " + pwdsys + ", k: " + k);
        String[] z = null;
        try {
            z = ss.split(",");
        } catch (Exception e) {
            return;
        }
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            String q = "update ksts set user_system_id = '" + z[0] + "',user_system_status = '" + z[1] + "',user_system_subscr = '"
                    + ec.encdecsub(z[2], "e") + "'," + "user_system_rdys = '" + ec.encdecsub(z[4], "e") + "',"
                    + "user_system_subscr_day = '" + ec.enc(z[3]) + "'"
                    + ",user_system_subscr_e = '" + ec.encdecsub(z[2], "e") + "'"
                    + ",user_system_rdys_e = '" + ec.encdecsub(z[4], "e") + "'"
                    + ",user_system_subscr_day_e = '" + ec.enc(z[3]) + "'"
                    + " where ky = '" + z[5] + "'";
            stmt = con.createStatement();
            //System.out.println("r: " + r + ",q: " + q);
            r = "" + stmt.executeUpdate(q);
            //System.out.println("r: " + r + ",q: " + q);
            if (!r.equalsIgnoreCase("0")) {
                ss = "processado com sucesso";
            }
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        if (!r.equalsIgnoreCase("0")) {
            insert_last_server_contact();
        }
    }

    public boolean activeduser() {
        int a = 1;
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            String q = "select count(*) as act_count from users where status = '1'";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                a = rs.getInt("act_count");
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
        //String c = encdecsub(keystatus()[8], "d");
        String c = keystatus()[8];
        int cc = 1;
        try {
            int j = Integer.parseInt(c);
            cc = j;
        } catch (Exception e) {
        }
        //System.out.println("a: " + a + "," + cc);
        return a <= cc;
    }

    private String chkStatus(String st, String sb, String dy, String us_sub_d, String us_sub_d_e) {
        String w = "1";
        int sb1 = sb == null || sb.length() == 0 ? 0 : sb.length();
        int dy1 = dy == null || dy.length() == 0 ? 0 : dy.length();
        int us_sub_d1 = us_sub_d == null || us_sub_d.length() == 0 ? 0 : us_sub_d.length();
        /*if (sb == null || sb.trim().length() == 0 || sb.equalsIgnoreCase("0")) {
        } else if (sb1 != 110) {
            st = "0";
        }
        if (dy == null || dy.trim().length() == 0 || dy.equalsIgnoreCase("0")) {
        } else if (dy1 != 110) {
            st = "0";
        }
        if (us_sub_d == null || us_sub_d.trim().length() == 0 || us_sub_d.equalsIgnoreCase("0")) {
        } else if (us_sub_d1 != 110) {
            st = "0";
        }*/
        if (us_sub_d == null || us_sub_d.trim().length() == 0) {
            us_sub_d = "_";
        }
        if (us_sub_d_e == null || us_sub_d_e.trim().length() == 0) {
            us_sub_d_e = "_";
        }
        if (!us_sub_d.equalsIgnoreCase(us_sub_d_e)) {
            w = "0";
        }
        return w;
    }

    private String days_remaining(String sys_day, String dys) {
        if (dys.equalsIgnoreCase("-100")) {
            return dys;
        }
        String d = "0";
        Date dated_end = new Date();
        Date dated_start = new Date();
        DateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy");
        DateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat formatter3 = new SimpleDateFormat("yyyy-MM-dd");
        if (sys_day.trim().length() == 10) {
            try {
                dated_start = formatter2.parse("" + sys_day);
            } catch (ParseException ee) {
                //System.out.println("ex: " + ee.getMessage());
            }
        } else {
            try {
                dated_start = formatter.parse("" + sys_day);
            } catch (ParseException ex) {
                //System.out.println("ex: " + ex.getMessage());

            }
        }
        long diffDays = 0;
        try {
            String datestart = formatter2.format(dated_start);
            String dateend = formatter3.format(dated_end);
            //System.out.println("dated_start.getTime(): " + datestart);
            //System.out.println("dated_end.getTime(): " + dateend);
            LocalDate d1 = LocalDate.parse(datestart, DateTimeFormatter.ISO_LOCAL_DATE);
            LocalDate d2 = LocalDate.parse(dateend, DateTimeFormatter.ISO_LOCAL_DATE);
            Duration diff = Duration.between(d1.atStartOfDay(), d2.atStartOfDay());
            diffDays = diff.toDays();
            //System.out.println("ds: " + diffDays + "," + datestart + "," + dateend);
        } catch (Exception e) {
        }
        /*if (diffDays < 0) {
            diffDays = 0;
        }*/
        //System.out.println("diff: " + diffDays);
        //System.out.println("diffDays: " + diffDays);
        int dys2 = 0;
        try {
            int kj = Integer.parseInt(dys);
            dys2 = kj * 30;
        } catch (Exception e) {
        }
        //System.out.println("diffDays: " + diffDays + ", dys: " + dys2 + "," + sys_day);
        dys2 = (int) (diffDays - dys2);
        //System.out.println("dys2: " + dys2);
        d = "" + dys2;
        return d;
    }

    public boolean usersession(String u, String pwrd) {
        boolean s = false;
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select password from users where username = '" + u + "'");
            while (rs.next()) {
                String z = rs.getString("password");
                z = ec.dec(z);
                // System.out.println("psd: " + u + "," + pwrd + "," + z);
                if (z.equalsIgnoreCase(pwrd)) {
                    s = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException eb) {
                //  System.out.println("" + eb.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return s;
    }

    public void updateDate() {
        java.util.Date date_current = new java.util.Date();
        Format formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dia_hoje = formatter.format(date_current);
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate("update ksts set lastu = '" + dia_hoje + "' where CAST(lastu AS DATE) < CURRENT_DATE or lastu is NULL");
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            //System.out.println("Rst: " + r);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
    }

    public String DataDB() {
        String s = "";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select id," + vls.dtfrmt("lastu") + " as lastu from ksts order by id desc limit 1");
            while (rs.next()) {
                s = rs.getString("lastu");
                //System.out.println("s: " + s + ", id=" + rs.getString("id"));
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
        return s;
    }

    public String[] prvls(String usr) {
        String[] s = new String[3];
        //System.out.println("usr: " + usr);
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select id,roles,category from users where username='" + usr + "'");
            while (rs.next()) {
                String z = rs.getString("roles");
                String id = rs.getString("id");
                String c = rs.getString("category");
                s[0] = z;
                s[1] = id;
                s[2] = c;
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
        return s;
    }

    public String logo() {
        String a = "img/logo2.png";
        return a;
    }

    public String versionapp() {
        return "4.20220418";
    }

    public void appversion_update() {
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            stmt.executeUpdate("update appversion_registration set appversion  = '" + versionapp() + "'");
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
    }

    public String getPathIrprt() {
        String g = "";
        try {
            String s = "" + (System.getProperty("user.dir")).replaceAll("bin\\\\", "");
            s = s.replaceAll("bin", "");
            g = s;
        } catch (Exception e) {
            //System.out.println("ee: " + e.getMessage());
        }
        try {
            String s = g.replaceAll("\\\\", "\\");
            g = s;
        } catch (Exception e) {
            //System.out.println("ee: " + e.getMessage());
        }
        return g;
    }

    public String[] getOrgInf() {
        String[] a = new String[7];
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            String q = "select org_name,org_logo,org_location,org_name_rprt,org_logo_rprt,org_location_rprt,lnk_download from organization order by id desc limit 1";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                String rgn = rs.getString("org_name");
                String rglg = rs.getString("org_logo");
                String rlc = rs.getString("org_location");
                String plg = rs.getString("org_logo_rprt");
                String pn = rs.getString("org_name_rprt");
                String plc = rs.getString("org_location_rprt");
                String lnk_download = rs.getString("lnk_download");

                a[0] = (rgn == null || rgn.trim().length() == 0) ? "NA" : rgn;
                try {
                    String wj = rglg.replaceAll("base64_", "base64,");
                    rglg = wj;
                } catch (Exception e) {
                }
                a[1] = (rglg == null || rglg.trim().length() == 0) ? "NA" : rglg;
                a[2] = (rlc == null || rlc.trim().length() == 0) ? "NA" : rlc;
                a[3] = (plg.equalsIgnoreCase("1")) ? "checked" : "";
                a[4] = (pn.equalsIgnoreCase("1")) ? "checked" : "";
                a[5] = (plc.equalsIgnoreCase("1")) ? "checked" : "";
                a[6] = (lnk_download == null || lnk_download.trim().length() == 0) ? "localhost" : lnk_download;
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
        return a;
    }

    public void insert_last_server_contact() {
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            String q = "insert into server_contacts (last_server_contact_date) values (CURRENT_DATE)";
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            //System.out.println("lst_dt: " + r);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }

    }

    public boolean need_to_contact_server() {
        boolean a = true;
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select last_server_contact_date from server_contacts order by id desc limit 1");
            long diffDays = 100;
            while (rs.next()) {
                String lst_serv_cnt_date = rs.getString("last_server_contact_date");
                try {
                    java.util.Date dated_start = new java.util.Date();
                    java.util.Date dated_end = new java.util.Date();
                    DateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
                    dated_start = formatter.parse("" + lst_serv_cnt_date.split(" ")[0]);
                    long diff = dated_end.getTime() - dated_start.getTime();
                    diffDays = diff / (24 * 60 * 60 * 1000);
                    diffDays = Math.abs(diffDays);
                    //System.out.println("diffDays_server_contact: " + diffDays);
                } catch (Exception e) {
                    a = true;
                }
                if (diffDays < 30) {
                    a = false;
                }
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
        return a;
    }

    public String setPreferedLang(String lng) {
        String a = "";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate("update prefered_language set language = '" + lng + "'");
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            a = "" + lang.lng(current_lang, "successfully_changed_to") + "Alterado com sucesso para '" + lng + "'!";
            System.out.println("Lng: " + r);
        } catch (Exception e) {
            a = "" + lang.lng(current_lang, "an_error_has_occurred") + "!";
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return a;
    }
    public boolean atlestoneky() throws SQLException, ClassNotFoundException {
        boolean a = false;
        //System.out.println("d: " + a);
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
            ResultSet rs = stmt.executeQuery("select id from ksts");
            while (rs.next()) {
                a = true;
                //System.out.println("d: " + a);
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
        //System.out.println("d: " + a);
        return a;
    }
    public String send_comments(String hlpid, String hlpnm, String hlptxt, String user, String sector) {
        String krst = "";
        String krst2 = "";
        try {
            try{
                String z = hlptxt.trim();
                hlptxt = z;
            }catch(Exception e){}
            String u = "/=" + hlpid + "&hlpnm=" + hlpnm + "&hlptxt=" + hlptxt + "&user=" + user + "&sector=SM";
            System.out.println("u: " + u);
            SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
            URL url = new URL(u);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(sslsocketfactory);
            InputStream inputstream = conn.getInputStream();
            InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
            BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                System.out.println("Received " + string);
                krst += string;
            }
        } catch (MalformedURLException e) {
            krst2 = "a" + e.getMessage();//IOException
        } catch (IOException e) {
            krst = ",a" + e.getMessage() + "," + krst2;
        }
        return krst;
    }
}
