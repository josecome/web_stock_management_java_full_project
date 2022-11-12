<%-- 
    Document   : MainPage
    Created on : Nov 24, 2021, 12:41:24 AM
    Author     : Admin
--%>

<%@page import="java.net.MalformedURLException"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="javax.net.ssl.SSLSocketFactory"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" import="a.*" %> 
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/Chart.min.js"></script>
        <%
            String sector = request.getParameter("sector");
            String rd_fer = request.getParameter("rd_fer");
            String rd_far = request.getParameter("rd_far");
            String rd_vpec = request.getParameter("rd_vpec");
            String rd_merc = request.getParameter("rd_merc");
            String rd_rest = request.getParameter("rd_rest");
            String rd_bar = request.getParameter("rd_bar");
            String cfusr = request.getParameter("cfusr");
            directories_mngmnt dirmng = new directories_mngmnt();
            dirmng.checkIfDrctyExistandCreateIt(cssn.getPathIrprt());
            //System.out.println(sector +","+ rd_fer +","+ rd_far+","+ rd_vpec+","+ rd_merc +","+ rd_rest +","+ rd_bar); 
            try{
                if((sector == null && rd_fer == null && rd_far == null && rd_vpec == null && rd_merc == null && rd_rest == null && rd_bar == null)
                    || (sector.trim().length() == 0 && rd_fer.length() == 0 && rd_far.length() == 0 && rd_vpec.length() == 0 && rd_merc.length() == 0
                       && rd_rest.length() == 0 && rd_bar.length() == 0)){
                %>
                    <meta http-equiv = "refresh" content = "0; url =/SGRB/Login.jsp?er=op"/>
                <% 
                   return;    
                }
            }catch(Exception e){
                /*System.out.println("1e: " + e.getMessage());*/   
            }
            /*Start of Validation Session*/
            String scrsz = request.getParameter("scrsz");
            Session_Validation ss_vld = new Session_Validation(scrsz);
            String artcls = ss_vld.getArtcls();
            String logo = ss_vld.getLogo();
            String sector2 = ss_vld.getSector2();
            String lnk_disabled = ss_vld.getLnk_disabled();
            String sky = ss_vld.getSky();
            String dsbld = ss_vld.getDsbld();
            String dsbld4 = ss_vld.getDsbld4();
            String version_status = ss_vld.getVersion_status();
            String subsrs_nr = ss_vld.getSubsrs_nr();
            String sky2 = ss_vld.getSky2();
            /*End of Validation Session*/
            Values vls = new Values();

            if (dsbld4.equalsIgnoreCase("disabled") && !sky.contains("green")) {

        %>
        <meta http-equiv = "refresh" content = "10; url=/SGRB/Page2.jsp?z=<%=sky2%>"/>
        <%
            }             
            /*dsbld = "disabled";*/            
            a.lb Lb = (a.lb) session.getAttribute("lb");
            a.aw Ab = (a.aw) request.getAttribute("aw");
            if (Lb != null && Lb.getStatus()) {
                if (cfusr == null || cfusr.trim().length() == 0) {
                    cfusr = "a";
                }                
                if (rd_fer == null || rd_fer.trim().length() == 0) {
                    rd_fer = "z";
                }
                if (rd_far == null || rd_far.trim().length() == 0) {
                    rd_far = "z";
                }
                if (rd_vpec == null || rd_vpec.trim().length() == 0) {
                    rd_vpec = "z";
                }
                if (rd_merc == null || rd_merc.trim().length() == 0) {
                    rd_merc = "z";
                }
                if (rd_rest == null || rd_rest.trim().length() == 0) {
                    rd_rest = "z";
                }
                if (rd_bar == null || rd_bar.trim().length() == 0) {
                    rd_bar = "z";
                }

                if (rd_fer.equalsIgnoreCase("Ferragens")) {
                    sector = "Ferragens";
                } else if (rd_far.equalsIgnoreCase("Farmacia")) {
                    sector = "Farmacia";
                } else if (rd_vpec.equalsIgnoreCase("Venda de Pecas")) {
                    sector = "Venda de Pecas";
                } else if (rd_merc.equalsIgnoreCase("Mercearia")) {
                    sector = "Mercearia";
                } else if (rd_rest.equalsIgnoreCase("Restaurant")) {
                    sector = "Restaurant";
                } else if (rd_bar.equalsIgnoreCase("Bar")) {
                    sector = "Bar";
                } else{
                    sector = "z";
                }
                if(sector.equalsIgnoreCase("z")){
                   String sctr = request.getParameter("sector"); 
                   if(sctr == null || sctr.trim().length() == 0){                       
                   }
                   else{
                        sector = sctr;
                   }
                }
                sector2 = sector;
                try {
                    String sctr2 = sector2.replaceAll("Venda de Pecas", "Venda de Pe&ccedil;as");
                    sector2 = sctr2;
                } catch (Exception e) {
                }
                try {
                    String sctr2 = sector2.replaceAll("Farmacia", "Farm&aacute;cia");
                    sector2 = sctr2;
                } catch (Exception e) {
                }
                try {
                    String sctr2 = sector2.replaceAll("Restaurant", "Restaurante");
                    sector2 = sctr2;
                } catch (Exception e) {
                }

                if (sector.equalsIgnoreCase("z")) {
                    out.print("Porfavor, deve escolher uma op&ccedil;&atilde;o. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
                if (sector.equalsIgnoreCase("Ferragens") && !Lb.getRoles().contains("f")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Ferragens</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
                if (sector.equalsIgnoreCase("Farmacia") && !Lb.getRoles().contains("d")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Farmacia</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
                if (sector.equalsIgnoreCase("Venda de Pecas") && !Lb.getRoles().contains("p")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Venda de Pecas</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }

                if (sector.equalsIgnoreCase("Mercearia") && !Lb.getRoles().contains("m")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Mercearia</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
                if (sector.equalsIgnoreCase("Restaurant") && !Lb.getRoles().contains("r")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Restaurant</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
                if (sector.equalsIgnoreCase("Bar") && !Lb.getRoles().contains("b")) {
                    out.print("As tuas credencias n&atilde;o est&atilde;o associadas a <strong>Bar</strong>. <a href='/SGRB/Login.jsp'>Voltar!</a>");
                    out.close();
                    return;
                }
        %>
        <script>
            window.onload = function () {
                document.body.style.display = "block";
            };
            var languag = "<%=lang.lng(current_lang, "lang_option")%>";
            var noftbls = <%=vls.ms_total()%>;
            var gusrlgn = "<%=Lb.getUser()%>";
            var gsector = "<%=sector%>";
            var groles = "<%=Lb.getRoles()%>";
            var gscrsz = "<%=scrsz%>";            
            var the_key_software_or_subscription_has_expired = "<%=lang.lng(current_lang, "the_key,_software_or_subscription_has_expired")%>";
            var you_dont_have_enough_privileges_to_see_this_part = "<%=lang.lng(current_lang, "you_don't_have_enough_privileges_to_see_this_part")%>";
            var the_amount_of_discount_for_each_item_cannot_be_greater_than = "<%=lang.lng(current_lang, "the_amount_of_discount_for_each_item_cannot_be_greater_than_the_amount_of_items_to_be_purchased!\nre-enter_the_amount")%>";
            var language_change_takes_effect_after_restarting_or_entering_new_page = "<%=lang.lng(current_lang, "language_change_takes_effect_after_restarting_or_entering_new_page")%>";
            var this_table_is_still_occupied_if_you_are_the_responsible_user_you_can_only_add_articles = "<%=lang.lng(current_lang, "this_table_is_still_occupied,_if_you_are_the_responsible_user_you_can_only_add_articles")%>";
            var pending_payment_ask_to_resolve_the_payment_situation_to_free_the_place = "<%=lang.lng(current_lang, "pending_payment,_ask_to_resolve_the_payment_situation_to_free_the_place")%>";
            var resource_unavailable = "<%=lang.lng(current_lang, "resource_unavailable")%>";
            var chose_food_and_alcohol_rectify = "<%=lang.lng(current_lang, "chose_food_and_alcohol,_rectify")%>";
            var create_new_customer = "<%=lang.lng(current_lang, "create_new_customer")%>";
            var select_the_customer_in_the_table_referring_to = "<%=lang.lng(current_lang, "select_the_customer_in_the_table_referring_to_the_customers_in_this_tab_and_proceed_with_the_sale")%>";
            var price_is_not_considered_in_this_section = "<%=lang.lng(current_lang, "price_is_not_considered_in_this_section")%>";
            var tblgroup = "<%=lang.lng(current_lang, "group")%>";
            var tblorder = "<%=lang.lng(current_lang, "order")%>";
            var tblarticle = "<%=lang.lng(current_lang, "article")%>";
            var lucroest = "<%=lang.lng(current_lang, "profit_st")%>";
            var tblquant = "<%=lang.lng(current_lang, "amount")%>";
            var tblrmved = "<%=lang.lng(current_lang, "removed")%>";
            var tblrmvl = "<%=lang.lng(current_lang, "removal")%>";
            var tblprice = "<%=lang.lng(current_lang, "price")%>";            
            var tblcategory = "<%=lang.lng(current_lang, "category")%>";
            var total = "<%=lang.lng(current_lang, "total")%>";
            var totalused = "<%=lang.lng(current_lang, "total_used")%>";
            var deposited = "<%=lang.lng(current_lang, "deposited")%>";
            var regists = "<%=lang.lng(current_lang, "records")%>";
            var paid = "<%=lang.lng(current_lang, "paid")%>";
            var deposits = "<%=lang.lng(current_lang, "deposits")%>";
            var topen = "<%=lang.lng(current_lang, "open")%>";
            var tedit = "<%=lang.lng(current_lang, "edit")%>";
            var trmv = "<%=lang.lng(current_lang, "remove")%>";            
            var management = "<%=lang.lng(current_lang, "management")%>";
            var restoration = "<%=lang.lng(current_lang, "restoration")%>";
            var added_sale = "<%=lang.lng(current_lang, "added_sale")%>";
            var all_fields_must_be_filled = "<%=lang.lng(current_lang, "all_fields_must_be_filled")%>";
            var normal_sale = "<%=lang.lng(current_lang, "normal_sale")%>";
            var allocations = "<%=lang.lng(current_lang, "allocations")%>";
            var sale_removed = "<%=lang.lng(current_lang, "sale_removed")%>";
            var added_sale = "<%=lang.lng(current_lang, "added_sale")%>";
            var sales = "<%=lang.lng(current_lang, "sales")%>";     
            var clientname = "<%=lang.lng(current_lang, "client_name")%>";
            var cliente = "<%=lang.lng(current_lang, "client")%>"; 
            var free = "<%=lang.lng(current_lang, "free")%>";                   
            var pending = "<%=lang.lng(current_lang, "pending")%>"; 
            var busy = "<%=lang.lng(current_lang, "busy")%>";             
            var tblcodprod = "<%=lang.lng(current_lang, "prod code")%>"; 
            var tblbarcode = "<%=lang.lng(current_lang, "barcode")%>";             
            var tbltipo = "<%=lang.lng(current_lang, "type")%>"; 
            var tblmarkrmv = "<%=lang.lng(current_lang, "marked_rmv")%>"; 
            var fill_in_customer_name = "<%=lang.lng(current_lang, "fill_in_customer_name")%>";
            
            var confirm_with_ok_to_continue_or_cancel_to_cancel = "<%=lang.lng(current_lang, "confirm_with_ok_to_continue_or_cancel_to_cancel")%>";
            var do_you_want_to_associate_with_a_customer = "<%=lang.lng(current_lang, "do_you_want_to_associate_with_a_customer")%>";
            var unloakbtn = "<%=lang.lng(current_lang, "processing...")%>";
            var unloakmsg = "<%=lang.lng(current_lang, "unloakmsg")%>";
            var passwordunlk = "<%=lang.lng(current_lang, "password")%>";
            var wrong_credentials = "<%=lang.lng(current_lang, "wrong_credentials")%>";
            var newpageloginagain = "<%=lang.lng(current_lang, "newpageloginagain")%>"; 
            
            noftbls = noftbls + 1;
            <%
                String dsbld2 = dsbld;
                if (dsbld2 == null || dsbld2.trim().length() == 0) {
                    dsbld2 = "a";
                }              
            %>
            var gdsbld = "<%=dsbld2%>";
            var cfusr = "<%=cfusr%>";

var requestval,rsdv=document.getElementById("dvrst"),vndits=[],tprck="z",prvk="z",hvp="",hus="",hds="",hcm="",plst="",estp="",hva2="",hcmi="",hdpst="",glbexp="0",glbdshb="0",glbpurc="0",glbpurc2="0",glbgu="0",glbgvp="0",glbprodl="0",glbva="0",glbest="0",glbv="0",glbpedv="0",glbfctry="0",glbdpst="0",zz=0,reqnmber="a",reqnmber2="a",reqnmber3="a",fcty="",smvlsglb=0,clickedlstreqvend="yes",lgtostr="",lastartprc=0,ss=.01,lstpurcqty="",lstart="",lstart2="",stckupd1="no",stckupd2="no",stckupd3="no",lsturl=
"",lstfctry="",slsalc="a",gbtnpdrpag="1",gbtnprcvenda="1",gbtninsrtvend="1",gbtninsrtpedvend="1",gbtnPedIns="1";let IntervalSrvrChk;var p="a",nrfb="z",nvlst="",tblvd="",rr="",tm="",requestc;
function setPropLng(a){if("portuguese"===languag){if(a.includes("rocessado com sucesso"))return"Processado com sucesso"}else if("english"===languag){if(a.includes("rocessado com sucesso"))return"Successfully processed"}else if("spanish"===languag){if(a.includes("rocessado com sucesso"))return"Procesado con \u00e9xito"}else if("french"===languag&&a.includes("rocessado com sucesso"))return"Trait\u00e9 avec succ\u00e8s";return a}
function chstb(a){if("disabled"===gdsbld&&"dshb"!==a)return alert(the_key_software_or_subscription_has_expired+"!"),!1;if("gst"===a&&!groles.includes("g")||"rlt"===a&&!groles.includes("p")||"cmps"===a&&!groles.includes("k")||"vndr"===a&&!groles.includes("j")||"dsps"===a&&!groles.includes("q")||"vnds"===a&&!groles.includes("y")||"dpst"===a&&!groles.includes("h"))return alert(you_dont_have_enough_privileges_to_see_this_part+"!"),!1;if("mn"===a)try{document.getElementById("btnmn").style.display="none"}catch(c){}else try{document.getElementById("btnmn").style.display=
"block"}catch(c){}var b=document.getElementById(a);"dshb vnds cmps dsps gst rlt vndr prdest ttrl ms dpst mn bckr hlpdsk snos".split(" ").forEach(function(c,d){try{document.getElementById(c).style.display="none"}catch(f){}});b.style.display="block";try{document.getElementById("dvrst").innerHTML=""}catch(c){}try{"vnds"===a||"ms"===a||"mn"===a?document.getElementById("periodo").style.display="none":document.getElementById("periodo").style.display="block"}catch(c){}if("vnds"!==a)try{document.getElementById("vendcnv").style.display=
"none"}catch(c){}if("bckr"===a)try{document.getElementById("lnkdwnld").innerHTML=""}catch(c){}if("mn"===a)try{document.getElementById("mspymtrqst").style.display="none"}catch(c){}else if("vnds"===a)try{document.getElementById("mspymtrqst").style.display="block"}catch(c){}"cmps"===a&&retinfpurc();"dsps"===a&&retinfexp();"gst"===a&&(retinggu(),"g"===cfusr&&history.replaceState("SGRB","SGRB","SGRB/r"),cfusr="a");"vndr"===a&&retinfva();"prdest"===a&&retinfest();"dshb"===a&&retinfdshb();"dpst"===a&&retdpst();
"vnds"===a&&(retinv(),"yes"===stckupd2&&(processar("lstprdvendas","b"),stckupd2="no"));"ms"===a?(gnrtplcs(),startlookstate(),disabclntnrinf(),processar("lstprdpedvendas","b")):stoplookstate();"cmps"===a||"dsps"===a||"vndr"===a||"gst"===a?document.getElementById("dvrwsintbls").style.display="block":document.getElementById("dvrwsintbls").style.display="none"}
function processar(a,b){try{document.getElementById("dvprcssr").style.display="block"}catch(c){}if("b"===b||"vart"===b||"vpr"===b||"vart2"===b||"vpr2"===b||"cdbar"===b||"unlckscrn"===b)processarb(a,b);else if(confirm(confirm_with_ok_to_continue_or_cancel_to_cancel))processarb(a,b);else try{document.getElementById("dvprcssr").style.display="none"}catch(c){}}
function processarb(a,b){tprck=b;prvk=a;var c="";if("g"===a&"vp"===b)c=vendprec_nv();else if("g"===a&"u"===b)c=usuar_nv();else if("lng"===b)c="&lng="+a;else if("g"===a&"artplst"===b)c=artprodlst();else if("g"===a&"prodl"===b)c=prodlst();else if("d"===a&"d"===b)c=desp_nv();else if("c"===a&"c"===b)c=comp_nv();else if("unlckscrn"===a&"unlckscrn"===b)c="&s="+document.getElementById("passwrdunlkscrn").value;else if("ci"===a&"ci"===b)c=comp_nvinv();else if("v"===a&"v"===b){if("1"===gbtnprcvenda){desabledelement();
try{document.getElementById("dvprcssr").style.display="none"}catch(e){}return!1}c=reg_venda()}else if("sysssn"===a&"sysssn"===b)c=getsysidpwd();else if("dpst"===a&"dpst"===b)c=getdpstvls();else if("stplc"===b)c="&m="+a;else if("pedartins"===b)c="&"+a;else if("rqpyt"===b){if("1"===gbtnpdrpag){desabledelement();try{document.getElementById("dvprcssr").style.display="none"}catch(e){}return!1}c="&m="+document.getElementById("msnmbr").innerHTML;impinvc()}else if("stkalc"===b)c="&m="+a;else if("fctry"===
b)lstfctry=c=bsccaresp(document.getElementById("fctrynvl").value),c="&fc="+c;else if("mstotal"===b)c="&mstl="+document.getElementById("mstotal").value;else if("b"===b)c=prv(a),"est"===a&&(glbest="1"),"gu"===a&&(glbgu="1"),"d"===a&&(glbexp="1"),"c"===a&&(glbpurc="1"),"va"===a&&(glbva="1"),"dpst"===a&&(glbdpst="1");else if("n"===b){c="";try{document.getElementById("ass_client").style.display="none"}catch(e){}try{document.getElementById("ass_client_label").style.display="none"}catch(e){}try{document.getElementById("ass_client").value=
""}catch(e){}}else if("vart"===b)c=vartp();else if("vart2"===b)c=vartp2();else if("vpr"===b){c=vprc();try{ss=parseFloat(document.getElementById("vend_prc").value)}catch(e){ss=.01}var d=document.getElementById("vend_quant").value,f=1;try{f=Number(d)}catch(e){f=1}if(0>ss){if(document.getElementById("spvendtp").innerHTML="Fazendo desconto!",document.getElementById("spvendtp").style.color="green",f>ValQuantDscnt(document.getElementById("vend_art").value)){alert(the_amount_of_discount_for_each_item_cannot_be_greater_than);
try{document.getElementById("dvprcssr").style.display="none"}catch(e){}document.getElementById("vend_quant").value="1";processdescount(document.getElementById("txtdescnt").value);return!1}}else document.getElementById("spvendtp").innerHTML=""+normal_sale+"!",document.getElementById("spvendtp").style.color="blue"}else"vpr2"===b?c=vprc2():"va"===b?c=vant():"rc"===b||"rd"===b||"rva"===b||"rgvp"===b?c="&id="+a+lvlrmv():"edc"===b?c=csedit(a):"cdbar"===b&&(c="&id="+a);d=document.getElementById("di").value;
f=document.getElementById("df").value;a="/SGRB/r?t=2&dsbld="+gdsbld+"&di="+d+"&df="+f+"&user="+gusrlgn+"&sector="+gsector+"&acao="+b+c+nmbrofrecds(a);lsturl="/SGRB/r?t=1&di="+d+"&df="+f+"&user="+gusrlgn+"&sector="+gsector;window.ActiveXObject?requestaval=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(requestval=new XMLHttpRequest);requestval.onreadystatechange=function(){if(4===requestval.readyState){var e=requestval.responseText;if("newpageloginagain"===e.replace(/\s+/g,""))alert(newpageloginagain);
else if("b"===tprck){if("dhs"===prvk){document.getElementById("dshtp").innerHTML=e.split("::")[0];var g=[],h=[],k=[],m=[],r=[],n=e.split("::")[1].split(",");g[0]=Math.abs(parseFloat(n[0]))||0;g[1]=Math.abs(parseFloat(n[1]))||0;g[2]=Math.abs(parseFloat(n[2]))||0;n=e.split("::")[2];var q=n.split(":")[0].split(",");try{for(e=0;e<q.length;e++)h[e]=Math.abs(parseFloat(q[e]))||0}catch(l){}q=n.split(":")[1].split(",");try{for(e=0;e<q.length;e++)k[e]=Math.abs(parseFloat(q[e]))||0}catch(l){}q=n.split(":")[2].split(",");
try{for(e=0;e<q.length;e++)m[e]=Math.abs(parseFloat(q[e]))||0}catch(l){}n=n.split(":")[3].split(",");try{for(e=0;e<n.length;e++)r[e]=Math.abs(parseFloat(n[e]))||0}catch(l){}dhschrts(g,h,k,m,r);glbdshb="1"}else if("mspymtrqst"===prvk)document.getElementById("mspymtrqst").innerHTML=e,"no"===clickedlstreqvend&&setTimeout(function(){processar("lstprdvendas","b")},500),"no"===clickedlstreqvend;else if("rqifm"===prvk){try{gbtninsrtvend="0"}catch(l){}try{gbtnprcvenda="0"}catch(l){}rqifmart(e)}else if("lstprdvendas"===
prvk)document.getElementById("txtprdvendas").value="",document.getElementById("dvlstprdvendas").innerHTML=e;else if("lstprdpedvendas"===prvk)document.getElementById("txtprdpedvendas").value="",document.getElementById("dvlstprdpedvendas").innerHTML=e;else if("est"===prvk)stckupd3="no",document.getElementById("txtdvrestb").value="",document.getElementById("dvrestb").innerHTML=e;else try{filltbl(e,prvk)}catch(l){}prvk=tprck="z"}else if("cdbar"===tprck)fillProdCodBar(e);else if("unlckscrn"===tprck)"yes"===
e.replace(/\s+/g,"")?unlockscreenfnt(unloakbtn):alert(wrong_credentials);else if("lng"===tprck)alert(""+e+" "+language_change_takes_effect_after_restarting_or_entering_new_page+"!");else if("lnkdwn"===tprck)try{document.getElementById("lnkdwnld").innerHTML=e}catch(l){}else if("n"===tprck){document.getElementById("idc").innerHTML=e;document.getElementById("clientanome").value="Consumidor";vndits=[];rfrsh_vnd();lmp_vend_nv();document.getElementById("tbdvrvsum").innerHTML="";try{gbtninsrtvend="0"}catch(l){}try{gbtnprcvenda=
"0"}catch(l){}try{document.getElementById("btnVendIns").disabled=!1}catch(l){}}else if("vart"===tprck||"vart2"===tprck)vndart(e,tprck);else if("vpr"===tprck)document.getElementById("vend_prc").value=e,0>ss&&processdescount(document.getElementById("txtdescnt").value);else if("vpr2"===tprck)document.getElementById("pedvend_prc").value=e;else{document.getElementById("dvrst").style.display="block";document.getElementById("dvrst").innerHTML=setPropLng(e);"stplc"===tprck&&e.includes("rocessado com sucesso")&&
setbzz(zz,prvk);if("rqpyt"===tprck&&e.includes("rocessado com sucesso")){gbtnpdrpag="1";setfr(zz,prvk);try{gbtnPedIns="1"}catch(l){}try{gbtninsrtpedvend="1"}catch(l){}}if("v"===tprck&&e.includes("rocessado com sucesso")){try{gbtninsrtvend="1"}catch(l){}try{document.getElementById("btnaddarts").disabled=!0}catch(l){}try{gbtnprcvenda="1"}catch(l){}processar("mspymtrqst","b");reqnmber3="a";imprcb()}"c"===tprck&&e.includes("rocessado com sucesso")&&(stckupd3=stckupd2=stckupd1="yes",processar("c","b"));
"dpst"===tprck&&e.includes("rocessado com sucesso")&&processar("dpst","b");"ci"===tprck&&e.includes("rocessado com sucesso")&&(stckupd3=stckupd2=stckupd1="yes",processar("ci","b"));"d"===tprck&&e.includes("rocessado com sucesso")&&processar("d","b");"prodl"===tprck&&e.includes("rocessado com sucesso")&&(addartonthefly2(lstart2),processar("prodl","b"));"fctry"===tprck&&e.includes("rocessado com sucesso")&&(addfctryonthefly(lstfctry),processar("fctry","b"));"u"===tprck&&e.includes("rocessado com sucesso")&&
processar("gu","b");"vp"===tprck&&e.includes("rocessado com sucesso")&&(addartonthefly(lstart),processar("gvp","b"));"edc"===tprck&&e.includes("rocessado com sucesso")&&window.open(lsturl+"&cfusr=g","_self");if(tprck.includes("r")&&e.includes("rocessado com sucesso")&&"pedartins"!==tprck){g=tprck;try{g=g.replace("r","")}catch(l){}try{processar(g,"b")}catch(l){}}rollToTop()}"pedartins"===tprck&&(lmp_vend_nv2(),processar("pedartins","b"));"rqif"===prvk&&processar("rqifm","b");if("unlckscrn"!==tprck)try{document.getElementById("dvprcssr").style.display=
"none"}catch(l){}}};requestval.open("POST",a,!0);requestval.send()}function imprcb(){var a=""+document.getElementById("idc").innerHTML,b=document.getElementById("clientanome").value;window.open("/SGRB/Receipt.jsp?clt="+a+"&user="+gusrlgn+"&sector="+gsector+"&name="+b,"popUpWindow","height=600,width=300,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function impinvc(){var a="/SGRB/Invoice.jsp?clt="+document.getElementById("msnmbr").innerHTML+"&user="+gusrlgn+"&sector="+gsector;window.open(a,"popUpWindow","height=600,width=300,left=10,top=10,,scrollbars=yes,menubar=no");return!1}function dpstclient(a){window.open("/SGRB/Dpstclient.jsp?t=14&clt="+a+"&user="+gusrlgn+"&sector="+gsector,"popUpWindow","height=800,width=700,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function callUpldPg(){window.open("/SGRB/UpldPg.jsp?user="+gusrlgn+"&sector="+gsector,"popUpWindow","height=800,width=700,left=10,top=10,,scrollbars=yes,menubar=no");return!1}function verpvlgs(){window.open("/SGRB/Prvlgs.jsp","popUpWindow","height=1000,width=700,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function impPDFs(a){document.getElementById("idc");var b=document.getElementById("clientanome").value,c=document.getElementById("di").value,d=document.getElementById("df").value;window.open("/SGRB/PDFs.jsp?di="+c+"&df="+d+"&sector="+gsector+"&user="+gusrlgn+"&name="+b+"&tp="+a,"popUpWindow","height=1000,width=1200,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function alterartatrib(){window.open("/SGRB/Articles.jsp?sector="+gsector+"&user="+gusrlgn,"popUpWindow","height=1000,width=1200,left=10,top=10,,scrollbars=yes,menubar=no");return!1}function lasts_req_made(){window.open("/SGRB/lasts_req_made.jsp?sector="+gsector+"&user="+gusrlgn,"popUpWindow","height=1000,width=1200,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function lasts_sales_made(){window.open("/SGRB/lasts_sales_made.jsp?sector="+gsector+"&user="+gusrlgn,"popUpWindow","height=1000,width=1200,left=10,top=10,,scrollbars=yes,menubar=no");return!1}
function setbz(a){if(getStatusOfPlaces0(document.getElementById("msst"+a).innerHTML).includes(getStatusOfPlaces(busy))){document.getElementById("msnmbr").innerHTML=document.getElementById("mstm"+a).innerHTML;lmp_vend_nv2();reqnmber=document.getElementById("msnmbr").innerHTML;processar("pedartins","b");reqnmber="a";zz=a;alert(this_table_is_still_occupied_if_you_are_the_responsible_user_you_can_only_add_articles+"!");try{gbtnpdrpag="0"}catch(h){}try{gbtnPedIns="0"}catch(h){}try{gbtninsrtpedvend="0"}catch(h){}}else if(getStatusOfPlaces0(document.getElementById("msst"+
a).innerHTML).includes(getStatusOfPlaces(pending)))alert(pending_payment_ask_to_resolve_the_payment_situation_to_free_the_place+"!");else{let h=prompt(clientname+":","");if(null!==h&&""!==h){zz=a;document.getElementById("dvrpedartins").innerHTML=hva2;try{var b=new Date,c=""+b.getSeconds(),d=""+b.getMinutes(),f=""+b.getHours(),e=""+b.getDate(),g=""+b.getFullYear();g=g.slice(-2);1===(""+g).length&&(g="0"+g);1===(""+e).length&&(e="0"+e);1===(""+f).length&&(f="0"+f);1===(""+c).length&&(c="0"+c);1===(""+
d).length&&(d="0"+d);processar(gusrlgn+"_"+a+"_"+g+e+f+d+c+"."+h,"stplc")}catch(k){}try{gbtnPedIns="0"}catch(k){}try{gbtninsrtpedvend="0"}catch(k){}}gbtnpdrpag="0"}}function setbzz(a,b){document.getElementById("msnmbr").innerHTML=b;document.getElementById("msst"+a).innerHTML=busy;document.getElementById("usrms"+a).innerHTML=gusrlgn;document.getElementById("msnmb"+a).style.backgroundColor="#DC7633";document.getElementById("mstm"+a).innerHTML=b;lmp_vend_nv2()}
function checkstatestutus(){var a="/SGRB/r?t=2&acao=b&user="+gusrlgn+"&sector="+gsector+"&prv=msst";window.ActiveXObject?requestc=new ActiveXObject("Microsoft.XMLHTTP"):window.XMLHttpRequest&&(requestc=new XMLHttpRequest);requestc.onreadystatechange=rstc;requestc.open("POST",a,!0);requestc.send()}
$(document).ready(function(){$("#btndesloc").click(function(){$.ajax({url:"r",type:"POST",dataType:"text",data:{dg:$("#txtdesig").val(),lc:$("#txtlocz").val(),lnk_download:$("#txtblnk").val(),lg:lgtostr,clg:$("#chcklogt").is(":checked")?"1":"0",cdg:$("#chckdesig").is(":checked")?"1":"0",clc:$("#chcklocz").is(":checked")?"1":"0",t:"2",acao:"orgdt",user:gusrlgn,sector:gsector},success:function(a){document.getElementById("dvrst").style.display="block";document.getElementById("dvrst").innerHTML=a;desaborginf();
window.open(lsturl+"&cfusr=g","_self")}})});$("#btnhelpdesk").click(function(){$.ajax({url:"r",type:"POST",dataType:"text",data:{t:"2",acao:"cmmnts",hlpid:$("#hlpid").val(),hlpnm:$("#hlpnm").val(),hlptxt:$("#hlptxt").val(),user:gusrlgn,sector:"SGRB"},success:function(a){alert(a)},error:function(a){alert(a.message)}})})});
function filart(a,b){var c;b=b.toUpperCase();var d=document.getElementById(a).getElementsByTagName("tr");if("tbdvrgvp"===a){var f=8;var e=6}else f=6,e=2;for(c=1;c<d.length;c++){var g=d[c].getElementsByTagName("td")[e];if("tbdvrgvp"===a){var h=d[c].getElementsByTagName("td")[e];var k=d[c].getElementsByTagName("td")[e]}else h=d[c].getElementsByTagName("td")[3],k=d[c].getElementsByTagName("td")[5];var m=d[c].getElementsByTagName("td")[f];if(g||h||k){g=g.textContent||g.innerText;h=h.textContent||h.innerText;
k=k.textContent||k.innerText;m=m.textContent||m.innerText;if(null===g||""===g)g="_";if(null===h||""===h)h="_";if(null===k||""===k)k="_";if(null===m||""===m)m="_";if(-1<g.toUpperCase().indexOf(b)||-1<h.toUpperCase().indexOf(b)||-1<k.toUpperCase().indexOf(b)||-1<m.toUpperCase().indexOf(b)){d[c].style.visibility="";try{d[1].parentNode.insertBefore(d[c],d[1])}catch(r){}}else d[c].style.visibility="hidden"}}}
function filart1vl(a,b){var c,d;b=b.toUpperCase();a=document.getElementById(a).getElementsByTagName("tr");for(d=1;d<a.length;d++)if(c=a[d].getElementsByTagName("td")[1]){c=c.textContent||c.innerText;if(null===c||""===c)c="_";if(-1<c.toUpperCase().indexOf(b)){a[d].style.visibility="";try{a[1].parentNode.insertBefore(a[d],a[1])}catch(f){}}else a[d].style.visibility="hidden"}}
function disabclntnrinf(){if(1===document.getElementById("msnmbr").innerHTML.trim().length){try{gbtninsrtpedvend="1"}catch(a){}try{gbtnPedIns="1"}catch(a){}try{gbtnpdrpag="1"}catch(a){}}}function processdescount(a){a=Number(a);var b=Number(document.getElementById("vend_quant").value);a=-.01*Number(a)*lastartprc*b;document.getElementById("vend_prc").value=""+FixDecToTwo(a);document.getElementById("spvendtp").innerHTML="Fazendo desconto!";document.getElementById("spvendtp").style.color="green"}
function fVInR(a){table=document.getElementById("tbdvrv");for(var b=table.rows,c=1;c<b.length;c++)for(var d=b[c].cells,f=0;f<d.length;f++)if(d[f].innerText===a)return!0;return!1}function ValQuantDscnt(a){var b=0;table=document.getElementById("tbdvrv");for(var c=table.rows,d=1;d<c.length;d++){var f=c[d].cells;if(f[6].innerText===a){var e=0;try{e=Number(f[7].innerText)}catch(g){e=0}b+=e}}return b}
function getdpstvls(){var a=document.getElementById("dpst_clientname").value,b=document.getElementById("dpst_residenty").value,c=document.getElementById("dpst_id_number").value,d=document.getElementById("dpst_phone").value,f=document.getElementById("dpst_observation").value;return"&c="+a+"&r="+b+"&i="+c+"&p="+d+"&o="+f}function addartonthefly(a){var b=document.getElementById("lst_prod");try{var c=document.createElement("option");c.value=a;b.appendChild(c)}catch(d){}}
function addartonthefly2(a){var b=document.getElementById("lst_prod2");try{var c=document.createElement("option");c.value=a;b.appendChild(c)}catch(d){}}function addfctryonthefly(a){var b=document.getElementById("lst_grp");try{var c=document.createElement("option");c.value=a;b.appendChild(c)}catch(d){}}
function stvalc(a){if("v"===a){slsalc="v";try{document.getElementById("strngvnd").innerHTML=""+sales}catch(b){}}else if("a"===a){slsalc="c";try{document.getElementById("strngvnd").innerHTML=""+allocations}catch(b){}}}
function tdstck(a,b,c,d){d||(d=window.event);d.cancelBubble=!0;d.stopPropagation&&d.stopPropagation();try{d="0","Sim"===b&&(d="1"),document.getElementById("stkcusd"+a).innerHTML="<select onchange=\"processar('"+c+"', 'stkalc')\"><option value=\""+d+'">'+b+'</option><option value="1">Sim</option></select>'}catch(f){alert(f.message)}try{document.getElementById("stkcusd"+a).removeAttribute("onclick")}catch(f){}}function desabledelement(){alert(resource_unavailable+"!")}
function rnfb(a){"b"===a?nrfb="b":"f"===a&&(nrfb="f")}function nmbrofrecds(a){var b="0",c="";try{c=document.getElementById("rwsintbls").value;var d=document.getElementById("tbdvr"+a);b=""+d.rows[d.rows.length-1].cells[0].innerHTML;1>d.rows.length-1&&(b="0")}catch(f){}a=nrfb;nrfb="z";d=document.getElementById("yesnodlt").value;return"&nlstid="+b+"&nrws="+c+"&nfb="+a+"&yesnodlt="+d}
function calculatechg(){var a=document.getElementById("pago").value;var b=0;try{b=parseFloat(a)}catch(c){b=0}a=b-smvlsglb;a=a.toFixed(2);0<a?document.getElementById("troco").style.backgroundColor="green":document.getElementById("troco").style.backgroundColor="red";document.getElementById("troco").innerHTML=""+a}function rplcSpcialChar(a){var b;try{for(var c=a.length,d=0;d<c;d++){var f=a.charAt(d);b+=""+bsccaresp(f)}}catch(e){}return b}
function bsccaresp(a){var b="";if(null===a||"&"!==a&&!b.includes("&")){if(null===a||":"!==a&&!b.includes("&"))return a;try{b=c=a.replace(":","_")}catch(d){}return b}try{var c=a.replace("&","_");b=c}catch(d){}return b}function setArticle(a,b){if("lstprdvendas"===a)try{document.getElementById("vend_art").value=b,getCodBarCode(b,"v")}catch(c){}else if("lstprdpedvendas"===a)try{document.getElementById("pedvend_art").value=b,getCodBarCode(b,"pedv")}catch(c){}}
function checklstofms(){clickedlstreqvend="yes"}function checklstofmsno(){clickedlstreqvend="no"}function FixDecToTwo(a){a=""+a;if(null===a||""===a)return a;if(a.includes(".")){var b=a.split(".");a=b[0];b=b[1];var c="",d="";try{c=b.charAt(0)}catch(f){c="0"}try{d=b.charAt(1)}catch(f){d="0"}return a+"."+c+d}return a+".00"}
function filbyclnsnr(a,b,c,d,f,e){var g,h=0,k=0,m=0,r=0;b=b.toUpperCase();a=document.getElementById(a).getElementsByTagName("tr");for(g=1;g<a.length;g++){var n=a[g].getElementsByTagName("td")[c];var q=a[g].getElementsByTagName("td")[d];var l=a[g].getElementsByTagName("td")[f];if(n||q||l){n=n.textContent||n.innerText;q=q.textContent||q.innerText;l=l.textContent||l.innerText;if(null===n||""===n)n="_";if(null===q||""===q)q="_";if(null===l||""===l)l="_";if(-1<n.toUpperCase().indexOf(b)||-1<q.toUpperCase().indexOf(b)||
-1<l.toUpperCase().indexOf(b)){a[g].style.visibility="";try{a[1].parentNode.insertBefore(a[g],a[1])}catch(t){}try{r+=1,"va"===e?(h+=parseFloat(a[1].getElementsByTagName("td")[10].innerHTML),k+=parseFloat(a[1].getElementsByTagName("td")[11].innerHTML)):"c"===e?(h+=parseFloat(a[1].getElementsByTagName("td")[8].innerHTML),k+=parseFloat(a[1].getElementsByTagName("td")[12].innerHTML)):"d"===e?h+=parseFloat(a[1].getElementsByTagName("td")[2].innerHTML):"dpst"===e&&(h+=parseFloat(a[1].getElementsByTagName("td")[7].innerHTML),
k+=parseFloat(a[1].getElementsByTagName("td")[8].innerHTML),m+=parseFloat(a[1].getElementsByTagName("td")[9].innerHTML))}catch(t){}}else a[g].style.visibility="hidden"}}"va"===e?document.getElementById("tbdvrvasum").innerHTML=""+total+": "+FixDecToTwo(h)+" Mts, "+lucroest+": "+FixDecToTwo(k)+" Mts, Registos: "+r:"c"===e?document.getElementById("tbdvrcsum").innerHTML=""+total+": "+FixDecToTwo(h)+" Mts, "+lucroest+": "+FixDecToTwo(k)+" Mts, Registos: "+r:"d"===e?document.getElementById("tbdvrdsum").innerHTML=
""+total+": "+FixDecToTwo(h)+" Mts, Registos: "+r:"dpst"===e&&(document.getElementById("tbdvrdptsum").innerHTML="Total "+deposits+": "+FixDecToTwo(h)+" Mts, "+totalused+": "+FixDecToTwo(k)+" Mts, <strong>Total Saldo: "+FixDecToTwo(m)+" Mts</strong>, Registos: "+r)}
function aborginf(){try{document.getElementById("chcklogt").disabled=!1}catch(a){}try{document.getElementById("txtdesig").disabled=!1}catch(a){}try{document.getElementById("chckdesig").disabled=!1}catch(a){}try{document.getElementById("txtlocz").disabled=!1}catch(a){}try{document.getElementById("chcklocz").disabled=!1}catch(a){}try{document.getElementById("btndesloc").disabled=!1}catch(a){}try{document.getElementById("fllogt").disabled=!1}catch(a){}try{document.getElementById("txtblnk").disabled=
!1}catch(a){}}function enablesysidpwd(){try{document.getElementById("txtsysid").disabled=!1}catch(a){}try{document.getElementById("txtsyspwd").disabled=!1}catch(a){}}
function desaborginf(){try{document.getElementById("chcklogt").disabled=!0}catch(a){}try{document.getElementById("txtdesig").disabled=!0}catch(a){}try{document.getElementById("chckdesig").disabled=!0}catch(a){}try{document.getElementById("txtlocz").disabled=!0}catch(a){}try{document.getElementById("chcklocz").disabled=!0}catch(a){}try{document.getElementById("btndesloc").disabled=!0}catch(a){}try{document.getElementById("fllogt").disabled=!0}catch(a){}try{document.getElementById("txtblnk").disabled=
!0}catch(a){}}function getsysidpwd(){var a=document.getElementById("txtsysid").value,b=document.getElementById("txtsyspwd").value;return"&idsys="+a+"&pwdsys="+b}function chklgc(a){var b="0";try{b=!0===a.checked?"1":"0"}catch(c){}return b}function startlookstate(){IntervalSrvrChk=setInterval(checkstatestutus2(),1E3)}function stoplookstate(){try{clearInterval(IntervalSrvrChk)}catch(a){}}function checkstatestutus2(){setTimeout(function(){checkstatestutus()},500)}
function getCodBarCode(a,b){p=b;document.getElementById("spvendtp").innerHTML=""+normal_sale+"!";document.getElementById("spvendtp").style.color="blue";processar(a,"cdbar")}
function fillProdCodBar(a){var b=a.split(",");a=b[0];var c=b[1],d=b[2],f=b[3],e=b[4],g=b[5],h=b[6],k=b[7];b=b[8];document.getElementById("spdescount");lastartprc=parseFloat(h);"v"===p?(document.getElementById("vend_pcod").value=a,document.getElementById("vend_cbar").value=c,document.getElementById("vend_grp").value=d,document.getElementById("vend_tp").value=f,document.getElementById("vend_cat").value=e,document.getElementById("vend_art").value=g,document.getElementById("vend_prc").value=h,document.getElementById("vend_quant").value=
"1",lstpurcqty=b,fVInR(g)?document.getElementById("spdescount").innerHTML=k:"c"===slsalc&&(document.getElementById("spvendtp").innerHTML=""+allocations+"!",document.getElementById("spdescount").innerHTML="Stock:<input type='number' id='txtstck' min='1' max='10' style='width: 80px;'/>")):"pedv"===p?(document.getElementById("pedvend_pcod").value=a,document.getElementById("pedvend_cbar").value=c,document.getElementById("pedvend_grp").value=d,document.getElementById("pedvend_tp").value=f,document.getElementById("pedvend_cat").value=
e,document.getElementById("pedvend_art").value=g,document.getElementById("pedvend_prc").value=h,document.getElementById("pedvend_quant").value="1",lstpurcqty=b):"c"===p?(document.getElementById("comp_pcod").value=a,document.getElementById("comp_cbar").value=c,document.getElementById("comp_grp").value=d,document.getElementById("comp_tp").value=f,document.getElementById("comp_cat").value=e,document.getElementById("comp_art").value=g):"ci"===p&&(document.getElementById("comp_pcodinv").value=a,document.getElementById("comp_cbarinv").value=
c,document.getElementById("comp_grpinv").value=d,document.getElementById("comp_tpinv").value=f,document.getElementById("comp_catinv").value=e,document.getElementById("comp_artinv").value=g,lstpurcqty=b);p="a"}function deleterped(){var a=document.getElementById("dvrpedartins2").rows;try{for(var b=0;3>b;b++)for(var c=0;c<a.length;c++)try{a[c].deleteCell(b)}catch(d){}}catch(d){}}
function checkcpb(a){"crdo_art"===a?(document.getElementById("crdo_prod").checked=!1,document.getElementById("crdo_bar").checked=!1,document.getElementById("comp_art").disabled=!1,document.getElementById("comp_pcod").disabled=!0,document.getElementById("comp_cbar").disabled=!0,document.getElementById("comp_art").value="",document.getElementById("comp_pcod").value="",document.getElementById("comp_cbar").value=""):"crdo_prod"===a?(document.getElementById("crdo_art").checked=!1,document.getElementById("crdo_bar").checked=
!1,document.getElementById("comp_art").disabled=!0,document.getElementById("comp_pcod").disabled=!1,document.getElementById("comp_cbar").disabled=!0,document.getElementById("comp_art").value="",document.getElementById("comp_pcod").value="",document.getElementById("comp_cbar").value=""):"crdo_bar"===a&&(document.getElementById("crdo_art").checked=!1,document.getElementById("crdo_prod").checked=!1,document.getElementById("comp_art").disabled=!0,document.getElementById("comp_pcod").disabled=!0,document.getElementById("comp_cbar").disabled=
!1,document.getElementById("comp_art").value="",document.getElementById("comp_pcod").value="",document.getElementById("comp_cbar").value="");"vrdo_art"===a?(document.getElementById("vrdo_prod").checked=!1,document.getElementById("vrdo_bar").checked=!1,document.getElementById("vend_art").disabled=!1,document.getElementById("vend_pcod").disabled=!0,document.getElementById("vend_cbar").disabled=!0,document.getElementById("vend_art").value="",document.getElementById("vend_pcod").value="",document.getElementById("vend_cbar").value=
""):"vrdo_prod"===a?(document.getElementById("vrdo_art").checked=!1,document.getElementById("vrdo_bar").checked=!1,document.getElementById("vend_art").disabled=!0,document.getElementById("vend_pcod").disabled=!1,document.getElementById("vend_cbar").disabled=!0,document.getElementById("vend_art").value="",document.getElementById("vend_pcod").value="",document.getElementById("vend_cbar").value=""):"vrdo_bar"===a&&(document.getElementById("vrdo_art").checked=!1,document.getElementById("vrdo_prod").checked=
!1,document.getElementById("vend_art").disabled=!0,document.getElementById("vend_pcod").disabled=!0,document.getElementById("vend_cbar").disabled=!1,document.getElementById("vend_art").value="",document.getElementById("vend_pcod").value="",document.getElementById("vend_cbar").value="");"pedvrdo_art"===a?(document.getElementById("pedvrdo_prod").checked=!1,document.getElementById("pedvrdo_bar").checked=!1,document.getElementById("pedvend_art").disabled=!1,document.getElementById("pedvend_pcod").disabled=
!0,document.getElementById("pedvend_cbar").disabled=!0,document.getElementById("pedvend_art").value="",document.getElementById("pedvend_pcod").value="",document.getElementById("pedvend_cbar").value=""):"pedvrdo_prod"===a?(document.getElementById("pedvrdo_art").checked=!1,document.getElementById("pedvrdo_bar").checked=!1,document.getElementById("pedvend_art").disabled=!0,document.getElementById("pedvend_pcod").disabled=!1,document.getElementById("pedvend_cbar").disabled=!0,document.getElementById("pedvend_art").value=
"",document.getElementById("pedvend_pcod").value="",document.getElementById("pedvend_cbar").value=""):"pedvrdo_bar"===a&&(document.getElementById("pedvrdo_art").checked=!1,document.getElementById("pedvrdo_prod").checked=!1,document.getElementById("pedvend_art").disabled=!0,document.getElementById("pedvend_pcod").disabled=!0,document.getElementById("pedvend_cbar").disabled=!1,document.getElementById("pedvend_art").value="",document.getElementById("pedvend_pcod").value="",document.getElementById("pedvend_cbar").value=
"")}
function pedvendary(){if("1"===gbtninsrtpedvend)return desabledelement(),!1;var a=document.getElementById("pedvend_tp").value,b=document.getElementById("pedvend_cat").value,c=document.getElementById("pedvend_quant").value,d=document.getElementById("pedvend_art").value,f=document.getElementById("pedvend_prc").value,e=document.getElementById("pedvend_grp").value,g=document.getElementById("pedvend_pcod").value,h=document.getElementById("pedvend_cbar").value,k=document.getElementById("msnmbr").innerHTML;"NA"!==
a&&"NA"!==b&&"0"!==c&&"NA"!==d&&"0.0"!==f&&""!==g&&""!==h&&processar("msn="+k+"&vg="+e+"&vt="+a+"&vc="+b+"&va="+d+"&vq="+c+"&vp="+f+"&vcod="+g+"&vcbar="+h+"&lstpurcqty="+lstpurcqty,"pedartins")}function setfr(a,b){document.getElementById("msst"+a).innerHTML=pending;document.getElementById("msnmb"+a).style.backgroundColor="#F5B041"}
function rqifmart(a){a=a.split(":");try{for(var b=0;b<a.length;b++)if(null!==a[b].split(";")[1]&&"undefined"!==a[b].split(";")[1]&&"undefined"!==typeof a[b].split(";")[1]&&""!==a[b].split(";")[1]){var c=a[b].split(";")[1],d=a[b].split(";")[2],f=a[b].split(";")[3],e=a[b].split(";")[4],g=a[b].split(";")[5],h=a[b].split(";")[6],k=a[b].split(";")[7],m=a[b].split(";")[8],r=a[b].split(";")[9],n=a[b].split(";")[10],q=r+";"+n,l=""+document.getElementById("idc").innerHTML,t=document.getElementById("clientanome").value;
vndits[b]=",vcod="+c+",vcbar="+d+",vg="+f+",vt="+e+",vc="+g+",va="+h+",vq="+k+",vp="+m+",clt="+l+",nm="+t+",pcsartcnt="+q+",txtstck=0,slsalc="+slsalc+":"}}catch(u){}rfrsh_vnd();document.getElementById("dvrst").innerHTML="<span style='color: green;'>"+added_sale+"!</span>";sumvaluesforeachtbl("v")}
function prcnmbrrq(a){reqnmber=""+a;reqnmber2=""+a;reqnmber3="b";try{document.getElementById("txtdescnt").value=""}catch(b){}try{document.getElementById("spvendtp").innerHTML=""+normal_sale+"!",document.getElementById("spvendtp").style.color="blue"}catch(b){}}function rmrrg(a,b,c){rr=c;processar(b,"r"+a)}function lvlrmv(){return"&r="+rr}
function alwupdt(a){document.getElementById("guid"+a+"4").innerHTML='<select id="ipt'+a+'4" style="width: 90px;"><option value="'+document.getElementById("guid"+a+"4").innerHTML+'">'+document.getElementById("guid"+a+"4").innerHTML+'</option><option value="Gestor">Gestor</option><option value="Caixa">Caixa</option><option value="Visualizador">Visualizador</option></select>';document.getElementById("guid"+a+"5").innerHTML='<input type="text" id="ipt'+a+'5" value="'+document.getElementById("guid"+a+
"5").innerHTML+'" style="width: 180px;">';document.getElementById("guid"+a+"6").innerHTML='<input type="text" id="ipt'+a+'6" value="'+document.getElementById("guid"+a+"6").innerHTML+'" style="width: 40px;">';try{document.getElementById("btnusredit"+a).disabled=!0}catch(b){}}function csedit(a){return"&id="+a+"&c="+document.getElementById("ipt"+a+"4").value+"&p="+document.getElementById("ipt"+a+"5").value+"&e="+document.getElementById("ipt"+a+"6").value}
function dhschrts(a,b,c,d,f){new Chart(document.getElementById("brchrt"),{type:"bar",data:{labels:["Despesas","Compras","Vendas"],datasets:[{label:"Mts",backgroundColor:["#8e5ea2","#3cba9f","#e8c3b9"],data:a}]},options:{legend:{display:!1},title:{display:!0,text:"Valores por Categoria"}}});new Chart(document.getElementById("lnchrt"),{type:"line",data:{labels:f,datasets:[{data:b,label:"Despesas",borderColor:"#3e95cd",fill:!1},{data:c,label:"Compras",borderColor:"#8e5ea2",fill:!1},{data:d,label:"Vendas",
borderColor:"#3cba9f",fill:!1}]},options:{title:{display:!0,text:"Valores por Categoria e Tempo"}}})}function chmrcmplstprdpz(a){var b=document.getElementById("cmplstprd");b.style.display="block";var c=event.clientX,d=event.clientY-320;0>d&&(d=0);b.style.left=c+"px";b.style.top=d+"px";b.style.zIndex="20";document.getElementById("lstprdart").innerHTML=a;processar("aqp","b")}function clsplst(){document.getElementById("cmplstprd").style.display="none"}
function lmp_vend_nv(){try{document.getElementById("vend_tp").value="NA",document.getElementById("vend_cat").value="NA",document.getElementById("vend_quant").value="",document.getElementById("vend_art").value="NA",document.getElementById("vend_pcod").value="",document.getElementById("vend_cbar").value="",document.getElementById("vend_prc").value="0.00"}catch(a){}}
function lmp_vend_nv2(){try{document.getElementById("pedvend_tp").value="NA",document.getElementById("pedvend_cat").value="NA",document.getElementById("pedvend_quant").value="",document.getElementById("pedvend_art").value="NA",document.getElementById("pedvend_prc").value="0.00"}catch(a){alert(a.message)}}function retinfpurc(){"0"===glbpurc&&(addEvntforCodeInptC(),processar("c","b"))}function retinfexp(){"0"===glbexp&&processar("d","b")}function retinfdshb(){"0"===glbdshb&&processar("dhs","b")}
function retinggu(){"0"===glbgu&&processar("gu","b")}function retinfva(){"0"===glbva&&processar("va","b")}function retinfest(){"0"!==glbest&&"yes"!==stckupd3||processar("est","b")}function retdpst(){"0"===glbdpst&&processar("dpst","b")}function retinv(){"0"===glbv&&(addEvntforCodeInptV(),glbv="1")}function retinpedv(){"0"===glbpedv&&(addEvntforCodeInptPedV(),glbpedv="1")}
function sumvaluesforeachtbl(a){try{if("d"===a){for(var b=0,c=document.getElementById("tbdvrd"),d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[2].innerHTML);b=b.toFixed(2);document.getElementById("tbdvrdsum").innerHTML=""+total+": "+b+" Mts"}else if("c"===a){b=0;c=document.getElementById("tbdvrc");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[8].innerHTML);b=b.toFixed(2);var f=0,e=0;for(d=1;d<c.rows.length;d++)e=d,f+=parseFloat(c.rows[d].cells[12].innerHTML);f=f.toFixed(2);document.getElementById("tbdvrcsum").innerHTML=
""+total+": "+b+" Mts, "+lucroest+": "+f+" Mts, Registos: "+e}else if("va"===a){f=b=0;c=document.getElementById("tbdvrva");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[10].innerHTML),f+=parseFloat(c.rows[d].cells[11].innerHTML);b=b.toFixed(2);f=f.toFixed(2);document.getElementById("tbdvrvasum").innerHTML=""+total+": "+b+" Mts, "+lucroest+": "+f+" Mts"}else if("v"===a){b=0;c=document.getElementById("tbdvrv");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[8].innerHTML);smvlsglb=
b=b.toFixed(2);document.getElementById("tbdvrvsum").innerHTML=""+total+": "+b+" Mts, "+paid+": <input type='number' id='pago' min='0' style='width: 90px;' onkeyup='calculatechg()' onchange='calculatechg()'>, Troco:<span id='troco' style='color: white;'></span> Mts"}else if("pedartins"===a){b=0;c=document.getElementById("dvrpedartins2");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[8].innerHTML);b=b.toFixed(2);document.getElementById("pedtbdvrvsum").innerHTML=""+total+": "+b+" Mts";deleterped()}else if("dpst"===
a){a=f=b=0;c=document.getElementById("tbdvdpst");e=0;for(d=1;d<c.rows.length;d++)e+=1,b+=parseFloat(c.rows[d].cells[7].innerHTML),f+=parseFloat(c.rows[d].cells[8].innerHTML),a+=parseFloat(c.rows[d].cells[9].innerHTML);b=b.toFixed(2);document.getElementById("tbdvrdptsum").innerHTML="Total "+deposits+": "+FixDecToTwo(b)+" Mts, "+totalused+": "+FixDecToTwo(f)+" Mts, <strong>Total Saldo: "+FixDecToTwo(a)+" Mts</strong>, "+regists+": "+e;deleterped()}}catch(g){}}
function sumvaluesforeachtbl2(a){try{if("d"===a){for(var b=0,c=document.getElementById("tbdvrd"),d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[2].innerHTML);b=b.toFixed(2);document.getElementById("tbdvrdsum").innerHTML=""+total+": "+b+" Mts"}else if("c"===a){b=0;c=document.getElementById("tbdvrc");c.getElementsByTagName("tr");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[8].innerHTML);b=b.toFixed(2);var f=0;a=0;for(d=1;d<c.rows.length;d++)a=d,f+=parseFloat(c.rows[d].cells[12].innerHTML);
f=f.toFixed(2);document.getElementById("tbdvrcsum").innerHTML=""+total+": "+b+" Mts, "+lucroest+": "+f+" Mts, "+regists+": "+a}else if("va"===a){f=b=0;c=document.getElementById("tbdvrva");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[10].innerHTML),f+=parseFloat(c.rows[d].cells[11].innerHTML);b=b.toFixed(2);f=f.toFixed(2);document.getElementById("tbdvrvasum").innerHTML=""+total+": "+b+" Mts, "+lucroest+": "+f+" Mts"}else if("v"===a){b=0;c=document.getElementById("tbdvrv");for(d=1;d<c.rows.length;d++)b+=
parseFloat(c.rows[d].cells[8].innerHTML);smvlsglb=b=b.toFixed(2);document.getElementById("tbdvrvsum").innerHTML=""+total+": "+b+" Mts, "+paid+": <input type='number' id='pago' min='0' style='width: 90px;' onkeyup='calculatechg()' onchange='calculatechg()'>, Troco:<span id='troco' style='color: white;'></span> Mts"}else if("pedartins"===a){b=0;c=document.getElementById("dvrpedartins2");for(d=1;d<c.rows.length;d++)b+=parseFloat(c.rows[d].cells[8].innerHTML);b=b.toFixed(2);document.getElementById("pedtbdvrvsum").innerHTML=
""+total+": "+b+" Mts";deleterped()}}catch(e){}}function lgc(a){if("v"===a){a=document.getElementById("vend_tp").value;var b=document.getElementById("vend_cat").value;"Comida"===a&&"Alcool"===b&&alert(chose_food_and_alcohol_rectify+"!")}}function vartp(){return"&pt="+document.getElementById("vend_cat").value+"&z=a&q=0"}function vartp2(){return"&pt="+document.getElementById("pedvend_cat").value+"&z=a&q=0"}
function vprc(){var a=document.getElementById("vend_art").value;var b=document.getElementById("vend_quant").value;return"&pt="+a+"&z=b&q="+b}function vprc2(){var a=document.getElementById("pedvend_art").value;var b=document.getElementById("pedvend_quant").value;return"&pt="+a+"&z=b&q="+b}function vant(){return""}function limpar(){document.getElementById("di").value="";document.getElementById("df").value=""}
function rfrsh_vnd(){tblvd="<table border='1' id='tbdvrv'><tr style='height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);'><th>"+tblorder+"</th><th>"+tblcategory+"</th><th>Prod C&oacute;digo</th><th>C&oacute;digo de Barra</th><th>Tipo</th><th>"+tblgroup+"</th><th>"+tblarticle+"</th><th>"+tblquant+"</th><th>"+tblprice+"</th><th>"+tblrmvl+"</th></tr>";vndits.forEach(rfshtbl);tblvd+="</table>";document.getElementById("tblvn").innerHTML=tblvd}
function rfshtbl(a,b,c){if("NA"!==a){c=b;b+=1;a=a.replace(":","");b="<td>"+b+"</td>";a=a.split(",");for(var d=1;d<a.length;d++){var f=a.length;f-=5;if(d===f)break;f=a[d].split("=")[1];b+="<td>"+f+"</td>"}b+="<td>"+crtbtn("rmvitvend("+c+")")+"</td>";tblvd+="<tr>"+b+"</tr>"}}
function crtbtn(a){return'                                <div style="padding-left: 10px; display: inline-block; width: 40px; height: 40px; border-radius: 50%;">\n                                    <a href="#" onclick="'+a+'" style="text-decoration: none; float: none; display: inline;">\n                                        <img src="/SGRB/img/rmvp.png" style="width: 32px; height: 32px;" title="'+trmv+'">\n                                    </a>\n                                </div>'}
function crtbtnopn(a){return'                                <div style="padding-left: 10px; background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;">\n                                    <a href="#" onclick="'+a+'" style="text-decoration: none; float: none; display: inline;">\n                                        <img src="/SGRB/img/openp.png" style="width: 32px; height: 32px;" title="'+topen+'">\n                                    </a>\n                                </div>'}
function crtbtnedt(a){return'                                <div style="padding-left: 10px; background-color: white; display: inline-block; width: 40px; height: 40px; border-radius: 50%;">\n                                    <a href="#" onclick="'+a+'" style="text-decoration: none; float: none; display: inline;">\n                                        <img src="/SGRB/img/editp.png" style="width: 32px; height: 32px;" title="'+tedit+'">\n                                    </a>\n                                </div>'}
function filltbl(a,b){var c=b;"gu"===b?b=hus:"gvp"===b?b=hvp:"d"===b?b=hds:"c"===b?b=hcm:"ci"===b?b=hcmi:"va"===b?b=hva:"aqp"===b?b=artqp:"prodl"===b?b=plst:"est"===b?b=estp:"pedartins"===b?b=hva2:"fctry"===b?b=fcty:"dpst"===b&&(b=hdpst);var d="";try{d=b.replace("</table>","")}catch(m){}b="";a=a.split(":");for(var f=0;f<a.length;f++){var e=a[f].split(";");if(null!==e[1]&&""!==e[1]&&"undefined"!==e[1]&&"undefined"!==typeof e[1]){e=a[f].split(";");b="1"===e[e.length-3]&&"1"!==e[e.length-2]?"est"===
c?b+"<tr>":b+"<tr style='background-color: #F9E79F;'>":"1"===e[e.length-2]?"gu"===c?"1"===e[e.length-2]?b+"<tr>":"est"===c?b+"<tr>":b+"<tr style='background-color: #F1948A;'>":"est"===c?b+"<tr>":b+"<tr style='background-color: #F1948A;'>":b+"<tr>";for(var g=0;g<e.length;g++){var h=e[g];g===e.length-1&&("gu"===c?(h='<button type="button" id="btnusredit'+e[0]+'" class="btn btn-primary" onclick="alwupdt(\''+e[0]+'\')" style="background-color: #58D68D;">'+topen+'</button><button type="button" class="btn btn-primary" onclick="processar(\''+
e[0]+"','edc')\" style=\"background-color: #5DADE2;\">"+tedit+"</button>",h=""+crtbtnopn("alwupdt('"+e[0]+"')")+crtbtnedt("processar('"+e[0]+"','edc')")):"dpst"!==c&&(h=""+crtbtn("rmrrg('"+c+"','"+e[0]+"','"+e[e.length-3]+"')")));b=g===e.length-2||g===e.length-3||g===e.length-4?b+("<td id='guid"+e[0]+g+"'>"+h+"</td>"):"gvp"===c&&6===g?b+("<td><a href='#' onclick=\"chmrcmplstprdpz('"+e[6]+"')\">"+h+"</a></td>"):"dpst"===c&&1===g?b+("<td><a href='#' onclick=\"dpstclient('"+e[0]+"')\">"+e[1]+"</a></td>"):
"est"===c?b+("<td>"+e[g]+"</td>"):b+("<td>"+h+"</td>")}b+="</tr>"}}try{var k=d.replace("<tbody>","");d=k}catch(m){}try{d=k=d.replace("</tbody>","")}catch(m){}try{d=k=d.replace("</table>","")}catch(m){}d=d+b+"</table>";document.getElementById("dvr"+c).innerHTML="";document.getElementById("dvr"+c).innerHTML=d;"c"===c&&"0"===glbpurc2&&(glbpurc2="1",setTimeout(function(){processar("ci","b")},500));"gu"===c&&"0"===glbgvp&&(glbgvp="1",setTimeout(function(){processar("gvp","b")},500));"gvp"===c&&"0"===glbprodl&&
(glbprodl="1",setTimeout(function(){processar("prodl","b")},500));"prodl"===c&&"0"===glbfctry&&(glbfctry="1",setTimeout(function(){processar("fctry","b")},500));setTimeout(function(){sumvaluesforeachtbl(c)},500)}function prv(a){var b="";try{b=document.getElementById("lstprdart").innerHTML}catch(d){b="a"}var c="";try{c=document.getElementById("msnmbr").innerHTML}catch(d){c="a"}a="&prv="+a+"&id="+b+"&id2="+c+"&id3="+reqnmber;reqnmber="a";return a}
function reg_venda(){vndits.forEach(lstrvn);var a="&rgvn="+nvlst;nvlst="";var b=document.getElementById("ass_client").value;a=a+"&id4="+reqnmber2+"&assclnt="+b;reqnmber2="a";return a}function lstrvn(a,b,c){nvlst+=""+a}function artprodlst(){var a=document.getElementById("produtolstart").value,b=document.getElementById("quantidadelstart").value,c="";try{c=document.getElementById("lstprdart").innerHTML}catch(d){c="a"}return"&art="+c+"&prod="+a+"&quant="+b}
function prodlst(){var a=bsccaresp(document.getElementById("prodnvl").value);lstart2=a;return"&prod="+a}function rmvitvend(a){vndits[a]="NA";rfrsh_vnd();document.getElementById("dvrst").innerHTML="<span style='color: green;'>"+sale_removed+"!</span>"}
function nvc(a){if("tblvn"===a){var b=document.getElementById("clientanome").value,c=document.getElementById("idc").innerHTML;if(null===c||""===c||"undefined"===typeof c||2>c.trim().length)alert(create_new_customer+"!");else if(null===b||""===b||"undefined"===typeof b||2>b.trim().length)alert(fill_in_customer_name+"!");else try{document.getElementById(a).style.display="block","pedidonv"===a&&retinpedv()}catch(d){}}else try{document.getElementById(a).style.display="block","pedidonv"===a&&retinpedv()}catch(d){}if("vendcnv"===
a){try{document.getElementById("btnaddarts").disabled=!0}catch(d){}document.getElementById("spvendtp").innerHTML=""+normal_sale+"!";document.getElementById("spvendtp").style.color="blue";"c"===slsalc?(document.getElementById("spvendtp").innerHTML=""+allocations+"!",document.getElementById("spdescount").innerHTML="Stock:<input type='number' id='txtstck' min='1' max='10' style='width: 80px;'/>"):document.getElementById("spdescount").innerHTML=""}if("comnv"===a)try{document.getElementById("btnnvc").disabled=
!0}catch(d){}else if("comnvinv"===a)try{document.getElementById("btnnvci").disabled=!0}catch(d){}else if("desnv"===a)try{document.getElementById("btnnvd").disabled=!0}catch(d){}else if("usnv"===a)try{document.getElementById("btnnvusr").disabled=!0}catch(d){}else if("prdnv"===a)try{document.getElementById("btnnvprd").disabled=!0}catch(d){}else if("fctrynv"===a)try{document.getElementById("btnnvfctry").disabled=!0}catch(d){}else if("vendnv"===a)try{document.getElementById("btnnvvp").disabled=!0}catch(d){}else if("dtnv"===
a)try{document.getElementById("btnnvdt").disabled=!0}catch(d){}}
function vendprec_nv(){var a=document.getElementById("vendprec_tp").value,b=document.getElementById("vendprec_cat").value,c=document.getElementById("vendprec_quant").value,d=document.getElementById("vendprec_art").value,f=document.getElementById("vendprec_prc").value,e=document.getElementById("vendprec_grp").value,g=document.getElementById("vendprec_pcod").value,h=document.getElementById("vendprec_cbar").value;lstart=""+d;return"&vpt="+a+"&vpc="+b+"&vpq="+c+"&vpa="+d+"&vpp="+f+"&vpg="+e+"&vpcod="+
g+"&vpcbar="+h}function usuar_nv(){var a=bsccaresp(document.getElementById("usu_us").value),b=bsccaresp(document.getElementById("usu_nms").value),c=bsccaresp(document.getElementById("usu_ap").value),d=document.getElementById("usu_cat").value,f=bsccaresp(document.getElementById("usu_priv").value);return"&usu="+a+"&usn="+b+"&usa="+c+"&usc="+d+"&usp="+f}
function desp_nv(){var a=document.getElementById("desp_tp").value,b=document.getElementById("desp_vl").value,c=document.getElementById("desp_dt").value,d=bsccaresp(document.getElementById("desp_ob").value);return"&dst="+a+"&dsv="+b+"&dsd="+c+"&dso="+d}
function comp_nv(){var a=document.getElementById("comp_tp").value,b=document.getElementById("comp_cat").value,c=document.getElementById("comp_quant").value,d=document.getElementById("comp_art").value,f=document.getElementById("comp_prec").value,e=document.getElementById("comp_grp").value,g=document.getElementById("comp_pcod").value,h=document.getElementById("comp_cbar").value,k=document.getElementById("comp_oprec").value,m=document.getElementById("comp_prz").value,r=document.getElementById("comp_oprectp").value,
n=document.getElementById("comp_lot").value;return"&cmt="+a+"&cmc="+b+"&cmq="+c+"&cma="+d+"&cmp="+f+"&cmg="+e+"&cmpcod="+g+"&cmcbar="+h+"&comp_oprec="+k+"&comp_oprectp="+r+"&comp_prz="+m+"&comp_lot="+n}
function comp_nvinv(){var a=document.getElementById("comp_tpinv").value,b=document.getElementById("comp_catinv").value,c=document.getElementById("comp_quantinv").value,d=document.getElementById("comp_artinv").value,f=document.getElementById("comp_precinv").value,e=document.getElementById("comp_grpinv").value,g=document.getElementById("comp_pcodinv").value,h=document.getElementById("comp_cbarinv").value;return"&cmt="+a+"&cmc="+b+"&cmq="+c+"&cma="+d+"&cmp="+f+"&cmg="+e+"&cmpcod="+g+"&cmcbar="+h+"&pcsartcnt="+
lstpurcqty}
function vend_nv(){var a=document.getElementById("vend_tp").value,b=document.getElementById("vend_cat").value,c=document.getElementById("vend_quant").value,d=document.getElementById("vend_art").value,f=document.getElementById("vend_prc").value,e=""+document.getElementById("idc").innerHTML,g=document.getElementById("clientanome").value,h=document.getElementById("vend_grp").value,k=document.getElementById("vend_pcod").value,m=document.getElementById("vend_cbar").value,r="";try{r=document.getElementById("txtstck").value}catch(n){r=""}"c"!==
slsalc&&(r="");"c"===slsalc&&(f="0.00");try{0>Number(f)&&(c="0")}catch(n){}return",vg="+h+",pcod="+k+",pcbar="+m+",vt="+a+",vc="+b+",va="+d+",vq="+c+",vp="+f+",clt="+e+",nm="+g+",pcsartcnt="+lstpurcqty+",txtstck="+r+",slsalc="+slsalc+":"}
function vendary(){if("1"===gbtninsrtvend)return desabledelement(),!1;var a=document.getElementById("vend_tp").value,b=document.getElementById("vend_cat").value,c=document.getElementById("vend_quant").value,d=document.getElementById("vend_art").value,f=document.getElementById("vend_prc").value;document.getElementById("vend_grp");var e=document.getElementById("vend_pcod").value,g=document.getElementById("vend_cbar").value,h="";try{h=document.getElementById("txtstck").value}catch(k){h=""}"NA"===a||
"NA"===b||"0"===c||"NA"===d||"0.0"===f||""===e||""===g?document.getElementById("dvrst").innerHTML="<span style='color: red;'>"+all_fields_must_be_filled+"!</span>":"c"!==slsalc||null!==h&&""!==h&&"undefined"!==typeof h?(vndits[vndits.length]=vend_nv(),rfrsh_vnd(),document.getElementById("dvrst").innerHTML="<span style='color: green;'>"+added_sale+"!</span>",lmp_vend_nv(),sumvaluesforeachtbl("v")):document.getElementById("dvrst").innerHTML="<span style='color: red;'>"+all_fields_must_be_filled+"!</span>"}
function frmrqst(a){return'<div id="rsqst" class="inline" style="width: 120px; height: 74px; padding: 20px;" onclick="setbz(\''+a+'\')">            <div class="plcs1">                <div style=\'float: right; padding: 16px;\'><span style="font-size: 12px;" id="mstm'+a+'"></span><br><span id="msst'+a+'">'+free+'</span></div>                <div class="plcs2" id="msnmb'+a+'">                    <div style="padding-left: 6px;">                        '+cliente+'<br><span style="font-size: 30px; font-weight: bold;">'+
a+'</span><br><span id="usrms'+a+'"></span>                    </div>                </div>            </div>        </div>'}
function gnrtplcs(){var a="";try{for(var b=1;b<noftbls;b++)a+=frmrqst(b)+'<div class="inline" style="width: 160px; height: 168px;"></div>'}catch(c){}try{document.getElementById("dvrmss").innerHTML=a+'<br><br>                   <div style="float: botton; width: 40px; height: 40px; border-radius: 50%;">\n                                    <a href="#" onclick="window.scrollTo(0, 0);" style="text-decoration: none; float: none; display: inline;">\n                                        <img src="/SGRB/img/gotop.png" style="width: 32px; height: 32px;" title="Ir ao topo">\n                                    </a>\n                                </div>'}catch(c){}try{document.getElementById("msnmbr").innerHTML=zz}catch(c){}}
function rstc(){if(4===requestc.readyState){var a=requestc.responseText.split(":");try{for(var b=0;b<noftbls;b++){var c=a[b];if(null!==c.split(";")[1]&&""!==c.split(";")[1]){var d=c.split(";")[0],f=c.split(";")[1],e=f,g="";"empty"===f?(f=free,g="#1D8348"):"pending"===f?(f=pending,g="#F5B041"):f.includes("_")&&(f=busy,g="#DC7633");var h="";try{h=e.split("_")[0]}catch(k){}if("empty"===e||"pending"===e)e="";if("empty"===h||"pending"===h)h="";document.getElementById("msst"+d).innerHTML=f;document.getElementById("usrms"+
d).innerHTML=h;document.getElementById("msnmb"+d).style.backgroundColor=g;document.getElementById("mstm"+d).innerHTML=e}}}catch(k){}}}
function gnrArtImg(a){var b='<a href="#" onclick="clsdvgnrartimg()" style="float: right; top: 1px;">Fechar</a><br>';try{document.getElementById("dvgnrartimg").style.display="block"}catch(m){}var c=document.getElementById("lstprdvendas").getElementsByTagName("tr");try{for(var d=2;400>d;d++){var f=c[d].getElementsByTagName("td")[2];c[d].getElementsByTagName("td");var e=c[d].getElementsByTagName("td")[5];var g=f.textContent||f.innerText;var h=e.textContent||e.innerText;var k=rmvSpc(g);h=rmvSpc(h);b+=
"<div onclick=\"clsdvgnrartimg(),setArticle('"+a+"','"+g+"')\" style=\"background: url('/SGRB/img2/img"+k+h+".png') no-repeat; background-size: 100%; border-width: 1px; border-color: gray; border-style: solid; display: inline-block; width: 220px; height: 220px;\"></div>"}}catch(m){}try{document.getElementById("dvgnrartimg").innerHTML=b}catch(m){}}function clsdvgnrartimg(){try{document.getElementById("dvgnrartimg").style.display="none"}catch(a){}}
function rmvSpc(a){try{for(var b=0;80>b;b++)if(a.includes(" "))try{a=a.replace(" ","_")}catch(c){}else return a}catch(c){}return a}function getSetP(a){try{setTimeout(function(){document.getElementById(a).scrollIntoView()},500)}catch(b){alert(b.message)}}
function ass_artg_to_client(){if(confirm(do_you_want_to_associate_with_a_customer)){try{document.getElementById("ass_client").style.display="block"}catch(a){}try{document.getElementById("ass_client_label").style.display="block"}catch(a){}alert(select_the_customer_in_the_table_referring_to)}}function setClient(a){try{document.getElementById("ass_client").value=a}catch(b){}}
function getStatusOfPlaces0(a){var b=a;"busyBusyOcupadoOcupadoOccup&eacute".includes(a)?b="Ocupado":"pendingPendingPendentePendienteEn attente".includes(a)&&(b="Pendente");return b}function getStatusOfPlaces(a){var b=a;"busyBusyOcupadoOcupadoOccup&eacute".includes(a)?b="cupado":"pendingPendingPendentePendienteEn attente".includes(a)&&(b="endente");return b}function change_lng(a){processar(a,"lng")}
function lockscreenfnt(a){try{document.getElementById("dvprcssr").style.display="block"}catch(b){}try{document.getElementById("closeprocessstatus").innerHTML=""+a+" "+passwordunlk+"<input type='password' id='passwrdunlkscrn' style = 'width: 120px;'/><a href='#' onclick=\"processar('unlckscrn','unlckscrn')\">"+unloakmsg+"</a>"}catch(b){}}
function unlockscreenfnt(a){try{document.getElementById("closeprocessstatus").innerHTML=a}catch(b){}try{document.getElementById("dvprcssr").style.display="none"}catch(b){}};

        </script>
        <style>
            table {
                border-collapse: collapse;
                text-align: center;
            }
            th, td {
                padding: 6px;                
            } 
            .plcs1 {
                border-radius: 6px;
                width: 236px;
                height: 108px;
                background: #D68910;
                color: white;
                box-shadow: 1px 1px 30px rgba(0, 0, 0, .1);
            }
            .plcs2 {
                height: 110%;
                width: 68px;
                margin-top: -5%;
                margin-left: 2px;
                vertical-align: top;
                background: #1D8348;
                color: white;
                font-size: 12px;
                box-shadow: 1px 1px 30px rgba(0, 0, 0, .1);
            }
            div.inline { float:left; }
            .clearBoth { clear:both; }
            .center {
                margin: auto;
                width: 50%;
                padding: 10px;
                text-align: center;
            }
            /*#tblmn td:hover {
                background: #5499C7;
                cursor: pointer;
            }*/
            #tblmn tbody>tr>td:hover {
                background-color:#96c7ef!important;
            }
            input[type=text] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=text]:focus {
                border-color: green
            }
            input[type=number] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue
            }
            input[type=password] {
                outline: 0;
                border-width: 0 0 2px;
                border-color: blue;
            }
            input[type=number]:focus {
                border-color: green;
            }
            input[type=password]:focus { 
                border-color: green;
            }
            <%=lnk_disabled%>
        </style>
    </head>
    <body oncontextmenu="return false" style="display: none;">
        <div style="position: absolute; top: 0px; left: 0px; display: block; z-index: 1; width: 100%; height: 100%;">
            <%=version_status%>
            <%=sky%>
            <div style="z-index: -1; width: 100%; height: 100%;">
                <div style = "background-image: linear-gradient(#5499C7, white, #5499C7);"><img src="<%=cssn.getOrgInf()[1]%>" alt= "<%=lang.lng(current_lang, "logo")%>" style="width: 140px; height: 70px;"/> <strong><span id="title_of_proj" style="padding: 10px; font-size: 32px;"><%=lang.lng(current_lang, "stock_management_system")%>: <%=vls.trnslt(current_lang, sector2)%></span></strong><div style="float: right;font-size: 12px; padding-right: 6px;">
                        <%=lang.lng(current_lang, "language")%>: <select onchange="change_lng(this.value)">
                            <%
                               String optnslng = current_lang; 
                               /*if(current_lang.equalsIgnoreCase("english")){
                                  optnslng = "portuguese";
                               } else{
                                  optnslng = "english";
                               }*/
                            %>
                            <option value="<%=optnslng%>"><%=lang.lng(current_lang, optnslng)%></option> 
                            <option value="portuguese"><%=lang.lng(current_lang, "portuguese")%></option> 
                            <option value="english"><%=lang.lng(current_lang, "english")%></option>
                            <option value="spanish"><%=lang.lng(current_lang, "spanish")%></option>
                            <option value="french"><%=lang.lng(current_lang, "french")%></option> 
                            </select>
                            <a href="#" onclick="lockscreenfnt('<%=lang.lng(current_lang, "lockscreen_message")%>')" title="<%=lang.lng(current_lang, "lockscreen")%>"><%=lang.lng(current_lang, "lockscreen")%></a>
                        <%=lang.lng(current_lang, "username")%>: <span style="color: blue;"><%=Lb.getNome()%></span><a href="/SGRB/r?t=3" style="text-decoration: none; color: grey;"><img src="/SGRB/img/close.png" style="width: 32px; height: 32px;" title="<%=lang.lng(current_lang, "logout")%>"></a></div></div>
                <div class="container" style="float: left;">
                    <!--<ul class="nav nav-tabs">
                        <li><a href="#" onclick="chstb('dshb')">Dashboard</a></li>class="active"
                        <li><a href="#" onclick="chstb('ms')">Pedidos</a></li>
                        <li><a href="#" onclick="chstb('vnds')">Vendas</a></li>
                        <li><a href="#" onclick="chstb('cmps')">Compras</a></li>
                        <li><a href="#" onclick="chstb('dsps')">Despesas</a></li>
                        <li><a href="#" onclick="chstb('gst')">Gest&atilde;o</a></li>	
                        <li><a href="#" onclick="chstb('rlt')">Relatorios</a></li>
                        <li><a href="#" onclick="chstb('vndr')">Vendas Anteriores</a></li>
                        <li><a href="#" onclick="chstb('prdest')">Stock</a></li>
                        <li><a href="#" onclick="chstb('dpst')">Depositos/D&iacute;vidas</a></li>
                        <li><a href="#" onclick="chstb('ttrl')">Manual</a></li>
                    </ul>-->
                    <div id="periodo" style="display: none; width: 100%; background-color: #ABEBC6;">De <input id = "di" type="date" style="width: 140px;" <%=dsbld%>> 	&agrave; <input id = "df" type="date" style="width: 140px;" <%=dsbld%>> 
                        <div style="padding-left: 10px; display: inline-block; width: 40px; height: 40px; border-radius: 50%;">
                            <a href="#" onclick="limpar()" style="text-decoration: none; float: none; display: inline;">
                                <img src="/SGRB/img/rmvp.png" style="width: 32px; height: 32px;" title="<%=lang.lng(current_lang, "clean")%>">
                            </a>
                        </div>
                    </div>
                    <div id="dvrwsintbls" style="display: none; width: 100%; font-size: 11px; float: right;"><%=lang.lng(current_lang, "records_per_table")%>: <input type="number" id="rwsintbls" value = "1000" style = "width: 66px;" min="20">
                        <select id="yesnodlt"><option value="Nao apagados"><%=lang.lng(current_lang, "do_not_erase")%></option><option value="Todos"><%=lang.lng(current_lang, "all")%></option></select>
                    </div>
                    <div style="width: 100%;">
                        <input type="image" src="/SGRB/img/menu.png" id="btnmn" onclick="chstb('mn')" style="float: right; display: none; width: 40px; height: 26px;"/>
                    </div>
                    <div style="width: 100%; height: 90%;">
                        <div class="divtbs" id="dvrst" style="width: 100%;"></div>
                        <div class="divtbs" id="dshb" style="display: none; width: 100%;height: 90%;">

                            <table style="width: 100%;height: 100%;">
                                <tr>
                                    <!--<td style="width: 12px; background-color: gainsboro;">
                                        <a href="#" onclick="chstb2('s')">Sumario</a><br>
                                        <a href="#" onclick="chstb2('v')">Vendas</a><br>
                                        <a href="#" onclick="chstb2('c')">Compras</a><br>
                                        <a href="#" onclick="chstb2('d')">Despesas</a><br>  
                                    </td>-->
                                    <td>
                                        <div style="width: 100%;height: 100%;"> 
                                            <div style="width: 100%;">
                                                <a href="#" style="font-size: 11px;" onclick="processar('dhs', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                            </div>
                                            <div id="dshtp" style="width: 100%;">

                                            </div>
                                            <div style="width: 900px; height: 300px;"> 
                                                <table style="width: 100%; height: 100%; float: top;">
                                                    <tr>
                                                        <td>
                                                            <canvas id="brchrt" width="300" height="300"></canvas>
                                                        </td>
                                                        <td>
                                                            <canvas id="lnchrt" width="600" height="300"></canvas>
                                                        </td>
                                                    </tr>
                                                </table>                                       

                                            </div>

                                        </div>   
                                    </td>
                                </tr>
                            </table>                     
                        </div>
                        <div class="divtbs" id="vnds" style="display: none; width: 100%">
                            <table>
                                <tr>
                                    <td style="vertical-align: top; width: 60%;">
                                        <div style="height: 100%;">
                                            <strong id="strngvnd" style="float: left; font-size: 30px;"><%=lang.lng(current_lang, "sales")%></strong><br><br>
                                            <div id="mspymtrqst" style="text-align: left; width: 100%;"><a href="#" onclick="checklstofms(), processar('mspymtrqst', 'b')" style="text-decoration: none;"><%=lang.lng(current_lang, "view_payment_requests")%></a></div><br>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "processar('n', 'n')", "/SGRB/img/usr.png", "id=\"btnnvclnt\"", "float: left;")%>
                                            <br>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <%=lang.lng(current_lang, "current_customer_id")%>: 
                                                    </td>
                                                    <td>
                                                        <span id="idc" style="color: blue; font-weight: bold;"></span>
                                                    </td>
                                                    <td>
                                                        <%=lang.lng(current_lang, "name")%>: 
                                                    </td>
                                                    <td>
                                                        <input type="text" id="clientanome">
                                                    </td>
                                                    <td>
                                                        <%=vls.dinmcbtn(lang.lng(current_lang, "print_out"), "imprcb()", "/SGRB/img/printp.png", "", "")%> 
                                                    </td>
                                                </tr>       

                                            </table><br>
                                            <span><%=lang.lng(current_lang, "link_the_sale_to_a_registered_customer?_if_yes_click")%> <a href="#" onclick="ass_artg_to_client()"><%=lang.lng(current_lang, "here")%></a>.</span>
                                            <table>
                                                <tr>
                                                    <td><span id="ass_client_label"><%=lang.lng(current_lang, "associating_with_the_customer")%>: </span></td>
                                                    <td><input type="text" id="ass_client" disabled="disabled" style="display: none;"></td>                                                        
                                                </tr>
                                            </table>   
                                            <br>       
                                            <div id="dvidc">

                                            </div>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "add_article"), "nvc('vendcnv')", "/SGRB/img/newp.png", "id=\"btnaddarts\"", "float: left;")%>
                                            <br>

                                            <div id="vendcnv" style="display: none; background-color: #D6EAF8;">
                                                <input type="radio" id="vrdo_art" name="vrdo_art" value="<%=lang.lng(current_lang, "article")%>" onclick="checkcpb('vrdo_art')" checked="checked"><label for="vrdo_art"><%=lang.lng(current_lang, "article")%></label>
                                                <input type="radio" id="vrdo_prod" name="vrdo_prod" value="Codigo do Produto" onclick="checkcpb('vrdo_prod')"><label for="vrdo_prod">Codigo do Produto</label>
                                                <input type="radio" id="vrdo_bar" name="vrdo_bar" value="<%=lang.lng(current_lang, "bar_code")%>" onclick="checkcpb('vrdo_bar')"><label for="vrdo_bar"><%=lang.lng(current_lang, "bar_code")%></label>
                                                <span id="spvendtp" style="padding-left: 50px; color: blue;"><%=lang.lng(current_lang, "normal_sale")%>!</span>
                                                <br>
                                                <table>
                                                    <tr>
                                                        <td><%=lang.lng(current_lang, "article")%>:</td>
                                                        <td><input type='text' id='vend_art' list='lst_prod' onchange="getCodBarCode(this.value, 'v')" /></td>
                                                        <td><%=lang.lng(current_lang, "prod_code")%>:</td>
                                                        <td><input type="text" id="vend_pcod" disabled="disabled" ></td>
                                                        <td><%=lang.lng(current_lang, "bar_code")%>:</td>
                                                        <td><input type="text" id="vend_cbar" disabled="disabled" ></td>
                                                    </tr>
                                                    <tr><td style="height: 6px;"></td></tr>
                                                    <tr>
                                                        <td><%=lang.lng(current_lang, "group")%>:</td>
                                                        <td><input type="text" id="vend_grp" disabled="disabled" ></td>
                                                        <td><%=lang.lng(current_lang, "type")%>:</td>
                                                        <td><input type="text" id="vend_tp" disabled="disabled" ></td>
                                                        <td><%=lang.lng(current_lang, "category")%>:</td>
                                                        <td><input type="text" id="vend_cat" disabled="disabled" ></td>
                                                    </tr>
                                                    <tr><td style="height: 6px;"></td></tr>
                                                    <tr>
                                                        <td><%=lang.lng(current_lang, "the_amount")%>:</td>
                                                        <td>
                                                            <input type="number" id="vend_quant" onchange="processar('vpr', 'vpr')" onkeyup="processar('vpr', 'vpr')" style="width: 60px;" min="1" max="9999">
                                                        </td>
                                                        <td><%=lang.lng(current_lang, "price")%>:</td>
                                                        <td> 
                                                            <input type="decimal" disabled="disabled" id="vend_prc" value="0.00" style="width: 80px;">
                                                        </td>
                                                        <td colspan="2">
                                                            <div id="spdescount"></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "vendary()", "/SGRB/img/insertptb.png", "", "float: right;")%>
                                                        </td>
                                                    </tr>
                                                </table>                                            
                                            </div><br>
                                            <a href="#" onclick="lasts_sales_made()" style="float: left; text-decoration: none;"><%=lang.lng(current_lang, "see_latest_sales")%></a><br>            
                                            <span id="tbdvrvsum" style="padding-left: 10px; font-size: 28px;"></span><br>    
                                            <div id="tblvn">
                                                <table border="1" id="tbdvrv">
                                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                                        <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "group")%></th>
                                                        <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                                        <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                                        <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                                        <th><%=lang.lng(current_lang, "price")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                                    </tr>
                                                </table>
                                            </div>
                                            <br>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "process_sale"), "checklstofmsno(), processar('v', 'v')", "/SGRB/img/insertp4.png", "id=\"btnprcvenda\"", "float: left;")%>
                                            <br>
                                        </div>
                                    </td>    
                                    <td style="width: 26%; vertical-align: top;">
                                        <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprdvendas" style="width: 240px;">
                                        <input type="button" onclick="filart('lstprdvendas', document.getElementById('txtprdvendas').value)" value="<%=lang.lng(current_lang, "search")%>">
                                        <a href="#" style="font-size: 11px;" onclick="processar('lstprdvendas', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a> 
                                        <a href="#" style="font-size: 11px;" onclick="gnrArtImg('lstprdvendas')" <%=dsbld%>><%=lang.lng(current_lang, "images")%></a> 
                                        <br>
                                        <div id="dvlstprdvendas" style="height: 300px; overflow-y: scroll;">
                                            <%=vls.list_prod_ctgry("lstprdvendas", sector, "a")%>
                                        </div>
                                        <br>
                                        <%=lang.lng(current_lang, "registered_customer")%>:<input type="text" id="txtprdvendas" style="width: 180px;">
                                        <input type="button" onclick="filart('lstprdvendas', document.getElementById('txtprdvendas').value)" value="<%=lang.lng(current_lang, "search")%>">
                                        <div id="dvlstprdvendas" style="height: 300px; overflow-y: scroll;">
                                            <%=vls.list_of_enrolled_client(sector)%>
                                        </div>
                                    </td> 
                                </tr>    
                            </table>


                        </div>
                        <div class="divtbs" id="cmps" style="display: none; width: 100%">
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "purchase")%></strong><br>
                            <div style="width: 100%;"><%=lang.lng(current_lang, "navigate_to")%>: <a href="#prodinvttlid"><%=lang.lng(current_lang, "invalid_products")%></a>.</div><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('comnv')", "/SGRB/img/newp.png", "id=\"btnnvc\"", "float: left;")%>
                            <span id="tbdvrcsum" style="padding-left: 260px; font-size: 28px;"></span><br>

                            <div id="comnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                <input type="radio" id="crdo_art" name="crdo_art" value="<%=lang.lng(current_lang, "article")%>" onclick="checkcpb('crdo_art')" checked="checked"><label for="crdo_art"><%=lang.lng(current_lang, "article")%></label>
                                <input type="radio" id="crdo_prod" name="crdo_prod" value="Codigo do Produto" onclick="checkcpb('crdo_prod')"><label for="crdo_prod">Codigo do Produto</label>
                                <input type="radio" id="crdo_bar" name="crdo_bar" value="<%=lang.lng(current_lang, "bar_code")%>" onclick="checkcpb('crdo_bar')"><label for="crdo_bar"><%=lang.lng(current_lang, "bar_code")%></label>
                                <br>
                                <table>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "article")%>:</td>
                                        <td><input type='text' id='comp_art' list='lst_prod' onchange="getCodBarCode(this.value, 'c')" /></td>
                                        <td><%=lang.lng(current_lang, "prod_code")%>:</td>
                                        <td><input type="text" id="comp_pcod" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "bar_code")%>:</td>
                                        <td><input type="text" id="comp_cbar" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "group")%>:</td>
                                        <td><input type="text" id="comp_grp" disabled="disabled" ></td>
                                    </tr>
                                    <tr><td style="height: 6px;"></td></tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "type")%>:</td>
                                        <td><input type="text" id="comp_tp" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "category")%>:</td>
                                        <td><input type="text" id="comp_cat" disabled="disabled" >  </td>
                                        <td><%=lang.lng(current_lang, "the_amount")%>:</td>
                                        <td><input type="number" id="comp_quant" style="width: 60px;" min="1" max="9999"></td>
                                        <td><%=lang.lng(current_lang, "price")%>:</td>
                                        <td><input type="decimal" id="comp_prec" style="width: 80px;" ></td>
                                    </tr>
                                    <tr><td style="height: 6px;"></td></tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "other_currency")%>:</td>
                                        <td>
                                            <input type="decimal" id="comp_oprec" style="width: 80px;" value="0.00">
                                            <select id="comp_oprectp">
                                                <option value="NA">NA</option> 
                                                <option value="ZAR">ZAR</option> 
                                                <option value="USD">USD</option>  
                                            </select>
                                        </td>
                                        <td><%=lang.lng(current_lang, "deadline")%>:</td>
                                        <td><input type="date" id="comp_prz" style="width: 150px;"></td>
                                        <td><%=lang.lng(current_lang, "batch")%>:</td>
                                        <td><input type="text" id="comp_lot" >  </td>
                                        <td colspan="2">
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('c', 'c')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprcartc" style="width: 300px;">
                                <input type="button" onclick="filbyclnsnr('tbdvrc', document.getElementById('txtprcartc').value, 2, 3, 6, 'c')" value="<%=lang.lng(current_lang, "search")%>">
                                <a href="#" style="font-size: 11px;" onclick="processar('c', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>, <a href="#" style="font-size: 11px;" onclick="processar('cprz', 'b')" <%=dsbld%>>Ordenar por prazo</a>

                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('c', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('c', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                            </div> 
                            <div id="dvrc">
                                <table border="1" id="tbdvrc">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrc', 0)"><%=lang.lng(current_lang, "order")%></a></th>
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrc', 1)"><%=lang.lng(current_lang, "group")%></a></th>
                                        <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                        <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                        <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                        <th><%=lang.lng(current_lang, "price")%></th><th><%=lang.lng(current_lang, "other_currency")%></th>
                                        <th><%=lang.lng(current_lang, "country")%></th><th><%=lang.lng(current_lang, "deadline")%></th>
                                        <th style="background-color: greenyellow;" title="<%=lang.lng(current_lang, "profit_st")%> = <%=vls.frml_purchase_profit()%>"><%=lang.lng(current_lang, "profit_st")%></th>
                                        <th><%=lang.lng(current_lang, "batch")%></th>
                                        <th><div style="width: 160px;"><%=lang.lng(current_lang, "registration_date")%></div></th>
                                        <th><%=lang.lng(current_lang, "user")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                        <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                    </tr>
                                </table>
                            </div> 
                            <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('c', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('c', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                            <br><br>
                            <strong id="prodinvttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "invalid_products_(no_conditions_of_use)")%></strong><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('comnvinv'),getSetP('prodinvttlid')", "/SGRB/img/newp.png", "id=\"btnnvci\"", "float: left;")%>
                            <br>
                            <div id="comnvinv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                <table>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "article")%>:</td>
                                        <td><input type='text' id='comp_artinv' list='lst_prod'  onchange="getCodBarCode(this.value, 'ci')" /></td>
                                        <td><%=lang.lng(current_lang, "prod_code")%>:</td>
                                        <td><input type="text" id="comp_pcodinv" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "bar_code")%>:</td>
                                        <td><input type="text" id="comp_cbarinv" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "group")%>:</td>
                                        <td><input type="text" id="comp_grpinv" disabled="disabled" ></td>
                                    </tr>
                                    <tr><td style="height: 6px;"></td></tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "type")%>:</td>
                                        <td><input type="text" id="comp_tpinv" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "category")%>:</td>
                                        <td><input type="text" id="comp_catinv" disabled="disabled" ></td>
                                        <td><%=lang.lng(current_lang, "the_amount")%>:</td>
                                        <td><input type="number" id="comp_quantinv" style="width: 80px;" min="1" max="9999"></td>
                                        <td><%=lang.lng(current_lang, "price")%><a href="#" style="text-decoration: none;" onclick="alert(price_is_not_considered_in_this_section + '!')">?</a>:</td>
                                        <td><input type="decimal" disabled="disabled" id="comp_precinv" value = "0.00" style="width: 60px;" ></td>
                                        <td>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('ci', 'ci')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                        </td>
                                    </tr>                                
                                </table>
                            </div>
                            <div>
                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprcartci" style="width: 300px;">
                                <input type="button" onclick="filbyclnsnr('tbdvrci', document.getElementById('txtprcartci').value, 2, 3, 6, 'a')" value="Procurar">
                                <a href="#" style="font-size: 11px;" onclick="processar('ci', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('ci', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('ci', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                            </div> 
                            <div id="dvrci">
                                <table id="tbdvrci" border="1">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "group")%></th>
                                        <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                        <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                        <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                        <th><%=lang.lng(current_lang, "price")%></th>
                                        <th><div style="width: 160px;"><%=lang.lng(current_lang, "registration_date")%></div></th>
                                        <th><%=lang.lng(current_lang, "user")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                        <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                    </tr>
                                </table>
                            </div>   
                            <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('ci', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('ci', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>
                            <br><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                        </div>
                        <div class="divtbs" id="dsps" style="display: none; width: 100%">
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "expenses")%></strong><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('desnv')", "/SGRB/img/newp.png", "id=\"btnnvd\"", "float: left;")%>
                            <span id="tbdvrdsum" style="padding-left: 260px; font-size: 28px;"></span><br>
                            <div  id="desnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                <%=lang.lng(current_lang, "type")%>: 
                                <select id="desp_tp">
                                    <option value="Electrecidade"><%=lang.lng(current_lang, "electricity")%></option> 
                                    <option value="Agua"><%=lang.lng(current_lang, "water")%></option> 
                                    <option value="Telefone"><%=lang.lng(current_lang, "telephone")%></option> 
                                    <option value="Outra"><%=lang.lng(current_lang, "other")%></option> 
                                </select>
                                <%=lang.lng(current_lang, "value")%>:
                                <input type="text" id="desp_vl" style="width: 80px;" >
                                Data:
                                <input type="date" id="desp_dt">
                                <%=lang.lng(current_lang, "observation")%>:
                                <input type="text" id="desp_ob">
                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('d', 'd')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                            </div>
                            <div>
                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtdvrestb" onkeyup="filbyclnsnr('tbdvrd', this.value, 1, 2, 6, 'd')" style="width: 300px;">
                                <a href="#" style="font-size: 11px;" onclick="processar('d', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('d', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('d', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>
                            </div> 
                            <div id="dvrd">
                                <table border="1" id="tbdvrd">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrd', 0)"><%=lang.lng(current_lang, "order")%></a></th>
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrd', 1)"><%=lang.lng(current_lang, "type")%></a></th>
                                        <th>Valor</th><th><%=lang.lng(current_lang, "date_expense")%></th>
                                        <th><%=lang.lng(current_lang, "observation")%></th>
                                        <th><div style="width: 160px;"><%=lang.lng(current_lang, "registration_date")%></div></th>
                                        <th><%=lang.lng(current_lang, "user")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                        <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                    </tr>
                                </table>
                            </div>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('d', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('d', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>
                            <br><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                        </div>
                        <div class="divtbs" id="dpst" style="display: none; width: 100%">
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "deposits/debts/purchases")%></strong><br><br>
                            <span style="font-size: 12px; color: blue;">
                                <%=lang.lng(current_lang, "the_summary_and_table_only_show")%> <strong><%=lang.lng(current_lang, "deposits")%></strong> e <strong><%=lang.lng(current_lang, "debts")%></strong>, 
                                    <%=lang.lng(current_lang, "to_see")%> <strong><%=lang.lng(current_lang, "purchases")%></strong> <%=lang.lng(current_lang, "click_on_customer")%>
                            </span><br>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('dtnv')", "/SGRB/img/newp.png", "id=\"btnnvdt\"", "float: left;")%>
                            <br>
                            <span id="tbdvrdptsum" style="padding-left: 2px; font-size: 28px;"></span><br>
                            <div id="dtnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                <table>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "client_name")%>:</td>
                                        <td>
                                            <input type="text" id="dpst_clientname" style="width: 140px;" >
                                        </td>
                                        <td><%=lang.lng(current_lang, "place_of_residence")%>:</td>
                                        <td>
                                            <input type="text" id="dpst_residenty" style="width: 140px;" >
                                        </td>
                                        <td><%=lang.lng(current_lang, "bi")%>:</td>
                                        <td>
                                            <input type="text" id="dpst_id_number" style="width: 140px;" >
                                        </td>
                                        <td><%=lang.lng(current_lang, "telephone")%>:</td>
                                        <td>
                                            <input type="number" id="dpst_phone" style="width: 140px;" >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "observation")%>:</td>
                                        <td colspan="4">
                                            <input type="text" id="dpst_observation" style="width: 100%;" >
                                        </td>
                                        <td colspan="2">
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('dpst', 'dpst')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                        </td>
                                    </tr>
                                </table>                        
                            </div>
                            <br>
                            <div>
                                <%=lang.lng(current_lang, "content")%>:<input type="text" id="txtdvrestb" onkeyup="filbyclnsnr('tbdvdpst', this.value, 1, 2, 4, 'dpst')" style="width: 300px;">
                                <a href="#" style="font-size: 11px;" onclick="processar('dpst', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('dpst', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('dpst', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>
                            </div> 
                            <div id="dvrdpst">
                                <table border="1" id="tbdvdpst">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrdpst', 0)"><%=lang.lng(current_lang, "order")%></a></th>
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrd', 1)"><%=lang.lng(current_lang, "client_name")%></a></th>
                                        <th><%=lang.lng(current_lang, "place_of_residence")%></th><th><%=lang.lng(current_lang, "bi")%></th>
                                        <th><%=lang.lng(current_lang, "telephone")%></th><th><%=lang.lng(current_lang, "observation")%></th>
                                        <th><div style="width: 160px;"><%=lang.lng(current_lang, "last_day_deposit")%></div></th>
                                        <th><%=lang.lng(current_lang, "total_value")%></th><th><%=lang.lng(current_lang, "total_used")%></th>
                                        <th><%=lang.lng(current_lang, "total_balance")%></th>
                                    </tr>
                                </table>
                            </div>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('dpst', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                            <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('dpst', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>
                            <br><br><%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                        </div>    
                        <div class="divtbs" id="gst" style="display: none; width: 100%">
                            <div style="width: 100%;"><%=lang.lng(current_lang, "navigate_to")%>: <a href="#usrttlid"><%=lang.lng(current_lang, "users")%></a>, <a href="#vendprecid"><%=lang.lng(current_lang, "sale/price")%></a>, <a href="#prodttlid"><%=lang.lng(current_lang, "products")%></a>, <a href="#fctryttlid"><%=lang.lng(current_lang, "group/manufacture")%></a>, <a href="#msttlid"><%=lang.lng(current_lang, "tables")%></a>.</div>
                            <br>
                            <div>
                                <table>
                                    <tr>
                                        <td colspan="8">
                                            <strong><%=lang.lng(current_lang, "unique_installation_number")%>: <%=cssn.keystatus()[6]%>, <%=lang.lng(current_lang, "status")%>: <%=cssn.keystatus()[7]%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><%=lang.lng(current_lang, "system_id")%>:</td><td><input type="text" id="txtsysid"  disabled="disabled"></td>
                                        <td><%=lang.lng(current_lang, "password")%>:</td><td><input type="password" id="txtsyspwd"  disabled="disabled"></td><td style="width: 4px;"></td>
                                        <td>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "open"), "enablesysidpwd()", "/SGRB/img/openp.png", "", "")%>
                                        </td><td style="width: 4px;"></td>
                                        <td>
                                            <%=vls.dinmcbtn(lang.lng(current_lang, "validate"), "processar('sysssn', 'sysssn')", "/SGRB/img/editp.png", "", "")%>
                                        </td>
                                    </tr>
                                </table><br>
                                <strong id="deslocid" style="font-size: 30px;"><%=lang.lng(current_lang, "designation_and_location")%></strong><br>
                                <div>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "enable_fields"), "aborginf(),getSetP('deslocid')", "/SGRB/img/openp.png", "", "")%>
                                    <br>
                                    <table>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "logo")%>:</td><td><img id="lgimg" src="<%=cssn.getOrgInf()[1]%>" style="width: 120px; height: 50px;"><input type="file" name="fllogt" id="fllogt" disabled="disabled"></td><td>
                                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chcklogt" value="1" disabled="disabled" <%=cssn.getOrgInf()[3]%>>
                                            </td>
                                        </tr>
                                        <tr><td style="height: 6px;"></td></tr>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "designation")%>:</td><td><input type="text" id="txtdesig" value="<%=cssn.getOrgInf()[0]%>" disabled="disabled"></td><td>
                                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chckdesig" value="1" <%=cssn.getOrgInf()[4]%> disabled="disabled">
                                            </td>
                                        </tr>
                                        <tr><td style="height: 6px;"></td></tr>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "location")%>:</td><td><input type="text" id="txtlocz" value="<%=cssn.getOrgInf()[2]%>" disabled="disabled"></td><td>
                                                <%=lang.lng(current_lang, "show_in_the_report")%><input type="checkbox" id="chcklocz" value="1" <%=cssn.getOrgInf()[5]%> disabled="disabled">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Backup(link):</td><td><input type="text" id="txtblnk" value="<%=cssn.getOrgInf()[6]%>" disabled="disabled"></td><td>
                                            </td>
                                        </tr>
                                    </table><br>
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "add_or_update"), "", "/SGRB/img/editp.png", "id=\"btndesloc\"", "float: none;")%>
                                </div>                                    
                            </div>
                            <br>        
                            <div>
                                <strong id="usrttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "users")%></strong><br>
                                <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('usnv'),getSetP('usrttlid')", "/SGRB/img/usr.png", "id=\"btnnvusr\"", "float: left;")%>
                                <br>
                                <div id="usnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                    <table>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "user")%>:</td>
                                            <td><input type="text" id="usu_us"></td>
                                            <td><%=lang.lng(current_lang, "first_names")%>:</td>
                                            <td><input type="text" id="usu_nms"></td>
                                            <td><%=lang.lng(current_lang, "surname")%>:</td>
                                            <td><input type="text" id="usu_ap"></td>
                                            <td><%=lang.lng(current_lang, "category")%>:</td>
                                            <td>
                                                <select  id="usu_cat">
                                                    <option value="Gestor"><%=lang.lng(current_lang, "manager")%></option> 
                                                    <option value="Caixa"><%=lang.lng(current_lang, "cashier")%></option> 
                                                    <option value="NA">NA</option> 
                                                </select>  
                                            </td>
                                        </tr>
                                        <tr><td style="height: 6px;"></td></tr>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "privileges")%>:</td>
                                            <td><input type="text" id="usu_priv" style="width: 60px;"></td>
                                            <td colspan="6">
                                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('g', 'u')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                            </td>
                                        </tr>
                                    </table>                     
                                    <!--<select  id="usu_priv">
                                        <option value="NA">NA</option> 
                                        <option value="A">A</option> 
                                        <option value="B">B</option> 
                                        <option value="C">C</option> 
                                        <option value="D">D</option> 
                                    </select>-->                                
                                </div>
                                <div>
                                    <%=subsrs_nr%>
                                    <a href="#" style="font-size: 11px;" onclick="processar('gu', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                </div>
                                <div id="dvrgu">
                                    <table border="1">
                                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "username")%></th>
                                            <th><%=lang.lng(current_lang, "first_names")%></th><th><%=lang.lng(current_lang, "surname")%></th>
                                            <th><%=lang.lng(current_lang, "category")%></th><th><%=lang.lng(current_lang, "privileges")%><br>
                                                <a href="#" style="font-size: 10px; text-decoration: none;" onclick="verpvlgs()"><%=lang.lng(current_lang, "interpret")%></a></th>
                                            <th><%=lang.lng(current_lang, "state")%></th><th><%=lang.lng(current_lang, "editing")%></th>
                                        </tr>
                                    </table>
                                </div>    
                            </div>
                            <div>
                                <br><br>
                                <strong id="vendprecid" style="font-size: 30px;"><%=lang.lng(current_lang, "sale/price")%></strong><br>
                                <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('vendnv'),getSetP('vendprecid')", "/SGRB/img/newp.png", "id=\"btnnvvp\"", "float: left;")%>
                                <br>
                                <div id="vendnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                    <table>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "article")%>:</td>
                                            <td><input type='text' id='vendprec_art' list='lst_prod2' /></td>
                                            <td><%=lang.lng(current_lang, "prod_code")%>:</td>
                                            <td><input type="text" id="vendprec_pcod"></td>
                                            <td><%=lang.lng(current_lang, "bar_code")%>:</td>
                                            <td><input type="text" id="vendprec_cbar"></td>
                                            <td><%=lang.lng(current_lang, "group")%>:</td>
                                            <td><input type='text' id='vendprec_grp' list='lst_grp'  style="width: 80px;" /></td>
                                        </tr>
                                        <tr><td style="height: 6px;"></td></tr>
                                        <tr>
                                            <td><%=lang.lng(current_lang, "type")%><a href="#" style ="text-decoration: none;" onclick="alert('ND: <%=lang.lng(current_lang, "not_available")%>')">?</a>:</td>
                                            <td>
                                                <select id="vendprec_tp">
                                                    <%
                                                        if (sector.equalsIgnoreCase("Farmacia")
                                                                || sector.equalsIgnoreCase("Venda de Pecas")
                                                                || sector.equalsIgnoreCase("Ferragens")) {
                                                    %>
                                                    <option value="ND">ND</option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=vls.rmvSpcChar(lang.lng(current_lang, "food"))%>"><%=lang.lng(current_lang, "food")%></option> 
                                                    <option value="<%=vls.rmvSpcChar(lang.lng(current_lang, "drink"))%>"><%=lang.lng(current_lang, "drink")%></option> 
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                            <td><%=lang.lng(current_lang, "category")%><a href="#" style ="text-decoration: none;" onclick="alert('ND: <%=lang.lng(current_lang, "not_available")%>')">?</a>:</td>
                                            <td>
                                                <select  id="vendprec_cat">
                                                    <%
                                                        if (sector.equalsIgnoreCase("Farmacia")
                                                                || sector.equalsIgnoreCase("Venda de Pecas")
                                                                || sector.equalsIgnoreCase("Ferragens")) {
                                                    %>
                                                    <option value="ND">ND</option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="NA">NA</option>
                                                    <%
                                                      String ctgryoptn = "";  
                                                      String[] aryLngALL = null;  
                                                      String[] aryLngPT = new String[] {"Doce","Salgado","Acool","Lanche","Entradas","Sopas","Saladas","Petiscos","Aves","Carnes","Acompanhamentos","Sobremesas","PIZZAS medias","PIZZAS 4 Estacoes","Luxus","Pastas","Mariscos","Reifecoes","Outro"};
                                                      String[] aryLngEN = new String[] {"Sweet","Salty","Acool","Snack","Starters","Soups","Salads","Snacks","Poultry","Meat","Side dishes","Desserts","PIZZAS mediums","PIZZAS 4 Estacoes","Luxus","Pasta","Seafood","Reifecoes","Other"};
                                                      String[] aryLngES = new String[] {"Dulces","Salados","Acool","Snack","Entrantes","Sopas","Ensaladas","Snacks","Aves","Carnes","Acompañamientos","Postres"," PIZZAS medianas","PIZZAS 4 Estacoes","Luxus","Pasta","Marisco","Reifecoes","Otros"};
                                                      String[] aryLngFR = new String[] {"Sucré","Salé","Acool","Snack","Entrées","Soupes","Salades","Snacks","Volaille","Viande","Accompagnements","Desserts"," PIZZAS mediums","PIZZAS 4 Estacoes","Luxus","Pâtes","Fruits de mer","Reifecoes","Autre"};
                                                      if(current_lang.equalsIgnoreCase("english")){
                                                         aryLngALL = aryLngEN;
                                                      } else if(current_lang.equalsIgnoreCase("portuguese")){
                                                         aryLngALL = aryLngPT;
                                                      } else if(current_lang.equalsIgnoreCase("spanish")){
                                                         aryLngALL = aryLngES;
                                                      } else if(current_lang.equalsIgnoreCase("french")){
                                                         aryLngALL = aryLngFR;
                                                      } else {
                                                         aryLngALL = aryLngPT;
                                                      } 
                                                      try{
                                                          for(String vlropt : aryLngALL){
                                                              ctgryoptn += "<option value=\"" + vlropt + "\">" + vlropt + "</option>"; 
                                                          }                                                      
                                                      }catch(Exception e){
                                                      
                                                      }
                                                    %>
                                                    <%=ctgryoptn%>
                                                    <!--<option value="Doce">Doce</option> 
                                                    <option value="Salgado">Salgado</option> 
                                                    <option value="Acool">Acool</option>
                                                    <option value="Lanche">Lanche</option> 
                                                    <option value="Entradas">Entradas</option> 
                                                    <option value="Sopas">Sopas</option> 
                                                    <option value="Saladas">Saladas</option> 
                                                    <option value="Petiscos">Petiscos</option> 
                                                    <option value="Aves">Aves</option> 
                                                    <option value="Carnes">Carnes</option> 
                                                    <option value="Acompanhamentos">Acompanhamentos</option> 
                                                    <option value="Sobremesas">Sobremesas</option> 
                                                    <option value="PIZZAS medias">PIZZAS medias</option> 
                                                    <option value="PIZZAS 4 Estacoes">PIZZAS 4 Estacoes</option> 
                                                    <option value="Luxus">Luxus</option> 
                                                    <option value="Pastas">Pastas</option> 
                                                    <option value="Mariscos">Mariscos</option>
                                                    <option value="Reifecoes">Reifecoes</option>-->
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                            <td><%=lang.lng(current_lang, "the_amount")%>:</td>
                                            <td>
                                                <select  id="vendprec_quant">
                                                    <option value="Unidade"><%=lang.lng(current_lang, "unit")%></option> 
                                                    <option value="NA">NA</option> 
                                                </select>
                                            </td>
                                            <td><%=lang.lng(current_lang, "price")%>:</td>
                                            <td><input type="decimal" id="vendprec_prc" style="width: 80px;" ></td>
                                        </tr>
                                        <tr><td style="height: 6px;"></td></tr>
                                        <tr>
                                            <td colspan="8">
                                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('g', 'vp')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                            </td>
                                        </tr>
                                    </table>
                                    <datalist id='lst_grp'>
                                        <option>_</option>
                                        <%=vls.groupslst()%>
                                    </datalist>
                                </div>
                                <div>
                                    <table>
                                        <tr>
                                            <td>
                                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtgvp" style="width: 240px;">
                                                <input type="button" onclick="filbyclnsnr('tbdvrgvp', document.getElementById('txtgvp').value, 2, 3, 6, 'vp')" value="Procurar">
                                                <a href="#" style="font-size: 11px;" onclick="processar('gvp', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a><span style="width: 200px; height: 10px;"></span>

                                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('gvp', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('gvp', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                                            </td>
                                            <td style="width: 160px;">

                                            </td>
                                            <td>
                                                <%=vls.dinmcbtn(lang.lng(current_lang, "change_groups_and_prices"), "alterartatrib()", "/SGRB/img/editp.png", "id=\"btnlstpart\"", "float: none;")%>
                                            </td>
                                        </tr>
                                    </table>
                                </div>  
                                <div id="dvrgvp">
                                    <table border="1" id="tbdvrgvp">
                                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "group")%></th>
                                            <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                            <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                            <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                            <th><%=lang.lng(current_lang, "price")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                            <th><%=lang.lng(current_lang, "removed")%></th>
                                            <th><%=lang.lng(current_lang, "removal")%></th>
                                        </tr>
                                    </table>
                                </div>    
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('gvp', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('gvp', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                            </div>
                            <div>
                                <br><br>
                                <strong id="prodttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "products")%></strong><br>
                                <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('prdnv'),getSetP('prodttlid')", "/SGRB/img/newp.png", "id=\"btnnvprd\"", "float: left;")%>
                                <br>
                                <div id="prdnv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                    <%=lang.lng(current_lang, "product")%>:
                                    <input type="text" id="prodnvl">
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('g', 'prodl')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                </div>
                                <div>
                                    <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprodlst" onkeyup="filart1vl('tbprodlst', this.value)" style="width: 240px;">
                                    <a href="#" style="font-size: 11px;" onclick="processar('prodl', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                    <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('prodl', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                    <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('prodl', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                                </div>  
                                <div id="dvrprodl">
                                    <table id="tbprodlst" border="1">
                                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "product")%></th>
                                            <th><%=lang.lng(current_lang, "marked_rmv")%></th><th><%=lang.lng(current_lang, "removed")%></th>
                                            <th><%=lang.lng(current_lang, "removal")%></th>
                                        </tr>
                                    </table>
                                </div>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('prodl', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('prodl', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                                <br><br>
                                <strong id="fctryttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "groups/manufacture")%></strong><br>
                                <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('fctrynv'),getSetP('fctryttlid')", "/SGRB/img/newp.png", "id=\"btnnvfctry\"", "float: left;")%>                                
                                <br>
                                <div id="fctrynv" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                    <%=lang.lng(current_lang, "designation")%>:
                                    <input type="text" id="fctrynvl">
                                    <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('fctry', 'fctry')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                                </div>
                                <div>
                                    <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtfctry" onkeyup="filart1vl('tbfctry', this.value)" style="width: 240px;">
                                    <a href="#" style="font-size: 11px;" onclick="processar('fctry', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                    <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('fctry', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                    <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('fctry', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                                </div>  
                                <div id="dvrfctry">
                                    <table id="tbfctry" border="1">
                                        <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                            <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "group")%></th>
                                            <th><%=lang.lng(current_lang, "marked_rmv")%></th><th><%=lang.lng(current_lang, "removed")%></th>
                                            <th><%=lang.lng(current_lang, "removal")%></th>
                                        </tr>
                                    </table>
                                </div> 
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('fctry', 'b')" <%=dsbld%>>&lt;&lt; <%=lang.lng(current_lang, "previous")%></a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('fctry', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "next")%> &gt;&gt;</a>

                                <br><br>
                                <strong id="msttlid" style="font-size: 30px;"><%=lang.lng(current_lang, "tables_(total)")%></strong><br>
                                <input type="number" id="mstotal" value="<%=vls.ms_total()%>" min="2" max="50">
                                <button type="button" class="btn btn-primary" onclick="processar('mstotal', 'mstotal')"><%=lang.lng(current_lang, "edit")%></button><span style="font-size: 11px;"><%=lang.lng(current_lang, "minimum_number:_2,_maximum:_50")%></span>
                                <br><br><%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                            </div>    
                        </div>
                        <div class="divtbs" id="rlt" style="display: none; width: 100%; height: 340px;  background-color: #FAE5D3;">
                            <h1 style=" background-color: #D0ECE7;"><%=lang.lng(current_lang, "printing_of")%>:</h1>
                            &bull; <a href="#" onclick="impPDFs('g')" <%=dsbld%>><%=lang.lng(current_lang, "general(purchase/sales/expenses)")%></a>&gt;&gt;<a href="#" onclick="impPDFs('gg')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%></a><br><br>
                            &bull; <a href="#" onclick="impPDFs('ps')" <%=dsbld%>><%=lang.lng(current_lang, "purchases/sales")%></a>&gt;&gt;<a href="#" onclick="impPDFs('psg')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%></a>&gt;&gt;<a href="#" onclick="impPDFs('psg2')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%>2</a><br><br>
                            &bull; <a href="#" onclick="impPDFs('v')" <%=dsbld%>><%=lang.lng(current_lang, "sales")%></a>&gt;&gt;<a href="#" onclick="impPDFs('vg')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%></a>&gt;&gt;<a href="#" onclick="impPDFs('vg2')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%>2</a><br><br>
                            &bull; <a href="#" onclick="impPDFs('d')" <%=dsbld%>><%=lang.lng(current_lang, "expenses")%></a>&gt;&gt;<a href="#" onclick="impPDFs('dg')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%></a><br><br>
                            &bull; <a href="#" onclick="impPDFs('stck')" <%=dsbld%>><%=lang.lng(current_lang, "stock_by_product")%></a>&gt;&gt;<a href="#" onclick="impPDFs('stckc')" <%=dsbld%>><%=lang.lng(current_lang, "stock_by_code")%></a><br><br>
                            &bull; <a href="#" onclick="impPDFs('c')" <%=dsbld%>><%=lang.lng(current_lang, "purchases")%></a>&gt;&gt;<a href="#" onclick="impPDFs('cg')" <%=dsbld%>><%=lang.lng(current_lang, "grouped")%></a><br><br>
                            &bull; <a href="#" onclick="impPDFs('dpc')" <%=dsbld%>><%=lang.lng(current_lang, "deposits/debts_(customers)")%></a>&gt;&gt;<a href="#" onclick="impPDFs('dpv')" <%=dsbld%>><%=lang.lng(current_lang, "deposits/debts(amounts)")%></a><br>
                        </div>
                        <div class="divtbs" id="ms" style="display: none; width: 100%">
                            <div>                            
                                <a href="#" style="font-size: 11px;" onclick="startlookstate()" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>, 
                                <a href="#" style="font-size: 11px;" onclick="lasts_req_made()" <%=dsbld%>><%=lang.lng(current_lang, "see_&uacute;latest_orders")%></a>
                            </div>                         
                            <div id="dvrms">   
                                <div id="dvrmss" style=' width: 600px; float: left;'>

                                </div>
                                <div style=' width: 500px; float: right; height: 600px; font-size: 12px;'>
                                    <div style='border-radius: 16px; padding-top: 10px; padding-left: 4px; background-color: #85C1E9; height: 500px; overflow-y: scroll;'>
                                        <strong id = 'msnmbr' style='font-size: 26px; background-color: white;'></strong><br> 
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "add_article"), "nvc('pedidonv')", "/SGRB/img/newp.png", "id=\"btnPedAdcArt\"", "float: left;")%>
                                        <br>

                                        <div id="pedidonv" style="display: none; background-color: #D6EAF8;">
                                            <input type="radio" id="pedvrdo_art" name="pedvrdo_art" value="<%=lang.lng(current_lang, "article")%>" onclick="checkcpb('pedvrdo_art')" checked="checked"><label for="pedvrdo_art"><%=lang.lng(current_lang, "article")%></label>
                                            <input type="radio" id="pedvrdo_prod" name="pedvrdo_prod" value="Codigo do Produto" onclick="checkcpb('pedvrdo_prod')"><label for="pedvrdo_prod">Codigo do Produto</label>
                                            <input type="radio" id="pedvrdo_bar" name="pedvrdo_bar" value="<%=lang.lng(current_lang, "bar_code")%>" onclick="checkcpb('pedvrdo_bar')"><label for="pedvrdo_bar"><%=lang.lng(current_lang, "bar_code")%></label>
                                            <br>
                                            <table>
                                                <tr>
                                                    <td><%=lang.lng(current_lang, "article")%>:</td>
                                                    <td><input type='text' id='pedvend_art' list='lst_prod' onchange="getCodBarCode(this.value, 'pedv')" /></td>
                                                    <td><%=lang.lng(current_lang, "prod_code")%>:</td>
                                                    <td><input type='text' id='pedvend_pcod' list='lst_pcodbar'  style="width: 80px;"  disabled="disabled" /></td>
                                                </tr>
                                                <tr><td style="height: 6px;"></td></tr>
                                                <tr>                  
                                                    <td><%=lang.lng(current_lang, "bar_code")%>:</td>
                                                    <td><input type='text' id='pedvend_cbar' list='lst_pcodbar2'  style="width: 80px;"  disabled="disabled" />  </td>
                                                    <td><%=lang.lng(current_lang, "group")%>:</td>
                                                    <td><input type="text" id="pedvend_grp" disabled="disabled" ></td>
                                                </tr>
                                                <tr><td style="height: 6px;"></td></tr>
                                                <tr>
                                                    <td><%=lang.lng(current_lang, "type")%>:</td>
                                                    <td><input type="text" id="pedvend_tp" disabled="disabled" ></td>
                                                    <td><%=lang.lng(current_lang, "category")%>:</td>
                                                    <td><input type="text" id="pedvend_cat" disabled="disabled" ></td>
                                                </tr>
                                                <tr><td style="height: 6px;"></td></tr>
                                                <tr>
                                                    <td><%=lang.lng(current_lang, "the_amount")%>:</td>
                                                    <td>
                                                        <input type="number" id="pedvend_quant" onchange="processar('vpr2', 'vpr2')" onkeyup="processar('vpr2', 'vpr2')" style="width: 60px;" min="1" max="9999">
                                                    </td>
                                                    <td><%=lang.lng(current_lang, "price")%>:</td>
                                                    <td>
                                                        <input type="decimal" disabled="disabled" id="pedvend_prc" value="0.00" style="width: 80px;" >
                                                    </td>
                                                </tr>
                                                <tr><td style="height: 6px;"></td></tr>
                                                <tr>
                                                    <td>
                                                        <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "pedvendary()", "/SGRB/img/insertptb.png", "", "float: right;")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br>                        <span id="pedtbdvrvsum" style="padding-left: 10px; font-size: 28px;"></span><br>                          <div id="dvrpedartins">
                                            <table border="1" id='dvrpedartins2' style='font-size: 11px;'>
                                                <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                                    <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "group")%></th>
                                                    <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                                    <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                                    <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                                    <th><%=lang.lng(current_lang, "price")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                                    <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                                </tr>
                                            </table>
                                        </div>
                                        <br>
                                        <%=vls.dinmcbtn(lang.lng(current_lang, "request_payment"), "processar('rqpyt', 'rqpyt')", "/SGRB/img/insertp4.png", "id=\"btnpdrpag\"", "float: left;")%>
                                        <br>
                                        <br><br>
                                        <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprdpedvendas" style="width: 240px;">
                                        <input type="button" onclick="filart('lstprdpedvendas', document.getElementById('txtprdpedvendas').value)" value="Procurar">
                                        <a href="#" style="font-size: 11px;" onclick="processar('lstprdpedvendas', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a> 
                                        <a href="#" style="font-size: 11px;" onclick="gnrArtImg('lstprdpedvendas')" <%=dsbld%>><%=lang.lng(current_lang, "images")%></a> 
                                        <br>
                                        <div id="dvlstprdpedvendas" style="height: 360px; color: white;">
                                            <%=vls.list_prod_ctgry("lstprdpedvendas", sector, "a")%>
                                        </div>
                                    </div>
                                </div>                                         
                            </div>                                             
                        </div>
                        <div class="divtbs" id="mn" style="display: block; width: 100%">
                            <table border="1" id="tblmn" class="center" style="width: 800px;">
                                <tr>
                                    <td id="tblmn1" style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('ms')" style="text-decoration: none;">
                                            <img src="/SGRB/img/req.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "requests")%>">
                                        </a>
                                    </td>
                                    <td id="tblmn2" style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="stvalc('v'), chstb('vnds')" style="text-decoration: none;">
                                            <img src="/SGRB/img/sale2.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "sales")%>">
                                        </a>
                                    </td>
                                    <td id="tblmn3" style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('cmps')" style="text-decoration: none; border-color: #BFC9CA;">
                                            <img src="/SGRB/img/purchases2.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "purchases")%>">
                                        </a>
                                    </td>
                                    <td id="tblmn4" style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('dshb')" style="text-decoration: none;">
                                            <img src="/SGRB/img/dashboards.png" style="width: 160px; height: 160px;" title="Dashboard"> 
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('bckr')" style="text-decoration: none;">
                                            <img src="/SGRB/img/bkcp.png" style="width: 160px; height: 160px;" title="Backup/<%=lang.lng(current_lang, "restoration")%>">   
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('dsps')" style="text-decoration: none;">
                                            <img src="/SGRB/img/despesas.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "expenses")%>">
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('gst')" style="text-decoration: none;">
                                            <img src="/SGRB/img/gestao.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "management")%>">
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('rlt')" style="text-decoration: none;">
                                            <img src="/SGRB/img/reports2.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "reports")%>">    
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('vndr')" style="text-decoration: none;">
                                            <img src="/SGRB/img/vendasanteriores.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "past_sales")%>">
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('hlpdsk')" style="text-decoration: none;">
                                            <img src="/SGRB/img/helpdesk.png" style="width: 160px; height: 160px;" title="HelpDesk">   
                                        </a>
                                    </td>    
                                </tr>
                                <tr>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('prdest')" style="text-decoration: none;">
                                            <img src="/SGRB/img/stocks.png" style="width: 160px; height: 160px;" title="Stock">
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('dpst')" style="text-decoration: none;">
                                            <img src="/SGRB/img/depositos.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "deposits/debts")%>">
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="stvalc('a'), chstb('vnds')" style="text-decoration: none;">
                                            <img src="/SGRB/img/stock.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "allocations")%>">   
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('ttrl')" style="text-decoration: none;">
                                            <img src="/SGRB/img/manual.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "manual")%>">   
                                        </a>
                                    </td>
                                    <td style="width: 20%; height: 180px; background-color: #EAF2F8; border-color: #BFC9CA;">
                                        <a href="#" onclick="chstb('snos')" style="text-decoration: none;">
                                            <img src="/SGRB/img/web.png" style="width: 160px; height: 160px;" title="<%=lang.lng(current_lang, "about_us")%>">   
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="divtbs" id="vndr" style="display: none; width: 100%">
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "past_sales")%></strong><br>
                            <span id="tbdvrvasum" style="padding-left: 360px; font-size: 28px;"></span><br>
                            <div>
                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtprcartva" style="width: 300px;">
                                <input type="button" onclick="filbyclnsnr('tbdvrva', document.getElementById('txtprcartva').value, 2, 3, 8, 'va')" value="<%=lang.lng(current_lang, "search")%>">
                                <a href="#" style="font-size: 11px;" onclick="processar('va', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                                <!--
                                <a href="#" style="font-size: 11px;" onclick="rnfb('f'), processar('va', 'b')" <%/*=dsbld*/%>>&lt;&lt; Anterior</a>
                                <a href="#" style="font-size: 11px;" onclick="rnfb('b'), processar('va', 'b')" <%/*=dsbld*/%>>Pr&oacute;ximo &gt;&gt;</a>
                                -->
                            </div> 
                            <div id="dvrva">                            
                                <table border="1" id="tbdvrva">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrva', 0)"><%=lang.lng(current_lang, "order")%></a></th>
                                        <th><a href="#" style="text-decoration: none;" onclick="sortTable('tbdvrva', 1)"><%=lang.lng(current_lang, "group")%></a></th>
                                        <th><%=lang.lng(current_lang, "prod_code")%></th><th><%=lang.lng(current_lang, "bar_code")%></th>
                                        <th><%=lang.lng(current_lang, "sale")%></th><th><%=lang.lng(current_lang, "client")%></th>
                                        <th><%=lang.lng(current_lang, "type")%></th><th><%=lang.lng(current_lang, "category")%></th>
                                        <th><%=lang.lng(current_lang, "article")%></th><th><%=lang.lng(current_lang, "the_amount")%></th>
                                        <th><%=lang.lng(current_lang, "price")%></th>
                                        <th style="background-color: greenyellow;" title="<%=lang.lng(current_lang, "profit_st")%> = <%=vls.frml_past_sales_profit()%>"><%=lang.lng(current_lang, "profit_st")%></th>
                                        <th><%=lang.lng(current_lang, "status")%></th>
                                        <th><div style="width: 160px;"><%=lang.lng(current_lang, "registration_date")%></div></th>
                                        <th><%=lang.lng(current_lang, "user")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                        <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                    </tr>
                                </table>   
                            </div>                                
                            <br><br><%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                        </div>
                        <div class="divtbs" id="bckr" style="display: none; width: 100%">     
                            <strong style="font-size: 30px;">Backup/Restore</strong><br><br>
                            <%=lang.lng(current_lang, "click")%> <a href="#" onclick="processar('lnkdwn','lnkdwn')" style="text-decoration: none;"><%=lang.lng(current_lang, "here")%></a> para <strong>gerar backup</strong><br>
                            <span id="lnkdwnld"></span><br>
                            <%=lang.lng(current_lang, "click")%> <a href="#" onclick="callUpldPg()" style="text-decoration: none;"><%=lang.lng(current_lang, "here")%></a> <%=lang.lng(current_lang, "for")%> 
                            <strong><%=lang.lng(current_lang, "restore_database")%>*</strong><br><br>
                            <br><br>
                            *<span style="font-size: 11px;"><%=lang.lng(current_lang, "the_database_will_be&aacute;_only_restored_if_done")%>!</span>
                        </div>
                        <div class="divtbs" id="hlpdsk" style="display: none; width: 100%">  
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "help_or_report_bug")%></strong><br>
                            <%=lang.lng(current_lang, "customer_id")%>: <input type="text" id="hlpid"> <%=lang.lng(current_lang, "name")%>: <input type="text" id="hlpnm"><br>
                            <%=lang.lng(current_lang, "content")%>:<br>
                            <textarea id="hlptxt" rows="10" cols="80">
                                 
                            </textarea><br>
                            <input type="button" id="btnhelpdesk" value="<%=lang.lng(current_lang, "submit")%>">
                        </div>    
                        <div class="divtbs" id="snos" style="display: none; width: 100%">   
                            <strong style="font-size: 30px;"><%=lang.lng(current_lang, "about_us")%></strong><br>
                            <span style="font-size: 11px;"><%=lang.lng(current_lang, "this_page_only_works_with_internet")%>!</span><br>
                            <div id="dvsnos" style="width: 100%; height: 80%;">
                                <object type="text/html" data="http://amoraservices.org/" width="800px" height="700px" style="overflow:auto;border:2px blue">
                                </object>
                            </div>
                        </div>    
                        <div class="divtbs" id="prdest" style="display: none; width: 100%">
                            <strong style="font-size: 30px;">Stock</strong><br><br>
                            <span style="font-size: 12px;"><%=lang.lng(current_lang, "if_the_article_has_been_written_more_than_once")%></span><br>
                            <div>
                                <%=lang.lng(current_lang, "article")%>:<input type="text" id="txtdvrestb" onkeyup="filart('dvrestb', this.value)" style="width: 240px;">
                                <a href="#" style="font-size: 11px;" onclick="processar('est', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                            </div> 
                            <div id="dvrest">
                                <%=vls.list_prod_ctgry("dvrestb", sector, "est")%>
                                <!--<table border="1" id="dvrestb">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th>Categoria</th><th>Grupo</th><th>Artigo</th><th>Pre&ccedil;o</th><th>Stock</th><th>Prod C&oacute;digo</th><th>C&oacute;digo de Barra</th><th>Compras</th><th>Vendas</th>
                                    </tr>
                                </table>-->  
                            </div> 
                            <div style="width: 100%;">
                                <%=vls.stock_aloc()%>
                            </div>    
                            <br><br><%=vls.dinmcbtn(lang.lng(current_lang, "go_to_top"), "window.scrollTo(0, 0);", "/SGRB/img/gotop.png", "id=\"btnGoTop\"", "")%>
                        </div>

                        <div class="divtbs" id="ttrl" style="display: none; width: 100%">
                            <div>
                                <object data="ManualUSUARIOSGRB.pdf" type="application/pdf" width="1130" height="900">
                                    <a href="ManualUSUARIOSGRB.pdf"><%=lang.lng(current_lang, "manual")%></a>
                                </object>
                            </div>                 
                        </div>       
                        <div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="cmplstprd" style="position: absolute; top: 1px; z-index: 20; width: 460px; display: none; background-color: #E9F7EF; border: 1px solid gray;">
                <table style="width: 100%;">
                    <tr>
                        <td><a href="#" style="font-size: 11px; float: right;" onclick="clsplst()" ><%=lang.lng(current_lang, "close")%></a></td>
                    </tr>
                    <tr>
                        <td id="lstprdart" style="font-size: 28px; background-color: #D7BDE2;"></td>
                    </tr>
                    <tr>
                        <td>
                            <%=vls.dinmcbtn(lang.lng(current_lang, "new"), "nvc('lstpart')", "/SGRB/img/newp.png", "id=\"btnlstpart\"", "float: left;")%>
                            <br>
                            <div id="lstpart" style="display: none; background-color: #D6EAF8; padding: 12px;">
                                <%=lang.lng(current_lang, "product")%>: 
                                <input type='text' id='produtolstart' list='lst_prod' />
                                <%=lang.lng(current_lang, "the_amount")%>: <input type="number" id="quantidadelstart" style="width: 60px;" min="1" max="9999">
                                <%=vls.dinmcbtn(lang.lng(current_lang, "insert"), "processar('g', 'artplst')", "/SGRB/img/insertp4.png", "", "float: right;")%>
                            </div>
                            <div>
                                <a href="#" style="font-size: 11px;" onclick="processar('aqp', 'b')" <%=dsbld%>><%=lang.lng(current_lang, "refresh")%></a>
                            </div> 
                            <div id="dvraqp">
                                <table border="1">
                                    <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">
                                        <th><%=lang.lng(current_lang, "order")%></th><th><%=lang.lng(current_lang, "product")%></th>
                                        <th><%=lang.lng(current_lang, "the_amount")%></th><th><%=lang.lng(current_lang, "marked_rmv")%></th>
                                        <th><%=lang.lng(current_lang, "removed")%></th><th><%=lang.lng(current_lang, "removal")%></th>
                                    </tr>
                                </table>   
                            </div>     
                        </td>
                    </tr>
                </table>

            </div> 
            <datalist id='lst_prod'>
                <option></option>
                <%=vls.productslst()%>
            </datalist> 
            <datalist id='lst_prod2'>
                <option></option>
                <%=vls.productslst2()%>
            </datalist>   
            <datalist id='lst_pcodbar'>
            </datalist>	

            <datalist id='lst_pcodbar2'>
            </datalist> 
            <div style="position: fixed; bottom: 2px; right: 2px;">
                <span style="font-size: 12px; background-color: white; color: black; padding-right: 10px;"><%=lang.lng(current_lang, "version")%>: <%=cssn.versionapp()%></span><span style="color: blue; background-color: #E67E22;">Powered by: </span><a href="http://www.amoraservices.org" style="text-decoration: none; color: white; background-color: #E67E22; color: white;"><strong>Amora</strong> Software & Services</a>
            </div>
        </div>
        <div id="dvprcssr" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: #EBF5FB; text-align: center;">
            <span id="closeprocessstatus" style="position: absolute; top: 46%;"><%=lang.lng(current_lang, "processing...")%></span>
        </div>
        <div id="dvgnrartimg" style="position: absolute; top: 0px; left: 0px; display: none; z-index: 100; width: 100%; height: 100%; background-color: white; text-align: center;">
            <a href="#" onclick="clsdvgnrartimg()" style="float: right; top: 1px;"><%=lang.lng(current_lang, "close")%></a><br>
        </div>    
        <script>
