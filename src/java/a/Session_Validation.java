/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.net.MalformedURLException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InputStream;
import javax.net.ssl.HttpsURLConnection;
import java.net.URL;
import javax.net.ssl.SSLSocketFactory;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Calendar;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Admin
 */
public class Session_Validation {

    private client_session cssn;
    private Values vls;
    private String artcls = "";
    private String logo = "";
    private String sector2 = "";
    private String lnk_disabled = "";
    private String sky = "";
    private String dsbld = "";
    private String dsbld4 = dsbld;
    private String version_status = "";
    private String subsrs_nr = "";
    language lang;
    PreferedLang plng; 
    String current_lang = "";
    
    public Session_Validation(String scrsz) {
        cssn = new client_session();
        vls = new Values();
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
        String krst = "a";
        try {
            SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
            URL url = new URL("vrsn.php?v=amorass");
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setSSLSocketFactory(sslsocketfactory);
            InputStream inputstream = conn.getInputStream();
            InputStreamReader inputstreamreader = new InputStreamReader(inputstream);
            BufferedReader bufferedreader = new BufferedReader(inputstreamreader);
            String string = null;
            while ((string = bufferedreader.readLine()) != null) {
                //System.out.println("Received " + string);
                krst += string;
            }
        } catch (MalformedURLException e) {
            krst = "a";//IOException
        } catch (IOException e) {
            krst = "a";
        }
        /*System.out.println("2");*/
        try {
            String kvsn = krst.trim();
            krst = kvsn;
        } catch (Exception e) {
        }
        version_status = "";
        if (!krst.equalsIgnoreCase("a")) {
            if (!krst.equalsIgnoreCase(cssn.versionapp())) {
                version_status = "<span style='color: green;'>" + lang.lng(current_lang, "new_version_available") + ": " + krst + "!</span><br>";
            }
        }
        int usrstsdys = -100;
        /*System.out.println("3");*/
        computer_registration crgt = new computer_registration();
        sky = "";
        dsbld = "";
        /*artcls = vls.Artcls();*/
        logo = cssn.logo();
        String[] kary = null;
        kary = cssn.keystatus();
        String vlky = kary[2];
        String dys = kary[3];
        String kstss = kary[7];
        subsrs_nr = "<span style='color: #4A235A; font-size: 12px;'><strong>" + lang.lng(current_lang, "subscription") + "</strong>: " 
                + kary[8] + " " + lang.lng(current_lang, "active_users") + " "
                + lang.lng(current_lang, "valid_untill_day") + " " + vls.date_from_days(kary[9]) + "<br>"
                + "<strong>" + lang.lng(current_lang, "application_id") + "</strong>: " + kary[11] + "</span><br>";
        int dyss = 0;
        try {
            dyss = Integer.parseInt(dys);
        } catch (Exception e) {
            dyss = 0;
        }
        //System.out.println("dyss: " + dyss); 
        if (vlky.equalsIgnoreCase("0")) {
            sky = "<div style='color: red; width: 100%;'>100: " 
                    + lang.lng(current_lang, "you_don't_have_a_valid_key_to_use_the_system_buy_it_you_can_opt_for_a_key_or_join_a_subscription") 
                    + ". " + lang.lng(current_lang, "click_on_the") + " <a href='/SGRB/Page2.jsp'>link</a> " + lang.lng(current_lang, "to_insert_key")
                    + ".</div>";
            dsbld = "disabled";
        } else if (dyss > -10 && dyss < 1) {
            String dch = "";
            String dysst = "" + dyss;
            try {
                String jj = dysst.replaceAll("-", "");
                dch = jj;
            } catch (Exception e) {
            }
            sky = "<div style='color: green; width: 100%;'>200: " + lang.lng(current_lang, "the_trial_period_ends_in") + " " 
                    + dch + " " + lang.lng(current_lang, "days_to_continue_using_the_system_buy_a_key_you_can_choose_a_key_or_join_a_subscription") 
                    + ".</div>";
        }
        try {
            int kusr = Integer.parseInt(kary[9]);
            usrstsdys = kusr;
        } catch (Exception e) {
            usrstsdys = -100;
        }
        /* This first line only for test */
        //dyss = 1;
        //usrstsdys = 10;
        if (dyss > 0 && usrstsdys > -1) {
            cssn.last_status_of_user_system(kary[11], kary[6], "frmsystm");
            try {
                int kusr = Integer.parseInt(kary[9]);
                usrstsdys = kusr;
            } catch (Exception e) {
                usrstsdys = -100;
            }
        }
        //System.out.println("uk: " + usrstsdys + "," + kary[9] + "");            
        if (dyss > 0) {
            if (usrstsdys > -1) {
                sky = "<div style='color: red; width: 100%;'>300: " 
                        + lang.lng(current_lang, "the_subscription_period_has_ended_you_can_proceed_with_the_payment_to_continue_using_the_system") 
                        + ".</div>";
                dsbld = "disabled";
            } else if (usrstsdys > -6) {
                /*Advise for subscription payment */
                sky = "<div style='color: green; width: 100%;'>400: " 
                        + lang.lng(current_lang, "the_subscription_period_ends_in") + " " + usrstsdys 
                        + " " + lang.lng(current_lang, "days_you_can_proceed_with_the_payment") + ".</div>";
            } else if (usrstsdys < -5 && usrstsdys != -100) {
            } else {
                sky = "<div style='color: red; width: 100%;'>500: " 
                        + lang.lng(current_lang, "the_usage_period_is_over_to_continue_using_the_system_buy_a_key_you_can_opt_for_a_key_or_join_a_subscription")
                        + ". " + lang.lng(current_lang, "click_on_the") + " <a href='/SGRB/Page2.jsp'>link</a>"
                        + " " + lang.lng(current_lang, "to_insert_key") + ".</div>";
                if (usrstsdys == -100) {
                    sky = "<div style='color: red; width: 100%;'>500: " 
                            + lang.lng(current_lang, "the_usage_period_is_over_to_continue_using_the_system_buy_a_key_you_can_opt_for_a_key_or_join_a_subscription") 
                            + ". " + lang.lng(current_lang, "click_on_the") + " <a href='/SGRB/Page2.jsp'>link</a>"
                            + " " + lang.lng(current_lang, "to_insert_key") + ".</div>";
                }
                dsbld = "disabled";
            }
        }
        /*System.out.println("4");*/
        String crgtt = crgt.computer_name_mac_address();
        String cnmc = cssn.keystatus()[5];
        if (crgtt == null || crgtt.trim().length() == 0) {
            crgtt = "aaaaaaaaaaabbbbbbbbbbbbzzzzzzzzzzzzzwwwwwwwwwwwyyyyyyyyyyyyy";
        }
        if (cnmc == null || cnmc.trim().length() == 0) {
            cnmc = "sssssssssssssggggggggggggggggqqqqqqqqqqqqqqqqjjjjjjjjjjjjjjjj";
        }
        /*System.out.println("cnmc: " + cnmc);
            System.out.println("crgtt: " + crgtt);*/
        if (!(cnmc.toUpperCase()).contains(crgtt.toUpperCase())) {
            sky = "<div style='color: red; width: 100%;'>600: " 
                    + lang.lng(current_lang, "the_key_must_only_be_used_for_one_server_and_several_computers") 
                    + ". " + lang.lng(current_lang, "click_on_the") + " <a href='/SGRB/Page2.jsp'>link</a> " 
                    + lang.lng(current_lang, "to_insert_key") 
                    + ".</div>";
            dsbld = "disabled";
        }
        java.util.Date date = new java.util.Date();
        Format formatter = new SimpleDateFormat("yyyy-MM-dd");
        String datenow = formatter.format(date);
        String datadb = cssn.DataDB();

        int dtdatanow = 0;
        int dtdatadb = 0;
        try {
            int jz = Integer.parseInt(datenow.replaceAll("-", ""));
            dtdatanow = jz;
        } catch (Exception e) {

        }
        try {
            int jz = Integer.parseInt(datadb.replaceAll("-", ""));
            dtdatadb = jz;
        } catch (Exception e) {

        }

        int expdate = 0;
        int expdate2 = 0;
        int lmtdy = 20221220;
        int lmtdy2 = 0;
        formatter = new SimpleDateFormat("yyyyMMdd");
        try {
            int expj = Integer.parseInt("" + formatter.format(date));
            expdate = expj;
        } catch (Exception e) {
        }
        java.util.Date date2 = new java.util.Date();
        DateFormat formatter2 = new SimpleDateFormat("yyyyMMdd");
        try {
            date2 = formatter2.parse("" + lmtdy);
        } catch (ParseException ex) {
            Logger.getLogger(Session_Validation.class.getName()).log(Level.SEVERE, null, ex);
        }
        Calendar c = Calendar.getInstance();
        c.setTime(date2);
        c.add(Calendar.DATE, -96);
        date2 = c.getTime();
        try {
            int expk = Integer.parseInt("" + formatter.format(date2));
            lmtdy2 = expk;
        } catch (Exception e) {
        }
        /*Depois comentar, apenas para testar o tempo de expiracao
            lmtdy = lmtdy2;
            System.out.println("lmtdy: " + lmtdy);
            Fim de tempo de expiracao*/
        expdate2 = expdate + 10;
        int expdys = lmtdy - expdate;
        if (expdate2 > lmtdy) {
            if (sky == null || sky.trim().length() == 0) {
                sky = "<div style='color: green; width: 100%;'>800: " 
                        + lang.lng(current_lang, "update_the_system_by_downloading_a_new_version_from_the") 
                        + " /, " + lang.lng(current_lang, "in") + " " 
                        + expdys + " " + lang.lng(current_lang, "will_be_limited") + ".</div>";
            }
        }
        if (expdate > lmtdy) {
            sky = "<div style='color: red; width: 100%;'>900: " 
                    + lang.lng(current_lang, "update_the_system_by_downloading_a_new_version_from_the")
                    + " /, "
                    + "o sistema esta limitado.</div>";
            dsbld = "disabled";
        }
        if (kstss.equals("0")) {
            sky = "<div style='color: red; width: 100%;'>1000: " 
                    + lang.lng(current_lang, "there_is_an_inconsistency_in_the_system_validation_parameters") 
                    + ". " + lang.lng(current_lang, "click_on_the") + " <a href='/SGRB/Page2.jsp'>link</a> "
                    + "" + lang.lng(current_lang, "to_insert_key") + ".</div>";
            dsbld = "disabled";
        }
        //System.out.println("d: " + dtdatanow +","+ dtdatadb);
        int cmpdts = dtdatanow - dtdatadb;
        if (cmpdts > 1 || cmpdts < -1) {
            sky = "<div style='color: red; width: 100%;'>700: " 
                    + lang.lng(current_lang, "there_was_a_problem_with_the_dates_on_your_computer") 
                    + ".</div>";
            dsbld = "disabled";
        }
        if (dsbld.equalsIgnoreCase("disabled")) {
            lnk_disabled = "a {pointer-events:none;}";
        }
        dsbld4 = dsbld;
        if (dsbld == null || dsbld.trim().length() == 0) {
            dsbld4 = "a";
        }
        //System.out.println("D: " + dtdatanow + "," + dtdatadb);
        /*sky = "<div style='color: red; width: 100%;'>Teste...</div>";*/
    }

    public String getArtcls() {
        return artcls;
    }

    public String getLogo() {
        return logo;
    }

    public String getSector2() {
        return sector2;
    }

    public String getLnk_disabled() {
        return lnk_disabled;
    }

    public String getSky() {
        return sky;
    }

    public String getDsbld() {
        return dsbld;
    }

    public String getDsbld4() {
        return dsbld;
    }

    public String getVersion_status() {
        return version_status;
    }

    public String getSubsrs_nr() {
        return subsrs_nr;
    }

    public String getSky2() {
        String sky2 = "";
        try {
            String ssky = sky.substring("<div style='color: red; width: 100%;'>".length());
            /*String ssky = sky.replaceAll("[^a-zA-Z0-9]",""); Remove all special characters*/
            ssky = ssky.replaceAll("</div>", "");
            sky2 = ssky;
        } catch (Exception e) {
            //System.out.println(e.getMessage());
        }
        return sky2;
    }
}
