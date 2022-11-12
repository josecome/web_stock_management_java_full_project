<%-- 
    Document   : UpldPg
    Created on : Mar 1, 2022, 6:03:03 PM
    Author     : Admin
--%>


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
                File file;
                int maxFileSize = 5000 * 1024;
                int maxMemSize = 5000 * 1024;
                //ServletContext context = pageContext.getServletContext();
                String filePath = "" +cssn.getPathIrprt() + "\\webapps\\SGRB\\TEMPPATH\\";
                dirmng.checkIfDrctyExistandCreateIt(cssn.getPathIrprt());
                // Verify the content type
                String contentType = request.getContentType();
                try {
                    if ((contentType.indexOf("multipart/form-data") >= 0)) {
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        // maximum size that will be stored in memory
                        factory.setSizeThreshold(maxMemSize);

                        // Location to save data that is larger than maxMemSize.
                        dirmng.creatTmpFldr(); 
                        factory.setRepository(new File("c:\\temp"));

                        // Create a new file upload handler
                        ServletFileUpload upload = new ServletFileUpload(factory);

                        // maximum file size to be uploaded.
                        upload.setSizeMax(maxFileSize);

                        try {
                            // Parse the request to get file items.
                            List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));

                            // Process the uploaded file items
                            Iterator i = fileItems.iterator();

                            while (i.hasNext()) {
                                FileItem fi = (FileItem) i.next();
                                if (!fi.isFormField()) {
                                    // Get the uploaded file parameters
                                    String fieldName = fi.getFieldName();
                                    fileName = fi.getName();
                                    /*if(fileName.equalsIgnoreCase("sgrbdump.zip")){
                                       out.println("<span style='color: red;'>Antes de caregar o ficheiro, renomeie o nome para 'sgrbdump.zip'</span>");
                                       out.close();
                                       return;
                                    }*/
                                    boolean isInMemory = fi.isInMemory();
                                    long sizeInBytes = fi.getSize();

                                    // Write the file
                                    if (fileName.lastIndexOf("\\") >= 0) {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\")));
                                    } else {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\") + 1));
                                    }
                                    fi.write(file);

                                    /*out.println("Uploaded Filename: " + filePath
                                            + fileName + "<br>");*/
                                }
                            }
                            RestoreDB rbd = new RestoreDB(fileName);
                            rbd.processrstr();
                            out.println(rbd.processrstr());                            
                        } catch (Exception ex) {
                            //System.out.println(ex);
                            out.println(lang.lng(current_lang, "an_error_has_occurred") + ": " + ex.getMessage());
                        }
                        out.close();
                    } else {
        %>

        <h3><%=lang.lng(current_lang, "file_upload_for_database_restore")%>:</h3>
        <%=lang.lng(current_lang, "select_the_file_to_upload")%>: <br />
        <form action = "UpldPg.jsp" method = "post"
              enctype = "multipart/form-data">
            <input type = "file" name = "file" size = "50" />
            <br />
            <input type = "submit" value = "Carregar" />
        </form>

        <%
            }
        } catch (Exception e) {
        %>

        <h3><%=lang.lng(current_lang, "file_upload_for_database_restore")%>:</h3>
        <%=lang.lng(current_lang, "select_the_file_to_upload")%>: <br />
        <form action = "UpldPg.jsp" method = "post"
              enctype = "multipart/form-data">
            <input type = "file" name = "file" size = "50" />
            <br />
            <input type = "submit" value = "<%=lang.lng(current_lang, "upload")%>" />
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