function readFile(){if(this.files&&this.files[0]){var a=new FileReader;a.addEventListener("load",function(c){document.getElementById("lgimg").src=c.target.result;lgtostr=""+c.target.result});a.readAsDataURL(this.files[0])}}document.getElementById("fllogt").addEventListener("change",readFile);try{document.getElementById("tblmn").style.width=""+gscrsz+"px"}catch(a){}
function addEvntforCodeInptV(){kyvpcod.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kyvpcod.value,"v"),kypcod.disabled=!0)});kyvcbar.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kyvcbar.value,"v"),kyvcbar.disabled=!0)})}
function addEvntforCodeInptPedV(){kypedvpcod.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kypedvpcod.value,"pedv"),kypedvpcod.disabled=!0)});kypedvcbar.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kypedvcbar.value,"pedv"),kypedvcbar.disabled=!0)})}
function addEvntforCodeInptC(){kycomcod.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kycomcod.value,"c"),kycomcod.disabled=!0)});kycomcbar.addEventListener("keyup",function(a){13===a.keyCode&&(a.preventDefault(),getCodBarCode(kycomcbar.value,"c"),kycomcbar.disabled=!0)})}hvp=document.getElementById("dvrgvp").innerHTML;hus=document.getElementById("dvrgu").innerHTML;hds=document.getElementById("dvrd").innerHTML;hcm=document.getElementById("dvrc").innerHTML;
hcmi=document.getElementById("dvrci").innerHTML;hva=document.getElementById("dvrva").innerHTML;artqp=document.getElementById("dvraqp").innerHTML;plst=document.getElementById("dvrprodl").innerHTML;estp=document.getElementById("dvrest").innerHTML;fcty=document.getElementById("dvrfctry").innerHTML;hdpst=document.getElementById("dvrdpst").innerHTML;
hva2='                            <table border="1" id="dvrpedartins2" style=\'font-size: 11px;\'>\n                                <tr style="height: 46px; background-color:  #9B00FF;background: linear-gradient(to bottom, #9B00FF, white);">\n                                    <th>'+tblorder+"</th><th>"+tblgroup+"</th><th>"+tblcodprod+"</th><th>"+tblbarcode+"</th><th>"+tbltipo+"</th><th>"+tblcategory+"</th><th>"+tblarticle+"</th><th>"+tblquant+"</th><th>"+tblprice+"</th><th>"+tblmarkrmv+"</th><th>"+
tblrmved+"</th><th>"+tblrmvl+"</th>\n                                </tr>\n                            </table>\n";
function vndart(a,c){var d="<select id='"+("vart"===c?"vend_art":"pedvend_art")+'\' onchange="getCodBarCode(this.value, \'pedv\')"><option value="NA" >NA</option>';a=a.split(",");try{for(i=0;800>i;i++)null!==a[i]&&""!==a&&"undefined"!==a[i]&&"undefined"!==typeof a[i]&&(d+='<option value="'+a[i]+'" >'+a[i]+"</option>")}catch(b){}"vart"===c?document.getElementById("vend_art2").innerHTML=""+d+"</select>":document.getElementById("pedvend_art2").innerHTML=""+d+"</select>"}
function rollToTop(){try{document.body.scrollTop=0}catch(a){}try{document.documentElement.scrollTop=0}catch(a){}}function sortTable(a,c){var d,b;a=document.getElementById(a);for(d=!0;d;){d=!1;var e=a.rows;for(b=1;b<e.length-1;b++){var f=!1;var g=e[b].getElementsByTagName("TD")[c];var h=e[b+1].getElementsByTagName("TD")[c];if(g.innerHTML.toLowerCase()>h.innerHTML.toLowerCase()){f=!0;break}}f&&(e[b].parentNode.insertBefore(e[b+1],e[b]),d=!0)}}
var kyvpcod=document.getElementById("vend_pcod"),kyvcbar=document.getElementById("vend_cbar"),kypedvpcod=document.getElementById("pedvend_pcod"),kypedvcbar=document.getElementById("pedvend_cbar"),kycomcod=document.getElementById("comp_pcod"),kycomcbar=document.getElementById("comp_cbar");
"g"===cfusr&&(setTimeout(function(){chstb("gst");document.getElementById("dvrst").style.display="block";document.getElementById("dvrst").innerHTML="<span style='color: green;'>Processado com sucesso!</span>"},500),"a"===cfusr);


        </script>
        <%
        if (dsbld4.equalsIgnoreCase("disabled")) {
                try{
                    session.invalidate(); 
                } catch (Exception e) {}        
        }
        } else {
          String mtv = Lb.getMotivo();
        %>
        <script>
            location.replace("/SGRB/Login.jsp?er=y&m=<%=mtv%>");
        </script>    
        <%
            }
        %>
    </body>
</html>
