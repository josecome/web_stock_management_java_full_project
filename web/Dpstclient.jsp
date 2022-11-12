<%-- 
    Document   : Dpstclient
    Created on : Feb 14, 2022, 11:21:27 PM
    Author     : Admin
--%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="a.Values"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
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
        <script>
        var cnfrm_ok_cancel = "confirm_with_ok_to_continue_or_cancel_to_cancel";    
function showDataEntry(){try{document.getElementById("dtentry").style.display="block"}catch(a){}}
function validar(){var a=document.getElementById("payment").value,b=document.getElementById("typofoperation").value,c=document.getElementById("withdrawals_purpose").value;if(("Deposito"===b||"Divida"===b)&&"NA"!==c)return alert("Finalidade da retirada apenas para retiradas!"),!1;if("Retirada"===b&&"NA"===c)return alert("Prencher a finalidade da retirada!"),!1;if(null===a||"undefined"===typeof a||0===a.trim().length)return alert("Prencher valor!"),!1;if(!confirm(cnfrm_ok_cancel))return!1}
function stateofwprps(a){if("Deposito"===a){try{document.getElementById("withdrawals_purpose").disabled=!0}catch(b){}try{document.getElementById("withdrawals_purpose").value="NA"}catch(b){}}else try{document.getElementById("withdrawals_purpose").disabled=!1}catch(b){}};

        </script>
    </head>
    <body oncontextmenu="return false">
        <%@page session="true" import="a.*" %> 
        <%
            a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {
                int user_register = 0;
                Values vls = new Values();
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
                if (pvl == null || pvl.trim().length() == 0) {
                    pvl = "z";
                }
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
                t = (t == null || t.trim().length() == 0) ? "_" : t;
                if (!t.equalsIgnoreCase("14")) {
                    out.println("<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred") + "!</span>");
                    out.close();
                    return;
                }
                try {
                    user_register = Integer.parseInt(vlspid[1]);
                } catch (NumberFormatException e) {
                    user_register = 0;
                }
                Connection con = null;
                Statement stmt = null;
                String id = request.getParameter("clt");
                String clientname = "";
                String residenty = "";
                String id_number = "";
                String phone = "";
                try {
                    con = cdb.getConnection();
                    if (con == null) {
                    }
                    String q = "select clientname,residenty,id_number,phone from deposits where id = " + id;
                    stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(q);
                    while (rs.next()) {
                        //String z = rs.getString("roles");
                        clientname = rs.getString("clientname");
                        residenty = rs.getString("residenty");
                        id_number = rs.getString("id_number");
                        phone = rs.getString("phone");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        cdb.devolveConnection(con);
                    } catch (SQLException e) {
                        //System.out.println("" + eb.getMessage());
                    }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                    };
                }
        %>
        <script>
            function prnt_dpst() {
                var url = "/SGRB/Client_dep_prnt.jsp?id=<%=request.getParameter("clt")%>&user=<%=Lb.getUser()%>&sector=<%=request.getParameter("sector")%>&name=<%=clientname%>";
                window.open(url, 'popUpWindow', 'height=700,width=500,left=10,top=10,,scrollbars=yes,menubar=no');
                return false;
            }
        </script>
        <strong id="titulo"><%=lang.lng(current_lang, "deposits/debts/purchases")%></strong><br><br>
        <div style="width: 100%;"><%=lang.lng(current_lang, "customer_id")%>: <span style="color: blue;"><%=id%></span> <%=lang.lng(current_lang, "client_name")%>: <span style="color: blue;"><%=clientname%></span></div>
        <br>
        <table>
            <tr>
                <td style="background-color: gray; color: white;"><%=lang.lng(current_lang, "place_of_residence")%></td><td style="width: 8px;"></td>
                <td><%=residenty%></td><td style="width: 20px;"></td>
                <td style="background-color: gray; color: white;"><%=lang.lng(current_lang, "bi")%></td><td style="width: 8px;"></td>
                <td><%=id_number%></td><td style="width: 20px;"></td>
                <td style="background-color: gray; color: white;"><%=lang.lng(current_lang, "telephone")%></td><td><%=phone%></td>
            </tr>
        </table>
        <%
            String r = "";
            String h = request.getParameter("h");
            if (h == null || h.trim().length() == 0) {
            } else if (h.equalsIgnoreCase("1")) {
                String dsptid = request.getParameter("clt");
                String pymt = request.getParameter("payment");
                String typofop = request.getParameter("typofoperation");
                String withdrawalsprps = request.getParameter("withdrawals_purpose");
                typofop = (typofop == null || typofop.trim().length() == 0) ? "_" : typofop;
                try {
                    con = cdb.getConnection();
                    if (con == null) {
                        out.println("<span style='color: red;'>Sem conexao, tente mais tarde!</span>");
                        out.close();
                        return;
                    }
                    con.setAutoCommit(false);
                    DatabaseMetaData meta = con.getMetaData();
                    if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                        con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
                    }
                    stmt = con.createStatement();
                    if (typofop.equalsIgnoreCase("Deposito")) {
                        withdrawalsprps = "Deposito";
                        stmt.executeUpdate("insert into depositslist (withdrawals,payment,withdrawals_purpose,deposit_id,user_datetime,iduser) values (0.00,'" + pymt + "','" + withdrawalsprps + "','" + id + "',now()," + user_register + ")");
                        stmt.addBatch("update deposits set total_payment = total_payment + " + pymt + " where id = " + dsptid);
                    } else if (typofop.equalsIgnoreCase("Retirada") || typofop.equalsIgnoreCase("Divida")) {
                        if (typofop.equalsIgnoreCase("Divida")) {
                            withdrawalsprps = "Divida";
                        }
                        stmt.executeUpdate("insert into depositslist (payment,withdrawals,withdrawals_purpose,deposit_id,user_datetime,iduser) values (0.00,'" + pymt + "','" + withdrawalsprps + "','" + id + "',now()," + user_register + ")");
                        stmt.addBatch("update deposits set total_used = total_used + " + pymt + " where id = " + dsptid);
                    } else {

                    }
                    stmt.executeBatch();
                    con.setAutoCommit(true);
                    if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                        con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
                    }
                    r = "<span style='color: green;'>" + lang.lng(current_lang, "successfully_inserted") + "!</span>";
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
            }
        %>    
        <br>
        <div><%=r%></div><br>
        <%=vls.dinmcbtn("Novo", "showDataEntry()", "/SGRB/img/newp.png", "", "")%>
        <br>
        <div id="dtentry" style="display: none; width: 100%;">
            <form action='/SGRB/Dpstclient.jsp' method='post' accept-charset='UTF-8' onsubmit='return validar()'>
                <%=lang.lng(current_lang, "operation_type")%>:
                <select name="typofoperation" id="typofoperation" onchange="stateofwprps(this.value)">
                    <option value="Deposito"><%=lang.lng(current_lang, "deposit")%></option> 
                    <option value="Divida"><%=lang.lng(current_lang, "debt")%></option>
                    <option value="Retirada"><%=lang.lng(current_lang, "withdrawal")%></option> 
                </select>
                <%=lang.lng(current_lang, "value")%>:
                <input type='number' name='payment' id='payment'>
                <%=lang.lng(current_lang, "purpose_of_withdrawal")%>:
                <select name="withdrawals_purpose" id="withdrawals_purpose">
                    <option value="NA">NA</option> 
                    <option value="Compra"><%=lang.lng(current_lang, "purchase")%></option> 
                    <option value="Devolucao"><%=lang.lng(current_lang, "devolution")%></option>                    
                    <option value="Erro de registo"><%=lang.lng(current_lang, "registration_error")%></option> 
                </select>
                <input type='hidden' name='h' value='1'>
                <input type='hidden' name='t' value='14'>
                <input type='hidden' name='clt' value='<%=id%>'><br>
                <input type='hidden' name='user' value='<%=request.getParameter("user")%>'><br>
                <%=vls.dinmcbtn("Inserir", "if(validar() === false){  return false;}else{this.closest('form').submit();return false;}", "/SGRB/img/insertp4.png", "", "float: right;")%>                
            </form>
        </div>
        <br>
        <strong><%=lang.lng(current_lang, "go_to_list_of_deposits/debts")%></strong> <a href="#tbpurchases" style="text-decoration: none;"><%=lang.lng(current_lang, "customer_shopping_list")%></a><br>
        <span id="spttl"></span><%=vls.dinmcbtn(lang.lng(current_lang, "print_out"), "prnt_dpst()", "/SGRB/img/printp.png", "", "")%> 
        <br>
        <table>
            <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                <th><%=lang.lng(current_lang, "order")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "deposit")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "used")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "balance")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "ret_purpose")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "date")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "hour")%></th>
            </tr>
            <%
                String f1 = "";
                String f2 = "";
                String a = "";
                double z1 = 0.00;
                double z2 = 0.00;
                double z3 = 0.00;
                try {

                    con = cdb.getConnection();
                    if (con == null) {
                    }
                    String q = "select id,payment,withdrawals,withdrawals_purpose,(payment - withdrawals) as balance,CAST(user_datetime AS DATE) as user_datetime,"
                            + "CAST(user_datetime AS TIME) as user_datetimeh "
                            + " from depositslist where deposit_id = " + id;

                    String idd = "";
                    String payment = "";
                    String withdrawals = "";
                    String balance = "";
                    String user_datetime = "";
                    String user_datetimeh = "";
                    String withdrawals_purpose = "";

                    stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(q);
                    while (rs.next()) {
                        //String z = rs.getString("roles");
                        idd = rs.getString("id");
                        payment = rs.getString("payment");
                        withdrawals = rs.getString("withdrawals");
                        balance = rs.getString("balance");
                        user_datetime = rs.getString("user_datetime");
                        user_datetimeh = rs.getString("user_datetimeh");
                        withdrawals_purpose = rs.getString("withdrawals_purpose");
                        if (withdrawals_purpose == null || withdrawals_purpose.trim().length() == 0 || withdrawals_purpose.equalsIgnoreCase("null")) {
                            withdrawals_purpose = "";
                        }
                        String b = "<tr>"
                                + "<td>" + idd + "</td><td>" + payment + "</td><td>" + withdrawals + "</td><td>" + balance + "</td>"
                                + "<td>" + withdrawals_purpose + "</td><td>" + user_datetime + "</td><td>" + user_datetimeh + "</td>"
                                + "</tr>";
                        a += b;
                        try {
                            double j = Double.parseDouble(payment);
                            z1 = z1 + j;
                        } catch (Exception e) {
                        }
                        try {
                            double j = Double.parseDouble(withdrawals);
                            z2 = z2 + j;
                        } catch (Exception e) {
                        }
                        try {
                            double j = Double.parseDouble(balance);
                            z3 = z3 + j;
                        } catch (Exception e) {
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        cdb.devolveConnection(con);
                    } catch (SQLException e) {
                        //System.out.println("" + eb.getMessage());
                    }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                    };
                }
                String w1 = String.format("%.2f", z1);
                String w2 = String.format("%.2f", z2);
                String w3 = String.format("%.2f", z3);
                f1 = "function totalvls(){\n"
                        + "try {document.getElementById('spttl').innerHTML = 'Total Deposito: " + w1 + "Mts, Total Usado: "
                        + w2 + "Mts, <strong>Total Saldo: " + w3 + "Mts</strong>';} catch (e) {}\n"
                        + "}\n"
                        + "totalvls();";
            %>
            <%=a%>
        </table>
        <br><br>
        <strong><%=lang.lng(current_lang, "customer_shopping_list")%></strong> <a href="#titulo" style="text-decoration: none;"><%=lang.lng(current_lang, "list_of_deposits/debts")%></a><br>
        <span id="sptt2"></span>
        <table id="tbpurchases">
            <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                <th><%=lang.lng(current_lang, "order")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "article")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "prod_code")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "bar_code")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "the_amount.")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "price")%></th>
                <th style="width: 160px;"><%=lang.lng(current_lang, "date")%></th><th style="width: 160px;"><%=lang.lng(current_lang, "hour")%></th>
            </tr>
            <%
                a = "";
                z1 = 0.00;
                try {
                    con = cdb.getConnection();
                    if (con == null) {
                    }
                    String q = "select id,article,p_code,barcode,quantity,price,CAST(user_datetime AS DATE) as user_datetime,"
                            + "CAST(user_datetime AS TIME) as user_datetimeh "
                            + " from sales where removed = 0 and enrolled_client like '" + id + ".%'";

                    String idd = "";
                    String article = "";
                    String p_code = "";
                    String barcode = "";
                    String quantity = "";
                    String price = "";
                    String user_datetime = "";
                    String user_datetimeh = "";
                    stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(q);
                    while (rs.next()) {
                        idd = rs.getString("id");
                        article = rs.getString("article");
                        p_code = rs.getString("p_code");
                        barcode = rs.getString("barcode");
                        quantity = rs.getString("quantity");
                        price = rs.getString("price");
                        user_datetime = rs.getString("user_datetime");
                        user_datetimeh = rs.getString("user_datetimeh");
                        String b = "<tr>"
                                + "<td>" + idd + "</td><td>" + article + "</td><td>" + p_code + "</td><td>" + barcode + "</td>"
                                + "<td>" + quantity + "</td><td>" + price + "</td><td>" + user_datetime + "</td><td>" + user_datetimeh + "</td>"
                                + "</tr>";
                        a += b;
                        try {
                            double j = Double.parseDouble(price);
                            z1 = z1 + j;
                        } catch (Exception e) {
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        cdb.devolveConnection(con);
                    } catch (SQLException e) {
                        //System.out.println("" + eb.getMessage());
                    }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                    };
                }
                w1 = String.format("%.2f", z1);
                f2 = "function totalvls2(){\n"
                        + "try {document.getElementById('sptt2').innerHTML = '<strong>Total Pago: " + w1 + "Mts</strong>';} catch (e) {}\n"
                        + "}\n"
                        + "totalvls2();";
            %>
            <%=a%>
        </table>
        <script>
            <%=f1%>
            <%=f2%>    
            try {
                document.getElementById("withdrawals_purpose").disabled = true;
            } catch (e) {
            }
        </script>    
        <%
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>

    </body>
</html>
