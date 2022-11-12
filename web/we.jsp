<%-- 
    Document   : we
    Created on : Feb 17, 2022, 1:24:40 PM
    Author     : Admin
--%>

<%@page import="a.PreferedLang"%>
<%@page import="a.client_session"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SGRB</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="img/amoraicon.ico" >
    </head>
    <script>
        function callLoginPage() {
            window.open("Login.jsp", "SGRB", "toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=yes, top=0, left=0, width=" + screen.availWidth + ",height=" + screen.availHeight + "");
        }
    </script>   
    <body>
        <%           
           get_lng_file glng = new get_lng_file();
           language lang = new language(glng.getlngs());
           PreferedLang plng;
           plng = new PreferedLang();
           String  current_lang = plng.getPreferedLang();
        %>
        <a href="#" onclick="callLoginPage()" style="text-decoration: none;"><%=lang.lng(current_lang, "page_login")%></a>
    </body>
</html>
