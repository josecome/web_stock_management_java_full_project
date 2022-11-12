<%-- 
    Document   : Receipt
    Created on : Dec 1, 2021, 6:10:05 PM
    Author     : Admin
--%>

<%@page import="a.Values"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="net.sf.jasperreports.export.SimpleExporterInput"%>
<%@page import="net.sf.jasperreports.export.SimpleOutputStreamExporterOutput"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="a.cdb"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.JRResultSetDataSource"%>
<%@page import="net.sf.jasperreports.engine.JRException"%>
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
        <%@page session="true" import="a.*" %> 
        <%
            a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {
                Connection con = null;
                Statement stmt = null;
                Values vls = new Values();
                String b = "";
                String s = "";
                String sale_date = "";
                String sector = request.getParameter("sector");
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
                                
                String clt = request.getParameter("clt");
                String name = request.getParameter("name");
                
                String user = Lb.getUser();
                String uusr = request.getParameter("user");
                if(uusr == null || uusr.trim().length() == 0){}
                else if(uusr.equalsIgnoreCase("Duplicate")){
                    user = lang.lng(current_lang, "duplicated");
                }
                
                int y = 1;
                try {

                    con = cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    String qry = "select id,CONCAT(CAST(user_datetime AS DATE),CONCAT(' ',CAST(user_datetime AS TIME))) as user_datetime "
                            + " from clients_requests where msname_us_time = '" + clt + "' and sector = '" + sector + "'";
                    //System.out.println("QRY: " + qry);
                    ResultSet rs = stmt.executeQuery(qry);

                    while (rs.next()) {
                        sale_date = rs.getString("user_datetime");
                        y = y + 1;
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
                if (y > 1) {
                    try {
                        con = cdb.getConnection();
                    } catch (Exception e) {
                    }
                    byte[] bytes = null;
                    try {
                        // carrega os arquivos jasper
                        String reportFileName = "invoice.jrxml";
                        String pthfl = Strngs.pth_current_irprt_sgrb_local;
                        if(!(cssn.getPathIrprt()).contains("Apache Tomcat 8.0.27")){
                             pthfl = cssn.getPathIrprt() + "\\webapps\\SGRB\\SGRB";
                        }
                        String reportPath = "" + pthfl + "\\" + reportFileName;
                        //System.out.println("reportPath: " + reportPath);
                        String targetFileName = reportFileName.replace(".jrxml", ".pdf");
                        JasperReport jasperReport = JasperCompileManager.compileReport(reportPath);
                        // parâmetros, se houverem
                        // recebo o valor do formulario e converte-o para inteiro
                        Map prts = new HashMap();
                        prts.put("client_nr", clt);
                        prts.put("user", user);
                        prts.put("name", name);
                        prts.put("pname", pname);
                        prts.put("sector", sector); 
                        prts.put("sector2", vls.trnslt(current_lang, sector)); 
                        prts.put("data_venda", sale_date);                        
                        prts.put("pgtitle", lang.lng(current_lang, "requestforpayment"));
                        prts.put("pgnotice", lang.lng(current_lang, "doesnotserveasaninvoice"));
                        prts.put("pgarticle", lang.lng(current_lang, "article"));
                        prts.put("payment", lang.lng(current_lang, "amountpayable"));
                        prts.put("usertitle", lang.lng(current_lang, "user"));
                        prts.put("totaltitle", lang.lng(current_lang, "total"));
                        //prts.put("sale_date", sale_date);
                        // direcciona a saída do relatório para um stream
                        bytes = JasperRunManager.runReportToPdf(jasperReport, prts, con);
                        //System.out.println("Certo");
                        if (bytes != null && bytes.length > 0) {
                            // envia o relatório no formato PDF para o browser
                            response.setContentType("application/pdf");
                            response.addHeader("Content-disposition", "filename=Invoice" + Lb.getUser() + clt + ".pdf");
                            response.setContentLength(bytes.length);
                            ServletOutputStream ouputStream = response.getOutputStream();
                            ouputStream.write(bytes, 0, bytes.length);
                            ouputStream.flush();
                            ouputStream.close();
                        }
                    } catch (JRException e) {
                        System.err.println("Erro: " + e);
                    }

                } else {
        %>
        <div style="color: red; margin-top: 30%;"> <%=lang.lng(current_lang, "this_order_with_code")%> <strong style="color: blue;"><%=clt%></strong> <%=lang.lng(current_lang, "not_yet_registered")%>!</div>
        <%
            }
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
