<%-- 
    Document   : UpldImg
    Created on : Mar 5, 2022, 12:24:24 PM
    Author     : Admin
--%>


<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import = "a.Values" %>
<%@page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@page import = "javax.servlet.http.*" %>
<%@page import = "org.apache.commons.fileupload.*" %>
<%@page import = "org.apache.commons.fileupload.disk.*" %>
<%@page import = "org.apache.commons.fileupload.servlet.*" %>
<%@page import = "org.apache.commons.io.output.*" %>
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
                Values vls = new Values();
                directories_mngmnt dirmng = new directories_mngmnt();
                String fileName = "";
                String fl_new_name = "";
                File file;
                int maxFileSize = 5000 * 1024;
                int maxMemSize = 5000 * 1024;
                //ServletContext context = pageContext.getServletContext();
                String filePath = "" + cssn.getPathIrprt() + "\\webapps\\SGRB\\img2\\";
                dirmng.checkIfDrctyExistandCreateIt(cssn.getPathIrprt());
                String contentType = request.getContentType();
                try {
                    if ((contentType.indexOf("multipart/form-data") >= 0)) {
                        // List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
                        List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
                        Iterator<FileItem> iter = items.iterator();
                        while (iter.hasNext()) {
                            FileItem item = iter.next();
                            if (item.isFormField()) {
                                String origName = item.getFieldName();
                                if ("img".equals(origName)) {
                                    fl_new_name = item.getString();
                                }
                            } else if (!item.isFormField()) {
                                // Process a file upload
                                String fieldName = item.getFieldName();
                                fileName = item.getName();
                                contentType = item.getContentType();
                                boolean isInMemory = item.isInMemory();
                                long sizeInBytes = item.getSize();

                                //here you change the name of the uploaded file and then write it 
                                try {
                                    String flupld = fl_new_name.replaceAll(" ", "_");
                                    fl_new_name = flupld;
                                } catch (Exception e) {
                                }
                                File uploadedFile = new File(filePath, fl_new_name + ".png");
                                item.write(uploadedFile);
                                try {
                                     File directory = new File("C:\\SGRB\\IMG");
                                     if (!directory.exists()) {
                                          directory.mkdir();
                                     }
                                } catch (Exception e) {
                                }
                                File destDir = new File("C:\\SGRB\\IMG");
                                try {
                                    FileUtils.copyFileToDirectory(uploadedFile, destDir, true);
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                                out.println("<span style='color: green;'>Ficheiro carregado!</span>");
                                out.close();
                            }
                        }
                    } else {
        %>

        <h3>Carregamento de Ficheiro para Restauracao de Banco de Dados:</h3>
        Seleciona o ficheiro a fazer carregamento: <br />
        <span style="color: blue;">Carregue imagens com a extensao <em>.png</em></span><br />
        <form action = "UpldImg.jsp" method = "post"
              enctype = "multipart/form-data">
            <input type="hidden" name="img" value="<%=request.getParameter("img")%>">
            <br />
            <input type = "file" name = "file" size = "50" />    
            <br />
            <input type = "submit" value = "Carregar" />
        </form>

        <%
            }
        } catch (Exception e) {
            //System.out.println("e: " + e.getMessage());
        %> 

        <h3><%=lang.lng(current_lang, "file_upload_for_database_restore")%>:</h3>
        <%=lang.lng(current_lang, "select_the_file_to_upload")%>: <br />
        <span style="color: blue;"><%=lang.lng(current_lang, "load_images_with_the_extension")%> <em>.png</em></span><br />
        <form action = "UpldImg.jsp" method = "post"
              enctype = "multipart/form-data">
            <input type="hidden" name="img" value="<%=request.getParameter("img")%>">
            <br />
            <input type = "file" name = "file" size = "50" />     
            <br />
            <input type = "submit" value = "Carregar" />
        </form>

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

