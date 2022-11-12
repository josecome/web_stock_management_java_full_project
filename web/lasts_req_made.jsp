<%-- 
    Document   : lasts_req_made
    Created on : Feb 3, 2022, 10:01:29 AM
    Author     : Admin
--%>

<%@page import="a.Values"%>
<%@page import="a.PreferedLang"%>
<%@page import="a.client_session"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="a.cdb"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
        <%
           String sector = request.getParameter("sector");
           String s = sector;
        %>
        <script>
            function impinvc(clt) {
                var url = "/SGRB/Invoice.jsp?clt=" + clt + "&user=Duplicate&sector=<%=s%>";
                window.open(url, 'popUpWindow', 'height=600,width=300,left=10,top=10,,scrollbars=yes,menubar=no');
                return false;
            }
        </script>
        <style>
            table,tr,td {
                border: 1px solid gray;
                border-collapse: collapse;
            }
        </style>
    </head>
    <body>
        <%
           a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {
                Connection con = null;
                Statement stmt = null;
                Values vls = new Values();
                String b = "";
                String sale_date = "";
                String pname = cssn.getOrgInf()[0];
                
                String artcls = "";
                String logo = "";                
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
        %>
        <h1><%=lang.lng(current_lang, "last_orders_placed_in_descending_order")%></h1><br>
        <span style="text-decoration: none; font-size: 12px;"><%=lang.lng(current_lang, "click_in")%> <strong><%=lang.lng(current_lang, "client")%></strong> <%=lang.lng(current_lang, "to _generate _second_copy_of_proof")%></span>
        <%        
            String c = "#D1F2EB";
            String h = "_";
            String z = c;
            Double t = 0.0;
            String fb = "";
            boolean w = false;
            String tb = "<table border='1'>"
                    + "<tr><th>Cliente</th><th>Artigo</th><th>Quantidade</th><th>Pre&ccedil;o</th><th>Codigo de Produto</th><th>Codigo de Barra</th><th>Data e Hora</th><th>Total</th><th>Usu&aacute;rio</th></tr>";
            try {

                con = cdb.getConnection();
                if (con == null) {
                }
                stmt = con.createStatement();
                String qry = "select c.msname_us_time as msname_us_time,c.article as article,c.quantity as quantity,c.price as price,"
                        + "c.p_code as p_code,c.barcode as barcode,"
                        + "CONCAT(CAST(c.user_datetime AS DATE),CONCAT(' ',CAST(c.user_datetime AS TIME))) as user_datetime,"
                        + "(select username from users u where u.id = c.iduser limit 1) as user from clients_requests c "
                        + " LEFT JOIN ms_requests m ON c.msname_us_time = m.msname_us_time where c.sector = '" + s + "' order by m.user_datetime desc,c.id asc limit 1000";
                //System.out.println("QRY: " + qry);
                ResultSet rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    String g = rs.getString("msname_us_time");
                    if (g == null || g.trim().length() == 0) {
                        g = "_";
                    }
                    if (g.equalsIgnoreCase(h)) {
                        w = true;
                    } else {
                        w = false;
                    }
                    if (w) {
                        try{
                            fb = tb.replaceAll("aaaaaacccccdddddzzzzwwwyyyttttzzzaaa", "");
                            tb = fb;
                        }catch(Exception e){}
                        try{
                            fb = tb.replaceAll("qqqqqqqqqqqqqppppppppppppppppkkkkkkkkhhhhjjjjjj", "");
                            tb = fb;
                        }catch(Exception e){}
                        if (c.equalsIgnoreCase("#D1F2EB")) {
                            c = "#D1F2EB";
                            try {
                                Double j = Double.parseDouble(rs.getString("price"));
                                t = t + j;
                            } catch (Exception e) {
                            }
                        } else if (c.equalsIgnoreCase("#FDF2E9")) {
                            c = "#FDF2E9";
                            try {
                                Double j = Double.parseDouble(rs.getString("price"));
                                t = t + j;
                            } catch (Exception e) {
                            }
                        }
                    } else {
                        try{
                            fb = tb.replaceAll("aaaaaacccccdddddzzzzwwwyyyttttzzzaaa", "font-weight: bold; color: blue;");
                            tb = fb;
                        }catch(Exception e){}
                        try{
                            fb = tb.replaceAll("qqqqqqqqqqqqqppppppppppppppppkkkkkkkkhhhhjjjjjj", "font-weight: bold; color: white; background-color: black;");
                            tb = fb;
                        }catch(Exception e){}
                        if (c.equalsIgnoreCase("#D1F2EB")) {
                            c = "#FDF2E9";
                            try {
                                Double j = Double.parseDouble(rs.getString("price"));
                                t = j;
                            } catch (Exception e) {
                            }
                        } else if (c.equalsIgnoreCase("#FDF2E9")) {
                            c = "#D1F2EB";
                            try {
                                Double j = Double.parseDouble(rs.getString("price"));
                                t = j;
                            } catch (Exception e) {
                            }
                        }
                    }
                    DecimalFormat twoDc = new DecimalFormat("#.00");
                    tb += "<tr style='background-color: " + c + "; aaaaaacccccdddddzzzzwwwyyyttttzzzaaa'>"
                            + "<td><a href=\"#\" onclick=\"impinvc('" + rs.getString("msname_us_time") + "')\" style=\"text-decoration: none;\">" + rs.getString("msname_us_time") + "</a></td>"
                            + "<td>" + rs.getString("article") + "</td>"
                            + "<td>" + rs.getString("quantity") + "</td>"
                            + "<td>" + rs.getString("price") + "</td>"
                            + "<td>" + rs.getString("p_code") + "</td>"
                            + "<td>" + rs.getString("barcode") + "</td>"
                            + "<td>" + rs.getString("user_datetime") + "</td>"
                            + "<td style='qqqqqqqqqqqqqppppppppppppppppkkkkkkkkhhhhjjjjjj'>" + twoDc.format(t) + "</td>"
                            + "<td>" + rs.getString("user") + "</td>"
                            + "</tr>";
                    h = g;
                }
            } catch (Exception e) {
                //retorno = new StringBuffer("<div style='color: red;'>Falhou 1 , " + e.getMessage() + "tente novamente</div>");
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
            tb += "</table>";
        %>
        <%=tb%>
         <%
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
