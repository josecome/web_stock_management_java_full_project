<%-- 
    Document   : Articles
    Created on : Jan 11, 2022, 7:50:29 PM
    Author     : Admin
--%>

<%@page import="a.Values"%>
<%@page import="a.cdb"%>
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
        var sctr = "<%=request.getParameter("sector")%>";   
        var usr = "<%=request.getParameter("user")%>"; 
        var cnfrm_msg = "<%=lang.lng(current_lang, "artcls_cnfrm_msg")%>";
        function filart(a,d){var b;d=d.toUpperCase();a=document.getElementById(a).getElementsByTagName("tr");for(b=1;b<a.length;b++){var c=a[b].getElementsByTagName("td")[0];var f=a[b].getElementsByTagName("td")[0];var g=a[b].getElementsByTagName("td")[6];var e=a[b].getElementsByTagName("td")[6];if(c||e){c=c.textContent||c.innerText;f=f.textContent||f.innerText;g=g.textContent||g.innerText;e=e.textContent||e.innerText;if(null===c||""===c)c="_";if(null===f||""===f)f="_";if(null===g||""===g)g="_";if(null===
e||""===e)e="_";if(-1<c.toUpperCase().indexOf(d)||-1<f.toUpperCase().indexOf(d)||-1<g.toUpperCase().indexOf(d)||-1<e.toUpperCase().indexOf(d)){a[b].style.visibility="";try{a[1].parentNode.insertBefore(a[b],a[1])}catch(h){}}else a[b].style.visibility="hidden"}}}
function blckAndEnblBtnSbmt(){var a=document.getElementById("txtartcs"),d=document.getElementById("btn1"),b=document.getElementById("btn2");if(null===a.value||""===a.value||"undefined"===typeof a.value){try{d.disabled=!1}catch(c){}try{b.disabled=!1}catch(c){}}else{try{d.disabled=!0}catch(c){}try{b.disabled=!0}catch(c){}}}
function upldImg(a){if(confirm(cnfrm_msg))return window.open("/SGRB/UpldImg.jsp?sector="+sctr+"&user="+usr+"&img="+a,"popUpWindow","height=1000,width=1200,left=10,top=10,,scrollbars=yes,menubar=no"),!1};
function updtArt(v){
    try{
        document.getElementById(v).value = "1";        
    }catch(e){alert(e.message);}
}
        </script>
        <style>
            table,tr,td {
                border: 1px solid gray;
                border-collapse: collapse;
            }
        </style>
    </head>
    <body oncontextmenu="return false">
        <%@page session="true" import="a.*" %> 
        <%
            a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {
                Values vls = new Values();
                Connection con = null;
                Statement stmt = null;
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
        %>
            
        <h1><%=lang.lng(current_lang, "change_article_attributes")%></h1><br>
        <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtartcs" style="width: 240px;">
        <input type="button" onclick="filart('tbartcs', document.getElementById('txtartcs').value), blckAndEnblBtnSbmt()" value="<%=lang.lng(current_lang, "search")%>">
        <br>
        <form action='/SGRB/r' method='post' accept-charset='UTF-8'>
            <%=vls.dinmcbtn(lang.lng(current_lang, "update"), "this.closest('form').submit();return false;", "/SGRB/img/editp.png", "", "")%>
            <br>
            <%
                String cs = vls.articles_update(request.getParameter("sector"));
            %>
            <%=cs%>
            <input type='hidden' name='t' value='12'><br>
            <input type='hidden' name='user' value='<%=request.getParameter("user")%>'><br>
            <%=vls.dinmcbtn(lang.lng(current_lang, "update"), "this.closest('form').submit();return false;", "/SGRB/img/editp.png", "", "")%>        
        </form>
        <%
        } else {
        %>
        <span style="color: red;"><%=lang.lng(current_lang, "your_session_has_expired")%>!</span>  
        <%
            }
        %>
    </body>
</html>
