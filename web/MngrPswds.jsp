<%-- 
    Document   : MngrPswds
    Created on : Dec 10, 2021, 7:34:50 PM
    Author     : Admin
--%>

<%@page import="a.PreferedLang"%>
<%@page import="a.client_session"%>
<%@page import="a.language"%>
<%@page import="a.get_lng_file"%>
<%@page import="a.Values"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SGRB</title>
        <link rel="icon" href="img/amora.png" type="image/x-icon" sizes="32x32">
        <link rel="icon" type="image/x-icon" href="/SGRB/img/amoraicon.ico" >
        <style>
            a:hover{                
                color: gold;
            }
        </style>
        <script>
            var requestmdsnh;
            var requestc;
function val_snh(){var a=document.getElementById("snh_1"),b=document.getElementById("senhaa2").value;4>b.length?(a.style.width="70px",a.style.backgroundColor="red",a.style.color="white",a.innerHTML="Fraco!"):3<b.length&&7>b.length?(a.style.width="70px",a.style.backgroundColor="yellow",a.style.color="green",a.innerHTML="Medio!"):(a.style.width="70px",a.style.backgroundColor="green",a.style.color="white",a.innerHTML="Forte!")}
function val_snh_verif(){var a=document.getElementById("snh_2"),b=document.getElementById("senhaa2").value,c=document.getElementById("senhaa3").value;b===c?(a.style.backgroundColor="green",a.innerHTML="Conscide!"):(a.style.backgroundColor="red",a.innerHTML="Nao conscide!")}
function mud_snh(){var a=document.getElementById("usuarioa").value,b=document.getElementById("senhaa1").value,c=document.getElementById("senhaa2").value,d=document.getElementById("senhaa3").value;if(c!==d)return document.getElementById("snh_2").innerHTML="Nao combina!",document.getElementById("snh_2").style.backgroundColor="red",!1;document.getElementById("snh_2").innerHTML="Certo!";document.getElementById("snh_2").style.backgroundColor="green";conexoes("/SGRB/r?t=2&acao=cmp_inf&prp=s&user="+a+"&usrnm="+
a+"&snh1="+b+"&snh2="+c+"&imagem=")}function conexoes(a){window.ActiveXObject?requestc=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(requestc=new XMLHttpRequest);requestc.onreadystatechange=res_conexoes;requestc.open("POST",a,!0);requestc.send()}function res_conexoes(){if(4===requestc.readyState){var a=requestc.responseText;try{document.getElementById("resultado").innerHTML=a}catch(b){alert("Falhou")}}};

          </script>
    </head>
    <body oncontextmenu="return false">
        <%
          Values vls = new Values();
          get_lng_file glng = new get_lng_file();
          language lang = new language(glng.getlngs());
          client_session cssn = new client_session();
          PreferedLang plng = new PreferedLang();
          String current_lang = plng.getPreferedLang();
        %>
        <a href="/SGRB/Login.jsp" style="float: left; text-decoration: none;">Login</a><br>
        <table id='pb' style="float: left; margin-top: 60px; background-color: #C0C0C0; border: 1px solid gray; filter: alpha(opacity=90);-moz-opacity: 0.9;opacity: 0.9;">

            <tr style=''>
                <td style=''>
                    <div style="margin-left: 10px;margin-top: 2px;">
                        <br><br>
                        <table style="margin-left: 10px;">
                            <tr><td colspan='2'><div id='resultado' style="color: green; background-color: white;"></div></td></tr>   
                            <tr><td><%=lang.lng(current_lang, "username")%></td><td><input type="text" name="usuario" id="usuarioa" value=""></td></tr>
                            <tr><td><%=lang.lng(current_lang, "current_password")%></td><td><input type="password" name="senha1" id="senhaa1" value=""></td></tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "new_password")%></td><td><input type="password" name="senha2"  id="senhaa2" onkeyup="val_snh()" value=""></td>  <td><div id="snh_1" style="background-color: gray; width: 70px; height: 14px; font-size: 12px; color: white;"></div></td>
                            </tr>
                            <tr>
                                <td><%=lang.lng(current_lang, "repeat_new_password")%></td><td><input type="password" name="senha3" id="senhaa3" value="" onkeyup="val_snh_verif()"></td><td><div id="snh_2" style="width: 70px; height: 14px; font-size: 12px; background-color: gray; color: white;"></div></td>
                            </tr>

                            <tr>
                                <td>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "accept"), "mud_snh()", "/SGRB/img/insertp4.png","","")%>
                                    <input type='hidden' name='transacao' value='101'>
                                </td>
                            </tr>

                        </table>
                    </div>
                </td>
            </tr>   
        </table>    
    </body>
</html>
