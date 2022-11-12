<%-- 
    Document   : Prvlgs
    Created on : Dec 4, 2021, 7:32:14 PM
    Author     : Admin
--%>

<%@page import="a.PreferedLang"%>
<%@page import="a.client_session"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
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
        <h1><%=lang.lng(current_lang, "privileges")%></h1>
        <p>
            <strong>Sectores</strong><br>
            f - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "hardware")%></strong><br>
            d - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "drugstore")%></strong><br>
            p - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "sale of parts")%></strong><br>
            m - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "grocery store")%></strong><br>
            r - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "restaurant")%></strong><br>
            b - <%=lang.lng(current_lang, "associate_the_user_with_the_package")%><strong><%=lang.lng(current_lang, "pub")%></strong>            
        </p>
        <p>
            <strong><%=lang.lng(current_lang, "view_data")%></strong><br>
            b - <%=lang.lng(current_lang, "fetch_data_to_view")%>
        </p>
        <p>
            <strong><%=lang.lng(current_lang, "reports")%></strong><br>
            p - <%=lang.lng(current_lang, "print_reports")%>
        </p>
        <p>
            <strong><%=lang.lng(current_lang, "see_tabs")%></strong><br>
            k - <%=lang.lng(current_lang, "see_shopping_tab")%><br>
            j - <%=lang.lng(current_lang, "see_previous_sales_tab")%><br>
            q - <%=lang.lng(current_lang, "see_tab_expenses")%><br>
            y - <%=lang.lng(current_lang, "see_sales_tab")%><br>
            h - <%=lang.lng(current_lang, "see_deposits_tab")%><br>
            g - <%=lang.lng(current_lang, "view_and_manage_the_management_tab")%>
        </p>
        <p>
            <strong><%=lang.lng(current_lang, "insert_records")%></strong><br>
            i - <%=lang.lng(current_lang, "insert")%><br>               
            u - <%=lang.lng(current_lang, "insert_and_edit_user")%><br>
            c - <%=lang.lng(current_lang, "insert_purchases")%><br>
            e - <%=lang.lng(current_lang, "enter_expenses")%><br>
            v - <%=lang.lng(current_lang, "enter_sales")%><br>
            n - <%=lang.lng(current_lang, "insert_invalid_articles")%><br>
            w - <%=lang.lng(current_lang, "insert_sale/price")%><br>
            s - <%=lang.lng(current_lang, "insert_deposit")%><br>
            u - <%=lang.lng(current_lang, "allocate_stock")%><br>
            z - <%=lang.lng(current_lang, "put_allocated_stock_as_processed")%><br>
            o - <%=lang.lng(current_lang, "generate_and_download_backup")%><br>
            a - <%=lang.lng(current_lang, "restore_database")%>
        </p>
    </body>
</html>
