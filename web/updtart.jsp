<%-- 
    Document   : updtart
    Created on : Jan 11, 2022, 8:28:54 PM
    Author     : Admin
--%>

<%@page import="a.Transformations"%>
<%@page import="a.PreferedLang"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
<%@page import="a.client_session"%>
<%@page import="a.Values"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="a.cdb"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        <%           
           get_lng_file glng = new get_lng_file();
           language lang = new language(glng.getlngs());
           client_session cssn = new client_session();
           PreferedLang plng = new PreferedLang();
           String current_lang = plng.getPreferedLang();
        %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SGRB</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
    </head>
    <body oncontextmenu="return false">
        <%
            String r = "";
            String qry1 = "";
            String qry2 = "";
            String qry3 = "";
            Connection con = null;
            Statement stmt = null;
            String ids = request.getParameter("ids");
            String artcls = "";
            String logo = "";
            Values vls = new Values();
            Transformations trnsf = new Transformations();
            String sky = "";
            String dsbld = "";
            /*artcls = vls.Artcls();*/
            logo = cssn.logo();
            String vlky = cssn.keystatus()[2];
            String dys = cssn.keystatus()[3];
            int dyss = 0;
            try {
                dyss = Integer.parseInt(dys);
            } catch (Exception e) {
                dyss = 0;
            }
            String[] vlspid = cssn.prvls(request.getParameter("user"));
            String pvl = vlspid[0];
            if(pvl == null || pvl.trim().length() == 0){pvl = "z";}
            if (!pvl.contains("w")) {
                out.println("<span style='color: red;'>" + lang.lng(current_lang, "you_don't_have_privileges_to_insert_or_update_sales") + "!</span>");
                out.close();
                return;
            }
            
            int sclnt = 1;
            try {
                sclnt = Integer.parseInt(cssn.keystatus()[9]);
            } catch (Exception e) {
                sclnt = 1;
            }
            if (dyss > 0 && sclnt > 0) {
                out.println("<span style='color: red;'>" + lang.lng(current_lang, "the_key_has_expired") + "!</span>");
                out.close();
                return;
            }
            String t = request.getParameter("t");
            if (!t.equalsIgnoreCase("12")) {
                out.println("<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred") + "Ocorreu um erro!</span>");
                out.close();
                return;
            }
            int y = 0;
            try {
                con = cdb.getConnection();
                if (con == null) {
                    out.println("<span style='color: red;'>" + lang.lng(current_lang, "no_connection,_try_later") + "!</span>");
                    out.close();
                    return;
                }
                con.setAutoCommit(false);
                DatabaseMetaData meta = con.getMetaData();
                if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                    con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
                }
                stmt = con.createStatement();
                try {
                    stmt.executeUpdate("update prices_sales set group_factory = group_factory, price = price where id = 0");                    
                    for (String v : ids.split(",")) {
                        String doUpt = "no";
                        String idvchng = request.getParameter("idvchng" + v);
                        if(idvchng == null || idvchng.trim().length() == 0){
                           doUpt = "no";
                        } else if(idvchng.equalsIgnoreCase("1")){
                           doUpt = "yes";
                           y = y + 1;
                        }
                        try {
                            if (v == null || v.trim().length() == 0) {
                            } else if(doUpt.equalsIgnoreCase("yes")) {
                                String g = request.getParameter("idgrp" + v);
                                String p = trnsf.NumberToDecimal(request.getParameter("idprc" + v));
                                String pcod = request.getParameter("idpcod" + v);
                                String barcod = request.getParameter("idbarcod" + v);
                                String desc = request.getParameter("iddesc" + v);
                                qry1 = "update prices_sales set group_factory = '" + g + "', "
                                        + " p_code = '" + pcod + "',"
                                        + " barcode = '" + barcod + "',"
                                        + "price = '" + p + "',"
                                        + "descount = '" + desc + "' where id = " + v;
                                qry2 = "update prices_sales_duplicate set group_factory = '" + g + "', "
                                        + " p_code = '" + pcod + "',"
                                        + " barcode = '" + barcod + "',"
                                        + "price = '" + p + "',"
                                        + "descount = '" + desc + "' where id = " + v;
                                qry3 = "update prices_sales_events set group_factory = '" + g + "', "
                                        + " p_code = '" + pcod + "',"
                                        + " barcode = '" + barcod + "',"
                                        + "price = '" + p + "',"
                                        + "descount = '" + desc + "' where id = " + v;
                                stmt.addBatch(qry1);
                                stmt.addBatch(qry2);
                                stmt.addBatch(qry3);
                            }
                        } catch (Exception e) {
                        }
                    }
                } catch (Exception ex) {
                }
                stmt.executeBatch();
                con.setAutoCommit(true);
                if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                    con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
                }
                r = "<span style='color: green;'>" + lang.lng(current_lang, "successfully_inserted") + ": " + y + "!</span>";
            } catch (Exception e) {
                r = "<span style='color: red;'>" + lang.lng(current_lang, "error_processing") + "!</span>";
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
            out.println(r);
            out.close();
        %>
    </body>
</html>
