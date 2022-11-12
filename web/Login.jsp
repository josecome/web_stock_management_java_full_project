<%-- 
    Document   : newjsp
    Created on : Nov 24, 2021, 12:38:19 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>SGRB</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="/SGRB/img/amoraicon.ico" >
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    </head>
    <body oncontextmenu="return false">
        <%
            Values vls = new Values();
            client_session cssn = new client_session();
            directories_mngmnt dirmng = new directories_mngmnt();
            
            get_lng_file glng = new get_lng_file();
            language lang = new language(glng.getlngs());           
            PreferedLang plng = new PreferedLang();
            String current_lang = plng.getPreferedLang();
           
            String logo = "";
            String logo2 = null;
            String nm = null;
            try{
                logo2 = cssn.getOrgInf()[1];
            }catch(Exception e){}   
            try{
                nm = cssn.getOrgInf()[0];
            }catch(Exception e){} 
            dirmng.creatDBFolder();
            RestoreDB rdb = new RestoreDB("");
            boolean rdbempty = rdb.dbIsEmpty(); 
            //rdb.insert(); //
            //if(1 == 1){return;}//
            if(rdb.dbIsEmpty() && (nm == null || nm.trim().length() == 0 || nm.equalsIgnoreCase("null"))){
               try{
                   rdb.insert();
               }catch(Exception e){} 
               %>
                 <meta http-equiv = "refresh" content = "0; url =Page2.jsp"/>
               <% 
               return;  
            }  
            if(!cssn.atlestoneky()){
               %>
                <meta http-equiv = "refresh" content = "0; url =Page2.jsp"/>
               <% 
               return;  
            }
            logo = cssn.logo();
        %>
        <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "Logo" style="width: 140px; height: 70px;"/><strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;"><%=lang.lng(current_lang, "stock_management_system")%></span></strong></div><br>
                    <%@page session="true" import="a.*" %>
                    <%

                        cssn.updateDate();
                        cssn.appversion_update();
                        String er = request.getParameter("er");
                        String z = request.getParameter("z");
                        String mtv = request.getParameter("m");
                        String d = "none";
                        String f = "none";
                        String k = "none";
                        if (er == null || er.trim().length() == 0) {
                            d = "none";
                        } else if (er.equalsIgnoreCase("y")) {
                            d = "block";
                        } else if (er.equalsIgnoreCase("op")) {
                            k = "block";
                        } else if (er.equalsIgnoreCase("s")) {
                            f = "block";
                        }
                        String sky = "";
                        if (sky == null || sky.trim().length() == 0) {
                        } else {
                            sky = "<div style='color: green; width: 100%;'>" + sky + "</div>";
                        }
                        String chng_clrFER = "";
                        String chng_clrFAR = "";
                        String chng_clrVPEC = "";
                        String chng_clrMERC = "";
                        String chng_clrREST = "";
                        String chng_clrBAR = "";
                        try {
                            for (String catd : vls.CatWithData()) {
                                if (catd.equalsIgnoreCase("Ferragens")) {
                                    chng_clrFER = "color: blue;";
                                }
                                if (catd.equalsIgnoreCase("Farmacia")) {
                                    chng_clrFAR = "color: blue;";
                                }
                                if (catd.equalsIgnoreCase("Venda de Pecas")) {
                                    chng_clrVPEC = "color: blue;";
                                }
                                if (catd.equalsIgnoreCase("Mercearia")) {
                                    chng_clrMERC = "color: blue;";
                                }
                                if (catd.equalsIgnoreCase("Restaurant")) {
                                    chng_clrREST = "color: blue;";
                                }
                                if (catd.equalsIgnoreCase("Bar")) {
                                    chng_clrBAR = "color: blue;";
                                }
                            }
                        } catch (Exception e) {
                        }
                    %>
                    <%=sky%>     
        <script>
