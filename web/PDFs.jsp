<%-- 
    Document   : Receipt
    Created on : Dec 1, 2021, 6:10:05 PM
    Author     : Admin
--%>

<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.Format"%>
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
    <body>
        <%@page session="true" import="a.*" %> 
        <%
            a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {%>
        <%
            Connection con = null;
            Statement stmt = null;
            String b = "";
            String s = "";
            String sale_date = "";

            String clt = request.getParameter("clt");
            String name = request.getParameter("name");
            String di = request.getParameter("di");
            String df = request.getParameter("df");
            String tp = request.getParameter("tp");
            String usr = request.getParameter("user");
            String sector = request.getParameter("sector");
            String local = "";

            String artcls = "";
            String logo = "";
            Values vls = new Values();
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
                
            //////////////////////////////////////////////////////////////////// 
            if (di == null || di.trim().length() == 0) {
                di = "2022-01-01";
            }
            if (df == null || df.trim().length() == 0) {
                Format formatter;
                java.util.Date date = new java.util.Date();
                Calendar c = Calendar.getInstance();
                c.setTime(date);
                c.add(Calendar.DATE, 2);
                date = c.getTime();
                formatter = new SimpleDateFormat("yyyy-MM-dd");
                df = "" + formatter.format(date);
            }
            String tpp = "";
            if (tp.equalsIgnoreCase("d")) {
                tpp = "expenses";
            } else if (tp.equalsIgnoreCase("c")) {
                tpp = "purchases";
            } else if (tp.equalsIgnoreCase("v")) {
                tpp = "sales";
            } else if (tp.equalsIgnoreCase("g")) {
                tpp = "geral";
                /*out.print("<div style=\"color: red;\">Este relat&oacute;rio ainda n&atilde;o esta disponivel!</div>");
                return;*/
            } else if (tp.equalsIgnoreCase("gg")) {
                tpp = "geralg";
                /*out.print("<div style=\"color: red;\">Este relat&oacute;rio ainda n&atilde;o esta disponivel!</div>");
                return;*/
            } else if (tp.equalsIgnoreCase("ps")) {
                tpp = "purchase_sales";
            } else if (tp.equalsIgnoreCase("vg")) {
                tpp = "salesg";
            } else if (tp.equalsIgnoreCase("vg2")) {
                tpp = "salesg2";
            } else if (tp.equalsIgnoreCase("dg")) {
                tpp = "expensesg";
            } else if (tp.equalsIgnoreCase("cg")) {
                tpp = "purchasesg";
            } else if (tp.equalsIgnoreCase("psg")) {
                tpp = "purchase_salesg";
            } else if (tp.equalsIgnoreCase("psg2")) {
                tpp = "purchase_salesg2";
            } else if (tp.equalsIgnoreCase("stck")) {
                tpp = "stock";
            } else if (tp.equalsIgnoreCase("stckc")) {
                tpp = "stock_code";
            } else if (tp.equalsIgnoreCase("dpc")) {
                tpp = "deposits";
            } else if (tp.equalsIgnoreCase("dpv")) {
                tpp = "depositslist";
            }

            try {
                con = cdb.getConnection();
            } catch (Exception e) {
            }
            byte[] bytes = null;
            try {
                // carrega os arquivos jasper
                String reportFileName = tpp + ".jrxml";
                String pthfl = Strngs.pth_current_irprt_sgrb_local;
                if(!(cssn.getPathIrprt()).contains("Apache Tomcat 8.0.27")){
                   pthfl = cssn.getPathIrprt() + "\\webapps\\SGRB\\SGRB";
                }
                String reportPath = "" + pthfl + "\\" + reportFileName;
                String targetFileName = reportFileName.replace(".jrxml", ".pdf");
                JasperReport jasperReport = JasperCompileManager.compileReport(reportPath);
                // parâmetros, se houverem
                // recebo o valor do formulario e converte-o para inteiro
                String cknm = cssn.getOrgInf()[4];
                String cklc = cssn.getOrgInf()[5];
                String cklg = cssn.getOrgInf()[3];
                local = cssn.getOrgInf()[2];

                //System.out.println("cknm: " + cknm);
                //System.out.println("cklc: " + cklc);
                //System.out.println("cklg: " + cklg);

                if (cknm == null || cknm.trim().length() == 0) {
                    cknm = "_";
                }
                if (cklc == null || cklc.trim().length() == 0) {
                    cklc = "_";
                }
                if (cklg == null || cklg.trim().length() == 0) {
                    cklg = "_";
                }
                if (!cknm.equalsIgnoreCase("checked")) {
                    name = "_";
                }
                if (!cklc.equalsIgnoreCase("checked")) {
                    local = "_";
                }
                if (!cklg.equalsIgnoreCase("checked")) {
                    cklg = null;
                }
                String imgg = cssn.getOrgInf()[1];
                try {
                    String imga = imgg.split(",")[1];
                    imgg = imga;
                } catch (Exception e) {
                }
                BASE64Decoder decoder = new BASE64Decoder();
                ByteArrayInputStream bis = new ByteArrayInputStream(decoder.decodeBuffer(imgg));
                BufferedImage image = ImageIO.read(bis);
                bis.close();

                Map prts = new HashMap();
                prts.put("client_nr", clt);
                prts.put("user", usr);
                prts.put("name", name);
                prts.put("local", local);
                prts.put("data_venda", sale_date);
                prts.put("di", di);
                prts.put("df", df);
                prts.put("sector", sector); 
                prts.put("sector2", vls.trnslt(current_lang, sector)); 
                prts.put("pname", name);
                prts.put("logotipo", image);
                String periodo = "" + di + " à " + df;
                prts.put("periodo", periodo);
                prts.put("cklg", cklg);
                prts.put("print_at", vls.trnslt(current_lang, "print_at"));
                prts.put("periodo_of", vls.trnslt(current_lang, "periodo_of"));
                prts.put("ReportName", vls.trnslt(current_lang, tpp));
                prts.put("usertitle", lang.lng(current_lang, "user"));
                prts.put("pgarticle", lang.lng(current_lang, "article"));
                prts.put("pgtitle", lang.lng(current_lang, "requestforpayment"));                
                prts.put("varDate", lang.lng(current_lang, "date"));
                prts.put("varQuant", lang.lng(current_lang, "amount"));
                prts.put("varType", lang.lng(current_lang, "type"));
                prts.put("varValue", lang.lng(current_lang, "value"));
                prts.put("varObservation", lang.lng(current_lang, "observation"));
                prts.put("varPurchase", lang.lng(current_lang, "purchase"));
                prts.put("varCategory", lang.lng(current_lang, "category"));
                prts.put("varBalance", lang.lng(current_lang, "balance"));
                prts.put("varPrice", lang.lng(current_lang, "price"));
                prts.put("varEntry", lang.lng(current_lang, "entry"));
                prts.put("varOut", lang.lng(current_lang, "debt"));
                prts.put("varReportFrom", lang.lng(current_lang, "report_of"));
                prts.put("varSales", lang.lng(current_lang, "sales"));
                prts.put("varInvalid", lang.lng(current_lang, "invalid"));
                prts.put("varStatus", lang.lng(current_lang, "status"));
                prts.put("varProfitSt", lang.lng(current_lang, "profit"));
                prts.put("varProfit", lang.lng(current_lang, "profit"));
                prts.put("varIdClient", lang.lng(current_lang, "customer_id"));
                prts.put("varTotal", lang.lng(current_lang, "total"));
                prts.put("varTotalProfit", lang.lng(current_lang, "profit"));//
                prts.put("varProfitEst", lang.lng(current_lang, "profit_st"));
                prts.put("varGroup", lang.lng(current_lang, "group"));
                prts.put("varClientNameSurname", lang.lng(current_lang, "full_name"));
                prts.put("varClientName", lang.lng(current_lang, "client_name"));
                prts.put("varResidency", lang.lng(current_lang, "place_of_residence"));
                prts.put("varTelephone", lang.lng(current_lang, "telephone"));
                prts.put("varOtherMoney", lang.lng(current_lang, "other_currency"));
                prts.put("varCountry", lang.lng(current_lang, "country"));
                prts.put("varUsed", lang.lng(current_lang, "used"));
                prts.put("varDeposits", lang.lng(current_lang, "deposits"));
                prts.put("varDeposit", lang.lng(current_lang, "deposit"));
                prts.put("varOuts", lang.lng(current_lang, "debt"));
                prts.put("varLastDate", lang.lng(current_lang, "last_date"));
                prts.put("varPurpose", lang.lng(current_lang, "ret_purpose"));
                prts.put("varRemoval", lang.lng(current_lang, "remove"));
                prts.put("varProdCode", lang.lng(current_lang, "prod code"));
                //System.out.println(clt + "," + usr + "," + name + "," + local + "," + sale_date + "," + di + "," + df); 
                Format formatter;
                java.util.Date dt = new java.util.Date();
                formatter = new SimpleDateFormat("yyyyMMddHHmm");
                //prts.put("sale_date", sale_date);
                // direcciona a saída do relatório para um stream
                bytes = JasperRunManager.runReportToPdf(jasperReport, prts, con);
                //System.out.println("Certo");
                if (bytes != null && bytes.length > 0) {
                    // envia o relatório no formato PDF para o browser
                    response.setContentType("application/pdf");
                    response.addHeader("Content-disposition", "filename=Report" + formatter.format(dt) + ".pdf");
                    response.setContentLength(bytes.length);
                    ServletOutputStream ouputStream = response.getOutputStream();
                    ouputStream.write(bytes, 0, bytes.length);
                    ouputStream.flush();
                    ouputStream.close();
                }
            } catch (JRException e) {
                System.err.println("Erro: " + e);
            }
        %>
        <%
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
