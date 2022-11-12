<%-- 
    Document   : error
    Created on : Feb 17, 2022, 12:31:35 AM
    Author     : Admin
--%>

<%@page import="a.client_session"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
        <%           
           get_lng_file glng = new get_lng_file();
           language lang = new language(glng.getlngs());
           client_session cssn = new client_session();
           String current_lang = cssn.getPreferedLang(); 
        %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SGRB</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
    </head>
    <body>
        <h1 style="color: red;"><%=lang.lng(current_lang, "after_configuring_designation_and_users,_it_cannot_refresh_the_browser")%>! <a href="/SGRB/Login.jsp"><%=lang.lng(current_lang, "login_page")%></a></h1>
    </body>
</html>
