/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import ed.encr;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class Values {

    private Connection con = null;
    private Statement stmt = null;
    ArrayList<String> PAlst;
    HttpSession sessao;
    directories_mngmnt dirmng;
    language lang;
    String current_lang = "";
    PreferedLang plng;
    encr ec;
    Transformations trnsf;

    public Values() {
        ec = new encr();
        dirmng = new directories_mngmnt();
        PAlst = new ArrayList<String>();
        get_lng_file glng = new get_lng_file();
        trnsf = new Transformations();
        try {
            lang = new language(glng.getlngs());
        } catch (IOException ex) {

        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
    }

    public String Artcls(String p, String t, String q) {
        //System.out.println("p: " + p + ",t: " + t + ",q: " + q);
        String b = "";
        String d = "";
        String c = "";
        if (t.equalsIgnoreCase("a")) {
            d = "select product from prices_sales where category = '" + p + "' and removed = 0";
            c = "product";
        } else if (t.equalsIgnoreCase("b")) {
            d = "select price from prices_sales where product = '" + p + "' and removed = 0 order by id desc limit 1";
            c = "price";
        }
        try {

            con = cdb.getConnection();
            if (con == null) {
                return "Servidor ocupado. Tente mais tarde!";
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(d);
            while (rs.next()) {
                String z = rs.getString(c);
                if (t.equalsIgnoreCase("b")) {
                   b = z;
                   try {
                        String zz = b.replaceAll(",", "");
                        b = zz;
                   } catch (Exception e) {
                   }
                   break;
                } else {
                   b += z + ",";
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
        if (t.equalsIgnoreCase("b")) {
            //System.out.println("b: " + b + "," + p + "," + q);
            if (t.equalsIgnoreCase("b")) {
                try {
                    String z = b.replaceAll(",", "");
                    b = z;
                } catch (Exception e) {
                }
            }
            double qq = 0.00;
            double pp = 0.00;
            try {
                double p1 = Double.parseDouble(b);
                qq = p1;
            } catch (Exception e) {
            }
            try {
                double q1 = Double.parseDouble(q);
                pp = q1;
            } catch (Exception e) {
            }
            double pf = (double) ((double) qq * (double) pp);
            //System.out.println("b: " + b + "," + pp + "," + qq + "," + pf);
            b = trnsf.NumberToDecimal("" + pf);
        }
        return b;
    }

    public String dshtbls(String tbl, String vl) {
        String a = "";
        if (tbl.equalsIgnoreCase("purchases")) {
            tbl = "Compras";
        } else if (tbl.equalsIgnoreCase("expenses")) {
            tbl = "Despesas";
        } else if (tbl.equalsIgnoreCase("sales")) {
            tbl = "Vendas";
        }
        a = "<td style='width: 10px;'></td><td>"
                + "<table style='border-radius: 16px;'>"
                + "<tr>"
                + "<td style='background-color: #A9CCE3;font-size: 16px; color: white;'>" + tbl + "</td>"
                + "<td style='font-size: 28px;'>" + vl + "</td>"
                + "</tr>"
                + "</table>"
                + "</td>";
        return a;
    }

    public String productslst() {
        String s = "";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select product from prices_sales where removed=0");
            while (rs.next()) {
                String z = rs.getString("product");
                s += "<option>" + z + "</option>";
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

    public String productslst2() {
        String s = "";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select product from products_purchases where removed=0");
            while (rs.next()) {
                String z = rs.getString("product");
                s += "<option>" + z + "</option>";
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

    public String groupslst() {
        String s = "";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select distinct factory from groups_factories");
            while (rs.next()) {
                String z = rs.getString("factory");
                s += "<option>" + z + "</option>";
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

    public String ms_total() {
        String s = "";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select total as ms_total from ms order by id desc limit 1");
            while (rs.next()) {
                s = rs.getString("ms_total");
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
        int si = 0;
        s = (s == null || s.trim().length() == 0) ? "10" : s;
        try {
            int j = Integer.parseInt(s);
            si = j;
        } catch (Exception e) {
        }
        if (si < 2) {
            s = "2";
        } else if (si > 50) {
            s = "50";
        }
        return s;
    }

    public String[] CatWithData() {
        String[] c = new String[5];
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            int i = 0;
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select distinct sector from prices_sales");
            while (rs.next()) {
                c[i] = rs.getString("sector");
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
        return c;
    }

    public String list_prod_ctgry(String lstprdnm, String sctr, String prv) {
        String est = "";
        PAlst = getProdPrz();
        if (prv.equalsIgnoreCase("est")) {
            est = "<th style=\"height: 46px; background-color:  red;background: linear-gradient(to bottom, red, white);\">Prazo</th>"
                    + "<th style=\"height: 46px; background-color:  orange;background: linear-gradient(to bottom, orange, white);\">Prazo10</th>"
                    + "<th style=\"height: 46px; background-color:  yellow;background: linear-gradient(to bottom, yellow, white);\">Prazo25</th>"
                    + "<th style=\"height: 46px; background-color:  green;background: linear-gradient(to bottom, green, white);\">Prazo60</th>";
        }
        String r = "<table id='" + lstprdnm + "' border='1'>"
                + "<tr style=\"height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);\">"
                + "<th>" + lang.lng(current_lang, "category") + "</th>"
                + "<th>" + lang.lng(current_lang, "group") + "</th>"
                + "<th>" + lang.lng(current_lang, "article") + "</th>"
                + "<th>" + lang.lng(current_lang, "price") + "</th>"
                + "<th>Stock</th><th>" + lang.lng(current_lang, "prod_code") + "</th><th>" + lang.lng(current_lang, "bar_code") + "</th>"
                + "                                    " + est + "</tr>";
        try {

            con = cdb.getConnection();
            if (con == null) {
            }
            String q = "";
            if (prv.equalsIgnoreCase("est")) {
                String prz10 = "";
                String prz25 = "";
                String prz60 = "";
                String todaypls1 = "";
                java.util.Date date_current_plus_1 = new java.util.Date();
                java.util.Date date_current_plus_10 = new java.util.Date();
                java.util.Date date_current_plus_25 = new java.util.Date();
                java.util.Date date_current_plus_60 = new java.util.Date();
                
                Calendar c1 = Calendar.getInstance();
                c1.setTime(date_current_plus_1);
                c1.add(Calendar.DATE, 1);
                date_current_plus_1 = c1.getTime();

                Calendar c10 = Calendar.getInstance();
                c10.setTime(date_current_plus_10);
                c10.add(Calendar.DATE, 10);
                date_current_plus_10 = c10.getTime();

                Calendar c25 = Calendar.getInstance();
                c10.setTime(date_current_plus_25);
                c10.add(Calendar.DATE, 25);
                date_current_plus_25 = c25.getTime();

                Calendar c60 = Calendar.getInstance();
                c10.setTime(date_current_plus_60);
                c10.add(Calendar.DATE, 60);
                date_current_plus_60 = c60.getTime();

                SimpleDateFormat frmt_string_to_date = new SimpleDateFormat("yyyy-MM-dd");
                todaypls1 = "" + frmt_string_to_date.format(date_current_plus_1);
                prz10 = "" + frmt_string_to_date.format(date_current_plus_10);
                prz25 =  "" + frmt_string_to_date.format(date_current_plus_25);
                prz60 =  "" + frmt_string_to_date.format(date_current_plus_60);
                
                q = "select prices_sales.group_factory as group_factory,prices_sales.category as category,"
                        + "prices_sales.product as product,prices_sales.price as price,"
                        + "(select sum(stock) from vstock2 where prices_sales.product = vstock2.article) as stock "
                        + ",prices_sales.p_code as p_code,prices_sales.barcode as barcode,"
                        + "(select sum(vq.quantity)-sum(vq.quant_saled) from purchases vq where prices_sales.product = vq.article and " 
                        + " CAST(vq.comp_prz AS DATE) < CURRENT_DATE and vq.removed = 0 and vq.sector = '" + sctr + "')"
                        + " as prazo,"
                        + "(select sum(vq.quantity)-sum(vq.quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > CAST('" + todaypls1 + "' AS DATE) and "
                        + " CAST('" + prz10 + "' AS DATE) < CURRENT_DATE"
                        + " and vq.removed = 0 and vq.sector = '" + sctr + "')"
                        + " as prazo10,"
                        + "(select sum(vq.quantity)-sum(vq.quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > CAST('" + todaypls1 + "' AS DATE) and "
                        + " CAST('" + prz25 + "' AS DATE) < CURRENT_DATE"
                        + "  and vq.removed = 0 and vq.sector = '" + sctr + "')"
                        + " as prazo25,"
                        + "(select sum(vq.quantity)-sum(vq.quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > CAST('" + todaypls1 + "' AS DATE) and "
                        + " CAST('" + prz60 + "' AS DATE)< CURRENT_DATE"
                        + "  and vq.removed = 0 and vq.sector = '" + sctr + "')"
                        + " as prazo60 "
                        + " from prices_sales left join vstock2 "
                        + " on prices_sales.product = vstock2.article left join purchases vq on prices_sales.product = vq.article"
                        + " where prices_sales.removed = 0 and "
                        + " prices_sales.sector = '" + sctr + "' group by prices_sales.product,prices_sales.group_factory,"
                        + " prices_sales.category,prices_sales.price,(select sum(stock) from vstock2 where prices_sales.product = vstock2.article),"
                        + " prices_sales.p_code,prices_sales.barcode";
                //+ " order by prices_sales.category";
                /*q = "select prices_sales.group_factory as group_factory,prices_sales.category as category,"
                        + "prices_sales.product as product,prices_sales.price as price,"
                        + "(select sum(stock) from vstock2 where prices_sales.product = vstock2.article) as stock "
                        + ",prices_sales.p_code as p_code,prices_sales.barcode as barcode,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) < CURRENT_DATE and vq.removed = 0) as prazo,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > (CURRENT_DATE + 1) and "
                        + " (CAST(vq.comp_prz AS DATE) + 10) < CURRENT_DATE"
                        + " and vq.removed = 0)"
                        + " as prazo10,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > (CURRENT_DATE + 1) and "
                        + " (CAST(vq.comp_prz AS DATE) + 25) < CURRENT_DATE"
                        + "  and vq.removed = 0)"
                        + " as prazo25,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " CAST(vq.comp_prz AS DATE) > (CURRENT_DATE + 1) and "
                        + " (CAST(vq.comp_prz AS DATE) + 60) < CURRENT_DATE"
                        + "  and vq.removed = 0)"
                        + " as prazo60 "
                        + " from prices_sales left join vstock2 "
                        + " on prices_sales.product = vstock2.article "
                        + " where prices_sales.removed = 0 and "
                        + " prices_sales.sector = '" + sctr + "' order " // group by prices_sales.product 
                        + " by prices_sales.category";*/
 /*
                                q = "select prices_sales.group_factory as group_factory,prices_sales.category as category,"
                        + "prices_sales.product as product,prices_sales.price as price,"
                        + "(select sum(stock) from vstock2 where prices_sales.product = vstock2.article) as stock "
                        + ",prices_sales.p_code as p_code,prices_sales.barcode as barcode,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " DATE(vq.comp_prz) < DATE(NOW()) and vq.removed = 0) as prazo,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " DATE(vq.comp_prz) > DATE(DATE_SUB(NOW(), INTERVAL 1 DAY)) and DATE(DATE_SUB(vq.comp_prz, INTERVAL 10 DAY)) < DATE(NOW())"
                        + "  and vq.removed = 0)"
                        + " as prazo10,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " DATE(vq.comp_prz) > DATE(DATE_SUB(NOW(), INTERVAL 1 DAY)) and DATE(DATE_SUB(vq.comp_prz, INTERVAL 25 DAY)) < DATE(NOW())"
                        + "  and vq.removed = 0)"
                        + " as prazo25,"
                        + "(select sum(quantity)-sum(quant_saled) from purchases vq where prices_sales.product = vq.article and "
                        + " DATE(vq.comp_prz) > DATE(DATE_SUB(NOW(), INTERVAL 1 DAY)) and DATE(DATE_SUB(vq.comp_prz, INTERVAL 60 DAY)) < DATE(NOW())"
                        + "  and vq.removed = 0)"
                        + " as prazo60 "
                        + " from prices_sales left join vstock2 "
                        + " on prices_sales.product = vstock2.article "
                        + " where prices_sales.removed = 0 and "
                        + " prices_sales.sector = '" + sctr + "' order " // group by prices_sales.product 
                        + " by prices_sales.category";

                 */
            } else {
                q = "select prices_sales.group_factory as group_factory,prices_sales.category as category,"
                        + "prices_sales.product as product,prices_sales.price as price,"
                        + "(select sum(stock) from vstock2 where prices_sales.product = vstock2.article) as stock "
                        + ",prices_sales.p_code as p_code,prices_sales.barcode as barcode "
                        + " from prices_sales left join vstock2 "
                        + " on prices_sales.product = vstock2.article where prices_sales.removed = 0 and "
                        + " prices_sales.sector = '" + sctr + "' group by prices_sales.product,prices_sales.group_factory,"
                        + " prices_sales.category,prices_sales.price,(select sum(stock) from vstock2 where prices_sales.product = vstock2.article),"
                        + " prices_sales.p_code,prices_sales.barcode "
                        + " order by prices_sales.category";
            }
            //System.out.println("qq: " + q);
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                String stock = rs.getString("stock");
                if (stock == null || stock.trim().length() == 0 || stock.equalsIgnoreCase("null")) {
                    stock = "0";
                }
                r += "<tr>";
                r += "<td>" + rmvSpcChar(rs.getString("category")) + "</td><td>" + rmvSpcChar(rs.getString("group_factory"))
                        + "</td><td>" + "<a href='#' onclick=\"setArticle('" + lstprdnm + "','" + rs.getString("product") + "')\" "
                        + " style='text-decoration: none;'>"
                        + rs.getString("product") + "</a></td><td>" + trnsf.NumberToDecimal(rs.getString("price")) + "</td>"
                        + "<td>" + stock + "</td>"
                        + "<td>" + rmvSpcChar(rs.getString("p_code")) + "</td>"
                        + "<td>" + rmvSpcChar(rs.getString("barcode")) + "</td>";
                if (prv.equalsIgnoreCase("est")) {
                    //r += getVlsFrmPAlst(rs.getString("product"));
                    int prz = rs.getInt("prazo");
                    int prz10 = rs.getInt("prazo10");
                    int prz25 = rs.getInt("prazo25");
                    int prz60 = rs.getInt("prazo60");
                    r += "<td>" + prz + "</td>"
                            + "<td>" + prz10 + "</td>"
                            + "<td>" + prz25 + "</td>"
                            + "<td>" + prz60 + "</td>";
                }
                r += "</tr>";
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
        r += "</table>";
        //System.out.println("r: " + r);
        return r;
    }

    public String articles_update(String sector) {
        String ids = "";
        String r = "<table id='tbartcs' border='1'>"
                + "<tr><th>" + lang.lng(current_lang, "article") + "</th><th>" + lang.lng(current_lang, "group") + "</th>"
                + "<th>" + lang.lng(current_lang, "prod_code") + "</th><th>" + lang.lng(current_lang, "bar_code") + "</th>"
                + "<th>" + lang.lng(current_lang, "price") + "</th><th>" + lang.lng(current_lang, "discount") + "(%)</th>"
                + "<th>" + lang.lng(current_lang, "discount_price") + "</th>"
                + "<th>" + lang.lng(current_lang, "image") + "</th></tr>";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            String q = "select id,group_factory,product,price,p_code,barcode,descount from prices_sales where removed = 0 and sector = '" + sector + "' order by category";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                String dscnt = rs.getString("descount");
                Double prc_dscnt = 0.0;
                if (dscnt == null || dscnt.trim().length() == 0 || dscnt.equalsIgnoreCase("null") || dscnt.equalsIgnoreCase("0")) {
                    dscnt = "0";
                } else {
                    try{
                        int dcnt = Integer.parseInt(dscnt);
                        Double prcc = Double.parseDouble(rs.getString("price"));
                        prc_dscnt = dcnt * prcc * 0.01;
                        prc_dscnt = prcc - prc_dscnt;
                    }catch(Exception ex){
                       dscnt = "0";
                    }
                }
                String prc_dscnt2 = rs.getString("price");
                if(!dscnt.equalsIgnoreCase("0")){
                   prc_dscnt2 = "" + prc_dscnt;
                }
                
                ids += rs.getString("id") + ",";
                r += "<tr>";
                r += "<td>" + rs.getString("product") + "</td>"
                        + "<td><input type=\"text\" id=\"idgrp" + rs.getString("id") + "\" onchange=\"updtArt('idvchng" + rs.getString("id") + "');\" list='lst_gfctry' name=\"idgrp" + rs.getString("id") + "\" value=\"" + rs.getString("group_factory") + "\"></td>"
                        + "<td><input type=\"text\" id=\"idpcod" + rs.getString("id") + "\" onchange=\"updtArt('idvchng" + rs.getString("id") + "');\" name=\"idpcod" + rs.getString("id") + "\" value=\"" + rs.getString("p_code") + "\"></td>"
                        + "<td><input type=\"text\" id=\"idbarcod" + rs.getString("id") + "\" onchange=\"updtArt('idvchng" + rs.getString("id") + "');\" name=\"idbarcod" + rs.getString("id") + "\" value=\"" + rs.getString("barcode") + "\"></td>"
                        + "<td><input type=\"text\" id=\"idprc" + rs.getString("id") + "\" onchange=\"updtArt('idvchng" + rs.getString("id") + "');\" name=\"idprc" + rs.getString("id") + "\" value=\"" + trnsf.NumberToDecimal(rs.getString("price")) + "\"></td>"
                        + "<td><input type=\"text\" id=\"iddesc" + rs.getString("id") + "\" onchange=\"updtArt('idvchng" + rs.getString("id") + "');\" name=\"iddesc" + rs.getString("id") + "\" value=\"" + dscnt + "\"></td>"
                        + "<td>" + trnsf.NumberToDecimal(prc_dscnt2) + "</td>"
                        + "<td><a href=\"#\" onclick=\"upldImg('img" + rs.getString("product") + rs.getString("p_code") + "')\" style=\"text-decoration: none;\">Carrergar</a>"
                        + "<input type=\"hidden\" id=\"idvchng" + rs.getString("id") + "\" name=\"idvchng" + rs.getString("id") + "\" value = \"0\">"
                        + "</td>";

                r += "</tr>";
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
        r += "</table>"
                + "<input type=\"hidden\" id=\"ids\" name=\"ids\" value=\"" + ids + "\">"
                + "<br>"
                + "<datalist id='lst_gfctry'>\n"
                + "<option>" + groupslst() + "</option>"
                + "</datalist>";
        return r;
    }

    public String insert_replace_desiglogloc(String n, String lg, String lc, String cdg, String clg, String clc, String lnk_download, int user_r) {
        String a = "";
        String q = "";

        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            q = "insert into organization (org_name,org_logo,org_location,org_name_rprt,org_logo_rprt,org_location_rprt,lnk_download,user_datetime,iduser) "
                    + " values ('" + n + "','" + lg + "','" + lc + "','" + cdg + "','" + clg + "','" + clc + "','" + lnk_download + "',CURRENT_DATE," + user_r + ")";
            //System.out.println("img: " + q);
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            a = "<span style='color: green;'>Processado com sucesso: " + r + " linhas!</span>";
        } catch (Exception e) {
            a = "<span style='color: red;'>Erro ao processar!</span>";
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

    public String[] artcprzcnt(String vv) {
        String[] s = new String[2];
        boolean rb = false;
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            //System.out.println("vv" + vv);
            String q = "select id,(quantity - quant_saled) as quant_s from purchases where article = '" + vv + "' and quantity > quant_saled "
                    + " and removed = 0 order by id limit 1";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                s[0] = rs.getString("id");
                s[1] = rs.getString("quant_s");
                rb = true;
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
        if (!rb) {
            s[0] = "0";
            s[1] = "0";
        }
        return s;
    }

    public String stock_aloc() {
        String s = "<tr style=\"height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);\">"
                + "<th>" + lang.lng(current_lang, "id") + "</th><th>" + lang.lng(current_lang, "group") + "</th>"
                + "<th>" + lang.lng(current_lang, "type") + "</th><th>" + lang.lng(current_lang, "category") + "</th>"
                + "<th>" + lang.lng(current_lang, "article") + "</th><th>" + lang.lng(current_lang, "the_amount") + "</th>"
                + "<th>" + lang.lng(current_lang, "date") + "</th><th>" + lang.lng(current_lang, "allocate_user") + "</th>"
                + "<th>" + lang.lng(current_lang, "processed") + "</th><th>" + lang.lng(current_lang, "processed_user") + "</th>"
                + "<th>" + lang.lng(current_lang, "destiny") + "</th></tr>";

        String r = "<br><br><strong>Stock por Aloca&ccedil;&atilde;o</strong><br>"
                + "Artigo:<input type=\"text\" id=\"txttblstck0\" onkeyup=\"filbyclnsnr('tblstck0', this.value, 4, 7, 8, 'stk')\" style=\"width: 300px;\"><br>"
                + "<strong>Local: xxxxzzzzzyyyyywwwww</strong><br>"
                + "<table id='tblstck0' border='1'>" + s;
        int i = 0;
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            //System.out.println("vv" + vv); DATE_FORMAT(CAST(sales.user_datetime AS DATE),'%d/%m/%Y')
            String q = "select sales.id as id,sales.group_factory as group_factory,sales.prod_type as prod_type,sales.category as category,"
                    + "sales.article as article,sales.quantity as quantity,"
                    + dtfrmt("sales.user_datetime") + " as user_datetime"
                    + ",sales.aloc_stck_used as aloc_stck_used,"
                    + "sales.aloc_stock_obs as aloc_stock_obs,sales.aloc_stock as aloc_stock,sales.aloc_stck_used_user_rg as aloc_stck_used_user_rg,"
                    + "users.username as iduser from sales left join users on sales.iduser = users.id "
                    + " where sales.price = '0.00' and sales.aloc_stock <> 0 and sales.removed = 0 order by aloc_stock";
            String id = "";
            String group_factory = "";
            String prod_type = "";
            String category = "";
            String article = "";
            String quantity = "";
            String user_datetime = "";
            String aloc_stck_used = "";
            String aloc_stock_obs = "";
            String aloc_stock = "";
            String aloc_stck_used_user_rg = "";
            String iduser = "";
            String c1 = "a";
            String c2 = "a";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                id = rs.getString("id");
                group_factory = rmvSpcChar(rs.getString("group_factory"));
                prod_type = rmvSpcChar(rs.getString("prod_type"));
                category = rmvSpcChar(rs.getString("category"));
                article = rs.getString("article");
                quantity = rmvSpcChar(rs.getString("quantity"));
                user_datetime = rmvSpcChar(rs.getString("user_datetime"));
                aloc_stck_used = rmvSpcChar(rs.getString("aloc_stck_used"));
                aloc_stock_obs = rmvSpcChar(rs.getString("aloc_stock_obs"));
                aloc_stock = rmvSpcChar(rs.getString("aloc_stock"));
                aloc_stck_used_user_rg = rmvSpcChar(rs.getString("aloc_stck_used_user_rg"));
                if (aloc_stck_used_user_rg == null || aloc_stck_used_user_rg.trim().length() == 0) {
                    aloc_stck_used_user_rg = "";
                }
                iduser = rs.getString("iduser");
                if (aloc_stock == null || aloc_stock.trim().length() == 0) {
                } else {
                    c1 = aloc_stock;
                    if (i != 0 && !c1.equalsIgnoreCase(c2)) {
                        r += "</table><br>" + lang.lng(current_lang, "article") + ":<input type=\"text\" id=\"txttblstck" + id
                                + "\" onkeyup=\"filbyclnsnr('tblstck" + id + "', this.value, 4, 7, 8, 'stk')\" style=\"width: 300px;\"><br>"
                                + "<strong>Local: " + aloc_stock + "</strong><br><table id='tblstck" + id + "' border='1'>" + s;
                    }
                }
                if (i == 0) {
                    try {
                        String g = r.replaceAll("xxxxzzzzzyyyyywwwww", aloc_stock);
                        r = g;
                    } catch (Exception e) {
                    }
                }

                r += "<tr>";
                r += "<td>" + id + "</td>";
                r += "<td>" + group_factory + "</td>";
                r += "<td>" + prod_type + "</td>";
                r += "<td>" + category + "</td>";
                r += "<td>" + article + "</td>";
                r += "<td>" + quantity + "</td>";
                r += "<td>" + user_datetime + "</td>";
                r += "<td>" + iduser + "</td>";
                String aloc_stck_used2 = "";
                if (aloc_stck_used == null || aloc_stck_used.trim().length() == 0) {
                    aloc_stck_used = "0";
                }
                if (aloc_stck_used.equalsIgnoreCase("0")) {
                    aloc_stck_used2 = "Nao";
                } else if (aloc_stck_used.equalsIgnoreCase("1")) {
                    aloc_stck_used2 = "Sim";
                }
                String vlstkl = id + ":" + aloc_stck_used;
                r += "<td id='stkcusd" + i + "' onclick=\"tdstck(" + i + ",'" + aloc_stck_used2 + "','" + vlstkl + "'),"
                        + "tdstck(" + i + ",'" + aloc_stck_used2 + "','" + vlstkl + "', event)\">" + aloc_stck_used2 + "</td>";
                r += "<td>" + aloc_stck_used_user_rg + "</td>";
                r += "<td>" + aloc_stock + "</td>";
                r += "</tr>";
                c2 = c1;
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
        r += "</table>";
        if (i == 0) {
            r = "";
        }
        return r;
    }

    public String dinmcbtn(String nm, String prc, String imgg, String idd, String fltrl) {
        String a = "                                <div style=\"" + fltrl + " background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;\">\n"
                + "                                    <a href=\"#\" " + idd + " onclick=\"" + prc + "\" style=\"text-decoration: none; float: none; display: inline;\">\n"
                + "                                        <img src=\"" + imgg + "\" style=\"width: 32px; height: 32px;\" title=\"" + nm + "\">\n"
                + "                                    </a>\n"
                + "                                </div>";
        return a;
    }

    public void crtdbifnotexst() {
        String q = "CREATE DATABASE IF NOT EXISTS sgrb";
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
            String r = "" + stmt.execute(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            Runtime.getRuntime().exec("mysql -u " + Strngs.db + " -p " + Strngs.pwd + " " + Strngs.db + "  " + Strngs.flsq + ".sql");
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

    public String chkifdbexist() {
        String a = "n";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet resultSet = con.getMetaData().getCatalogs();
            while (resultSet.next()) {
                // Get the database name, which is at position 1
                String dbNm = resultSet.getString(1);
                if (dbNm.equalsIgnoreCase(dbNm)) {
                    a = "y";
                }
            }
            try {
                resultSet.close();
            } catch (Exception e) {

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

    public String dtfrmt(String clnmnr) {
        //String b = "mysql";  
        String b = "hsqldb";
        if (b.equalsIgnoreCase("mysql")) {
            return "DATE_FORMAT(" + clnmnr + ",'%Y-%m-%d')";
        } else {
            return "CAST(" + clnmnr + " AS DATE)";
        }
    }

    public boolean insertClient(String sq) {
        boolean rs = false;
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
            String r = "" + stmt.executeUpdate(sq);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            rs = true;
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
        return rs;
    }

    public ArrayList getProdPrz() {
        ArrayList<String> Alst = new ArrayList<String>();
        String q = "select article as article,comp_prz as comp_prz,(sum(quantity)-sum(quant_saled)) as qnty from purchases group by article,comp_prz";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            String art = "";
            String prz = "";
            String qnty = "";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                art = rs.getString("article");
                prz = rs.getString("comp_prz");
                qnty = rs.getString("qnty");
                try {
                    String z = art.replaceAll(",", "");
                    art = z;
                } catch (Exception e) {

                }
                try {
                    String z = art.replaceAll(":", "");
                    art = z;
                } catch (Exception e) {

                }
                try {
                    String z = art.replaceAll(";", "");
                    art = z;
                } catch (Exception e) {

                }
                Alst.add("" + art + "," + prz + "," + qnty);
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
        return Alst;
    }

    private String getVlsFrmPAlst(String art_prz) {
        String a = "";
        String fprz = "";
        String fprz10 = "";
        String fprz25 = "";
        String fprz60 = "";

        java.util.Date date_current = new java.util.Date();
        java.util.Date date_current_plus_10 = new java.util.Date();
        java.util.Date date_current_plus_25 = new java.util.Date();
        java.util.Date date_current_plus_60 = new java.util.Date();

        Calendar c10 = Calendar.getInstance();
        c10.setTime(date_current_plus_10);
        c10.add(Calendar.DATE, 10);
        date_current_plus_10 = c10.getTime();

        Calendar c25 = Calendar.getInstance();
        c10.setTime(date_current_plus_25);
        c10.add(Calendar.DATE, 25);
        date_current_plus_25 = c25.getTime();

        Calendar c60 = Calendar.getInstance();
        c10.setTime(date_current_plus_60);
        c10.add(Calendar.DATE, 60);
        date_current_plus_60 = c60.getTime();

        SimpleDateFormat frmt_string_to_date = new SimpleDateFormat("yyyy-MM-dd");

        try {
            for (int i = 0; i < PAlst.size(); i++) {
                try {
                    String v = PAlst.get(i);
                    String[] av = v.split(",");
                    String art = av[0];
                    String prz = av[1];
                    String qnty = av[2];
                    if (prz == null || prz.trim().length() == 0) {
                        prz = "a";
                    } else {
                        try {
                            String[] b = prz.split(" ");
                            prz = b[0];
                        } catch (Exception e) {
                        }
                    }
                    Date przd = prz.equals("a") ? frmt_string_to_date.parse("2100-12-20") : frmt_string_to_date.parse(prz);
                    if (art_prz.equalsIgnoreCase(art)) {
                        if (przd.before(date_current)) {
                            fprz = fprz + qnty;
                        }
                        if (przd.after(date_current) && (przd.before(date_current_plus_10) || przd.equals(date_current_plus_10))) {
                            fprz10 = fprz10 + qnty;
                        }
                        if (przd.after(date_current_plus_10) && (przd.before(date_current_plus_25) || przd.equals(date_current_plus_25))) {
                            fprz25 = fprz25 + qnty;
                        }
                        if (przd.after(date_current_plus_25) && (przd.before(date_current_plus_60) || przd.equals(date_current_plus_60))) {
                            fprz60 = fprz60 + qnty;
                        }
                    }
                } catch (ParseException ex) {
                    //System.out.println("prze: " + ex.getMessage());
                }
            }
        } catch (Exception e) {
        }
        a = fprz + "<td>" + fprz10 + "</td><td>" + fprz25 + "</td><td>" + fprz60 + "</td>";
        return a;
    }

    public String minIntV(String a, String b) {
        int aa = 0;
        int bb = 0;
        try {
            int y = Integer.parseInt(a);
            aa = y;
        } catch (Exception e) {
        }
        try {
            int y = Integer.parseInt(b);
            bb = y;
        } catch (Exception e) {
        }
        return aa < bb ? "" + aa : "" + bb;
    }

    public String minIntV2(String a, String b) {
        java.util.Date aa = new java.util.Date();
        java.util.Date bb = new java.util.Date();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            aa = formatter.parse("" + a);
        } catch (ParseException ex) {
            try {
                aa = formatter.parse("2020-01-01");
            } catch (Exception e) {
            }
            System.out.println("ex1: " + ex.getMessage());
        }
        try {
            bb = formatter.parse("" + b);
        } catch (ParseException ex) {
            try {
                bb = formatter.parse("2020-01-01");
            } catch (Exception e) {
            }
            System.out.println("ex2: " + ex.getMessage());
        }
        return "" + (aa.before(bb) ? aa : bb);
    }

    public String rmvSpcChar(String v) {
        if (v == null || v.trim().length() == 0) {
            return v;
        }
        try {
            String a = v.replaceAll(",", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll(";", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("\\.", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll(":", "_");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("\"", "");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replaceAll("'", "");
            v = a;
        } catch (Exception e) {
        }
        try {
            String a = v.replace("\n", "").replace("\r", "");
            v = a;
        } catch (Exception e) {
        }
        return v;
    }

    public boolean isNmbr(String str) {
        if (str == null || str.trim().length() == 0 || str.equalsIgnoreCase("NA") || str.equalsIgnoreCase("null")) {
            return false;
        }
        try {
            Integer.parseInt(str);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String date_from_days(String d) {
        //System.out.println("d: " + d);
        String s = "";
        if (d == null || d.trim().length() == 0 || d.equalsIgnoreCase("null") || d.equalsIgnoreCase("0")) {
            return "NA";
        }
        int j = 0;
        try {
            int z = Integer.parseInt(d);
            j = z;
        } catch (Exception e) {
        }
        j = (-1) * j;
        Date dtsb = new Date();
        Calendar datesub = Calendar.getInstance();
        datesub.setTime(dtsb);
        datesub.add(Calendar.DATE, j);
        SimpleDateFormat frmt = new SimpleDateFormat("dd/MM/yyyy");
        s = "" + frmt.format(datesub.getTime());
        return s;
    }

    public String list_of_enrolled_client(String sctr) {
        String r = "<table id='' border='1'>"
                + "<tr style=\"height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);\">"
                + "<th>" + lang.lng(current_lang, "order") + "</th><th>" + lang.lng(current_lang, "full_name") + "</th>"
                + "<th>" + lang.lng(current_lang, "place_of_residence") + "</th><th>" + lang.lng(current_lang, "bi") + "</th>"
                + "<th>" + lang.lng(current_lang, "telephone") + "</th>"
                + "</tr>";
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            String q = "select id,clientname,residenty,id_number,phone from deposits";
            //System.out.println("qq: " + q);
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(q);
            while (rs.next()) {
                r += "<tr>";
                r += "<td>" + rs.getString("id") + "</td>"
                        + "<td>" + "<a href='#' onclick=\"setClient('" + rs.getString("id") + "." + rs.getString("clientname") + "')\" style='text-decoration: none;'>"
                        + rs.getString("clientname") + "</a>"
                        + "</td>"
                        + "<td>" + rs.getString("residenty") + "</td>"
                        + "<td>" + rs.getString("id_number") + "</td>"
                        + "<td>" + rs.getString("phone") + "</td>";
                r += "</tr>";
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
        r += "</table>";
        return r;
    }

    public String trnslt(String lng, String a) {
        String b = "";
        if (lng.equalsIgnoreCase("english")) {
            if (a.startsWith("Ferragens")) {
                b = "Hardware";
            } else if (a.startsWith("Farmacia")) {
                b = "Drugstore";
            } else if (a.startsWith("Venda de Pe")) {
                b = "Sale of Parts";
            } else if (a.startsWith("Mercearia")) {
                b = "Grocery store";
            } else if (a.startsWith("Restaurant")) {
                b = "Restaurante";
            } else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else if (lng.equalsIgnoreCase("portuguese")) {
            b = a;
        } else if (lng.equalsIgnoreCase("spanish")) {
            if (a.startsWith("Ferragens")) {
                b = "Hardware";
            } else if(a.equalsIgnoreCase("Farmacia")){
                b = "Drugstore";
            }
            else if (a.startsWith("Venda de P")) {
                b = "Venta de Repuestos";
            } else if (a.startsWith("Mercearia")) {
                b = "Tienda de comestibles";
            } else if(a.equalsIgnoreCase("Restaurant")){
                b = "Restaurante";
            }
            else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else if (lng.equalsIgnoreCase("french")) {
            if (a.startsWith("Ferragens")) {
                b = "Material";
            } else if (a.startsWith("Farmacia")) {
                b = "Pharmacie";
            } else if (a.startsWith("Venda de Pe")) {
                b = "Vente de pices";
            } else if (a.startsWith("Mercearia")) {
                b = "Picerie";
            } else if (a.startsWith("Restaurant")) {
                b = "Le Restaurant";
            } else if (a.startsWith("Bar")) {
                b = "Pub";
            }
        } else {
            b = a;
        }
        return b;
    }

    public String frml_purchase_profit() {
        String a = lang.lng(current_lang, "saleprice.price") + " * " + lang.lng(current_lang, "purchases.quantity")
                + " - " + lang.lng(current_lang, "purchases.price") + " (" + lang.lng(current_lang, "last_records") + ")";
        return a;
    }

    public String frml_past_sales_profit() {
        String a = lang.lng(current_lang, "sales.price") + " - (" + lang.lng(current_lang, "sales.quantity") + " "
                + "* (" + lang.lng(current_lang, "purchases.price") + " / " + lang.lng(current_lang, "purchases.quantity") + "))"
                + " (" + lang.lng(current_lang, "last_records") + ")";
        return a;
    }

    public boolean ExistGroupProducts(String a, String p) {
        String t = "";
        boolean r = false;
        String q = "";
        if (a.equalsIgnoreCase("fctry")) {
            t = "groups_factories";
            q = "factory";
        } else if (a.equalsIgnoreCase("prodl")) {
            t = "products_purchases";
            q = "product";
        }
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from " + t + " where " + q + " = '" + p + "'");
            while (rs.next()) {
                r = true;
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
        return r;
    }
    public String removeDuplicateById(String a){
        String b = "";
        String indxa = "a;";
        try{
           for(String c : a.split(":")){
              String f = "" + c.split(";")[0] + ";";
              if(!indxa.contains(f)){
                 b += "" + c +  ":";
              }
              indxa += f;
           }        
        }catch(Exception e){}
        
        return b == null || b.trim().length() == 0? a : b;
    }
}