function checkfer(){document.getElementById("rd_fer").checked=!1}function checkfar(){document.getElementById("rd_far").checked=!1}function checkvpec(){document.getElementById("rd_vpec").checked=!1}function checkmerc(){document.getElementById("rd_merc").checked=!1}function checkrest(){document.getElementById("rd_rest").checked=!1}function checkbar(){document.getElementById("rd_bar").checked=!1}
function selectEach(a){"f"===a?(checkvpec(),checkmerc(),checkrest(),checkbar(),checkfar()):"fm"===a?(checkfer(),checkvpec(),checkmerc(),checkrest(),checkbar()):"p"===a?(checkfer(),checkmerc(),checkrest(),checkbar(),checkfar()):"m"===a?(checkfer(),checkvpec(),checkrest(),checkbar(),checkfar()):"r"===a?(checkfer(),checkvpec(),checkmerc(),checkbar(),checkfar()):"b"===a&&(checkfer(),checkvpec(),checkmerc(),checkrest(),checkfar())}
function rjstmn(){let a=screen.width;try{var b=Math.round(.7*a);document.getElementById("tblmn").value=""+b}catch(c){}};

        </script>
        <style>
            input[type=text] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=text]:focus {
                border-color: green
            }
            input[type=password] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=password]:focus {
                border-color: green
            }
        </style>
        <span style="color: #50FF33; font-size: 12px; display: <%=f%>;"><%=lang.lng(current_lang, "successfully_logout")%>!</span>

        <div class="wrapper fadeInDown">
            <div id="formContent" style="border: 1px solid gray; width: 260px; height: 340px;margin: auto;">
                <!-- Login Form -->
                <form action='/SGRB/r' method='post' accept-charset='UTF-8' style="padding: 20px; background-color: #F2F3F4; background: linear-gradient(to bottom, #F2F3F4, white); ">
                    <input type="radio" id="rd_fer" name="rd_fer" value="Ferragens" onclick="selectEach('f')"><label for="rd_fer" style="<%=chng_clrFER%>"><%=lang.lng(current_lang, "hardware")%></label>
                    <input type="radio" id="rd_far" name="rd_far" value="Farmacia" onclick="selectEach('fm')"><label for="rd_far" style="<%=chng_clrFAR%>"><%=lang.lng(current_lang, "drugstore")%></label><br>
                    <input type="radio" id="rd_vpec" name="rd_vpec" value="Venda de Pecas" onclick="selectEach('p')"><label for="rd_vpec" style="<%=chng_clrVPEC%>"><%=lang.lng(current_lang, "sale of parts")%></label>
                    <input type="radio" id="rd_merc" name="rd_merc" value="Mercearia" onclick="selectEach('m')"><label for="rd_merc" style="<%=chng_clrMERC%>"><%=lang.lng(current_lang, "grocery store")%></label><br> 

                    <input type="radio" id="rd_rest" name="rd_rest" value="Restaurant" onclick="selectEach('r')"><label for="rd_rest" style="<%=chng_clrREST%>"><%=lang.lng(current_lang, "restaurant")%></label>
                    <input type="radio" id="rd_bar" name="rd_bar" value="Bar" onclick="selectEach('b')"><label for="rd_bar" style="<%=chng_clrBAR%>"><%=lang.lng(current_lang, "pub")%></label>
                    <a href="#" style="text-decoration: none;" onclick="alert('<%=lang.lng(current_lang, "blue_colors_meaning")%>')">?</a>
                    <br><br>
                    <input type="text" id="login" class="fadeIn second" name="login" placeholder="login"><br><br>
                    <input type="password" id="password" class="fadeIn third" name="password" placeholder="password"><br>
                    <span style="color: red; font-size: 12px; display: <%=d%>;"><%=mtv%>!</span><br>
                    <span style="color: red; font-size: 12px; display: <%=k%>;"><%=lang.lng(current_lang, "choose_at_least_one_option")%>!</span>
                    <br>
                    <a href="#" onclick="this.closest('form').submit();return false;">
                        <img src="/SGRB/img/login.png" style="width: 32px; height: 32px;" title="<%=lang.lng(current_lang, "login")%>">
                    </a>                    
                    <!--<input type="submit" class="fadeIn fourth" value="Entrar">-->
                    <input type='hidden' name='t' value='0'>
                    <input type='hidden' id="tblmn" name='scrsz'>
                </form>

                <!-- Remind Passowrd  -->
                <div id="formFooter" style="padding-left: 20px;">
                    <a href="/SGRB/MngrPswds.jsp" style="text-decoration: none;"><%=lang.lng(current_lang, "change_my_password")%></a>
                    <br>
                    <a href="https://amoraservices.org/fqstns.php" style="text-decoration: none;"><%=lang.lng(current_lang, "doubts")%></a>
                    <br>
                </div>

            </div>
        </div>
        <div style="position: fixed; bottom: 2px; right: 2px;">
            <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="http://www.amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
        </div>   
        <script>
            rjstmn();
        </script>
        <%
           boolean nd_cnt_serv = cssn.need_to_contact_server();
           if(nd_cnt_serv){
              String[] kary = null;
              kary = cssn.keystatus(); 
              cssn.last_status_of_user_system(kary[11], kary[6], "frmsystm");
           }
        %>
    </body>
</html>
