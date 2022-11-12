<%-- 
    Document   : Receipt
    Created on : Dec 1, 2021, 6:10:05 PM
    Author     : Admin
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
                /////////////////////////////////////////////////////////////////////
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
                
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                    try {
                        con = cdb.getConnection();
                    } catch (Exception e) {
                    }
                    byte[] bytes = null;
                    try {
                        // carrega os arquivos jasper
                        String reportFileName = "deposits_debts.jrxml";
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
                        java.util.Date date = new java.util.Date();
                        DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                        Map prts = new HashMap();
                        prts.put("id", id);
                        prts.put("user", Lb.getUser());
                        prts.put("name", name);
                        prts.put("pname", pname);
                        prts.put("sector", sector);
                        prts.put("date_prt", "" + formatter.format(date));
                        prts.put("print_at", vls.trnslt(current_lang, "print_at"));
                        prts.put("periodo_of", vls.trnslt(current_lang, "periodo_of"));
                        prts.put("ReportName", vls.trnslt(current_lang, "deposits_debts"));
                        prts.put("usertitle", lang.lng(current_lang, "user"));
                        prts.put("varTotal", lang.lng(current_lang, "total"));
                        prts.put("varBalance", lang.lng(current_lang, "balance"));
                        prts.put("varDeposits", lang.lng(current_lang, "deposits"));
                        prts.put("varDeposit", lang.lng(current_lang, "deposit"));
                        prts.put("varRemoval", lang.lng(current_lang, "remove"));
                        prts.put("varDate", lang.lng(current_lang, "date"));
                        prts.put("varClientNameSurname", lang.lng(current_lang, "full_name"));
                        prts.put("varResidency", lang.lng(current_lang, "place_of_residence"));
                        prts.put("varTelephone", lang.lng(current_lang, "telephone"));
                        prts.put("varPurpose", lang.lng(current_lang, "ret_purpose"));
                        prts.put("sector2", vls.trnslt(current_lang, sector)); 
                        prts.put("varClientName", lang.lng(current_lang, "client_name"));
                        //prts.put("sale_date", sale_date);
                        // direcciona a saída do relatório para um stream
                        bytes = JasperRunManager.runReportToPdf(jasperReport, prts, con);
                        //System.out.println("Certo");
                        if (bytes != null && bytes.length > 0) {
                            // envia o relatório no formato PDF para o browser
                            response.setContentType("application/pdf");
                            response.addHeader("Content-disposition", "filename=deposits_debts" + Lb.getUser() + id + ".pdf");
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
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
