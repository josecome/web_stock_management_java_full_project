package a;

import ed.encr;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.*;
import java.sql.*;
import java.text.Format;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class aw {

    private Connection con = null;
    private Statement stmt = null;
    private StringBuffer retorno = new StringBuffer("aaa");
    private String tblins = "";
    private String prvls = "z";
    private String mss = "";
    private String a = "";
    private String id4 = "";
    private String sector = "";
    private int user_register = 0;
    private String ctgry_usr = "a";
    private String updprcs = "";
    Transformations trnsf = new Transformations();
    private String[] artavailb = new String[2];
    client_session cssn = new client_session();
    language lang;
    String current_lang = "";
    PreferedLang plng; 
    Values vls;
    encr ec;

    public aw(javax.servlet.http.HttpServletRequest request) throws UnknownHostException, IOException {
        a = request.getParameter("acao");
        mss = request.getParameter("m");
        id4 = request.getParameter("id4");
        sector = request.getParameter("sector");
        vls = new Values();
        String[] vlspid = cssn.prvls(request.getParameter("user"));
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
        prvls = vlspid[0];
        ctgry_usr = vlspid[2];
        ec = new encr();
        String completefield = " " + lang.lng(current_lang, "complete");
        if (request.getParameter("prp") == null || request.getParameter("user").trim().length() == 0) {
        } else if (request.getParameter("prp").equalsIgnoreCase("s")) {
            prvls = prvls + "ui";
        }
        //System.out.println("===" + a);
        try {
            user_register = Integer.parseInt(vlspid[1]);
        } catch (NumberFormatException e) {
            user_register = 0;
        }
        String s = "";
        String vldr = "";
        if (a == null) {
        } else if(a.equalsIgnoreCase("lng")){
            String lng = request.getParameter("lng");
            retorno = new StringBuffer(cssn.setPreferedLang(lng));
            return;
        } else if(a.equalsIgnoreCase("unlckscrn")){
            String Usr = request.getParameter("user");
            String snh = request.getParameter("s");
            lb Lb = new lb(Usr, snh, "", "no");
            String statusyn = Lb.getStatusYesNo();
            //System.out.println("'" + statusyn + "'");
            retorno = new StringBuffer(statusyn);
            return;
        } else if (a.equalsIgnoreCase("u")) {/*Inserir novo usuario*/
            String username = request.getParameter("usu");
            String firstnames = request.getParameter("usn");
            String surnames = request.getParameter("usa");
            String roles = request.getParameter("usp");
            String cat = request.getParameter("usc");
            if (username == null || username.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "name");
            }
            if (firstnames == null || firstnames.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "first_names");
            }
            if (surnames == null || surnames.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "surname");
            }
            if (roles == null || roles.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "privileges");
            }
            tblins = "users";
            s = "insert into users (username,firstnames,surnames,status,roles,category,entrydatetime,user_register,password) values ('" + username + "','" + firstnames + "','" + surnames + "',2,'" + roles + "','" + cat + "',NOW()," + user_register + ",'" + ec.enc("abcdefghij") + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("stplc")) {
            String m = request.getParameter("m");

            String m1 = "";
            String m2 = "";
            try {
                String mm = m.split("::::")[0];
                m1 = mm;
            } catch (Exception e) {
            }
            try {
                String mm = m.split("::::")[1];
                m2 = mm;
            } catch (Exception e) {
            }
            if (m1 == null || m1.trim().length() < 4) {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred:_exit_and_re-enter_to_process_the_request") + "!</span>");
                return;
            }
            tblins = "ms_requests";
            s = "insert into ms_requests (cliente,sector,msname_us_time,plc_state,user_datetime,iduser) "
                    + " values ('" + m2 + "','" + sector + "','" + m1 + "',1,NOW()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("lnkdwn")) {
            //System.out.println("t1: " + prvls);
            if (prvls.contains("o")) {
                DownloadDB db = new DownloadDB();
                retorno = new StringBuffer(db.DwnRrtn());
            } else {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_enough_privileges_to_manage_and_download_backup") + "!</span>");
            }
            return;
        } else if (a.equalsIgnoreCase("artplst")) {
            String prod = request.getParameter("prod");
            String quant = request.getParameter("quant");
            String art = request.getParameter("art");
            int quantt = 0;
            try {
                int j = Integer.parseInt(quant);
                quantt = j;
            } catch (Exception e) {
                vldr = completefield + lang.lng(current_lang, "the_amount");
            }
            if (prod == null || prod.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "product");
            }
            if (quant == null || quant.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "the_amount");
            }
            tblins = "used_products";
            s = "insert into used_products (sector,article,product,quantity,user_datetime,iduser) values ('" + sector + "','" + art + "','" + prod + "'," + quantt + ",NOW()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("prodl")) {
            String prod = request.getParameter("prod");
            if (prod == null || prod.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "product");
            }
            if(vls.ExistGroupProducts("prodl", vls.rmvSpcChar(prod))){
              retorno = new StringBuffer(lang.lng(current_lang, "the_product_already_exists"));
              return;
            }
            tblins = "products_purchases";
            s = "insert into products_purchases (sector,product,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + vls.rmvSpcChar(prod) + "',0,0,NOW()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("fctry")) {
            String fc = request.getParameter("fc");
            if (fc == null || fc.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "group");
            }
            if(vls.ExistGroupProducts("fctry", vls.rmvSpcChar(fc))){
              retorno = new StringBuffer(lang.lng(current_lang, "the_group_already_exists"));
              return;
            }
            tblins = "groups_factories";
            s = "insert into groups_factories (sector,factory,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + vls.rmvSpcChar(fc) + "',0,0,NOW()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("mstotal")) {
            String mstl = request.getParameter("mstl");
            if (mstl == null || mstl.trim().length() == 0) {
                vldr = " Coloque um numero";
            }
            tblins = "ms";
            s = "insert into ms (sector,total,user_datetime,iduser) values ('" + sector + "','" + mstl + "',NOW()," + user_register + ")";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("stkalc")) {
            String m = request.getParameter("m");
            if (m == null || m.trim().length() < 2) {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "no_data") + "!</span>");
                return;
            }
            String[] mm = m.split(":");
            String m1 = mm[0];
            String m2 = mm[1];
            s = "update sales set aloc_stck_used = '" + m2 + "', aloc_stck_used_user_rg = " + user_register + " where id = " + m1;
            retorno = new StringBuffer(updateothrs(s, prvls));
        } else if (a.equalsIgnoreCase("vp")) {/*Inserir nova vendapreco*/
            String vpa = request.getParameter("vpa");
            String vpq = request.getParameter("vpq");
            String vpt = request.getParameter("vpt");
            String vpc = request.getParameter("vpc");
            String vpp = request.getParameter("vpp");
            String vpg = request.getParameter("vpg");
            String vpcod = request.getParameter("vpcod");
            String vpcbar = request.getParameter("vpcbar");
            if (vpcod == null || vpcod.trim().length() < 2 || vpcod.equalsIgnoreCase("null")) {
                vldr = completefield + lang.lng(current_lang, "prod code");
            }
            if (vpcbar == null || vpcbar.trim().length() < 2 || vpcbar.equalsIgnoreCase("null")) {
                vldr = completefield + lang.lng(current_lang, "barcode");
            }

            if (vpa == null || vpa.trim().length() == 0 || vpa.equalsIgnoreCase("NA") || vpa.equalsIgnoreCase("null")) {
                vldr = completefield + lang.lng(current_lang, "article");
            }
            if (vpq == null || vpq.trim().length() == 0) {// || !vls.isNmbr(vpq)
                vldr = completefield + lang.lng(current_lang, "amount");
            }
            if (vpt == null || vpt.trim().length() == 0 || vpt.equalsIgnoreCase("NA") || vpt.equalsIgnoreCase("null")) {
                vldr = completefield + lang.lng(current_lang, "type");
            }
            if (vpc == null || vpc.trim().length() == 0 || vpc.equalsIgnoreCase("NA") || vpc.equalsIgnoreCase("null")) {
                vldr = completefield + lang.lng(current_lang, "category");
            }
            if (vpp == null || vpp.trim().length() == 0 || vpp.equalsIgnoreCase("0.00")) {
                vldr = completefield + lang.lng(current_lang, "price");
            }
            String vp_price = trnsf.NumberToDecimal(request.getParameter("vpp"));
            tblins = "prices_sales";
            s = "insert into prices_sales (sector,group_factory,p_code,barcode,product,quantity,prod_type,category,price,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + request.getParameter("vpg") + "','" + vls.rmvSpcChar(request.getParameter("vpcod")) + "','" + vls.rmvSpcChar(request.getParameter("vpcbar")) + "','" + vls.rmvSpcChar(request.getParameter("vpa")) + "','" + request.getParameter("vpq") + "','" + request.getParameter("vpt") + "','" + request.getParameter("vpc") + "','" + vp_price + "',0,0,NOW(),'" + user_register + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("dpst")) {
            String c = request.getParameter("c");
            String r = request.getParameter("r");
            String i = request.getParameter("i");
            String p = request.getParameter("p");
            String o = request.getParameter("o");
            String ld = request.getParameter("ld");
            String lv = request.getParameter("lv");
            if (c == null || c.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "client_name");
            }
            if (r == null || r.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "place_of_residence");
            }

            if (i == null || i.trim().length() == 0) {
                i = "_";
            }
            if (p == null || p.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "telephone");
            }
            if (o == null || o.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "observation");
            }
            tblins = "deposits";
            s = "insert into deposits (sector,clientname,residenty,id_number,phone,observation,last_doposit_date,total_payment,total_used,user_datetime,iduser) values ('" + sector + "','" + c + "','" + r + "','" + i + "','" + p + "','" + o + "',NOW(),0.00,0.00,NOW(),'" + user_register + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("d")) {/*Inserir novas despesas*/
            String dst = request.getParameter("dst");
            String dsv = request.getParameter("dsv");
            String dso = request.getParameter("dso");
            String dsd = request.getParameter("dsd");
            if (dst == null || dst.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "type");
            }
            if (dsv == null || dsv.trim().length() == 0 || dsv.equalsIgnoreCase("0.00")) {
                vldr = completefield + lang.lng(current_lang, "value");
            }
            if (dso == null || dso.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "observation");
            }
            if (dsd == null || dsd.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "date_of_expense");
            }
            dsv = trnsf.NumberToDecimal(dsv);
            tblins = "expenses";
            s = "insert into expenses (sector,prod_type,price,observation,expense_date,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + request.getParameter("dst") + "','" + dsv + "','" + request.getParameter("dso") + "','" + request.getParameter("dsd") + "',0,0,NOW(),'" + user_register + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("pedartins")) {
            String tp = request.getParameter("vt");
            String ct = request.getParameter("vc");
            String ar = request.getParameter("va");
            String qt = request.getParameter("vq");
            String pr = request.getParameter("vp");
            String msn = request.getParameter("msn");
            String cod = request.getParameter("vcod");
            String cbar = request.getParameter("vcbar");
            String lstpurcqty = request.getParameter("lstpurcqty");
            if (msn == null || msn.trim().length() < 4) {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred:_exit_and_re-enter_to_process_the_request") + "!</span>");
                return;
            }
            tblins = "clients_requests";
            s = "insert into clients_requests  (sector,group_factory,p_code,barcode,prod_type,category,article,quantity,price,lastqnty,marked_rmv,removed,user_datetime,iduser,msname_us_time) values ('" + sector + "','" + tp + "','" + cod + "','" + cbar + "','" + tp + "','" + ct + "','" + ar + "','" + qt + "','" + pr + "','" + lstpurcqty + "',0,0,NOW(),'" + user_register + "','" + msn + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("rqpyt")) {
            String id = request.getParameter("m");
            tblins = "ms_requests";
            s = "update ms_requests set plc_state = 2 where msname_us_time = '" + id + "' and sector = '" + sector + "'";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("c")) {/*Inserir novas compras  purchases_not_used*/
            String cmt = request.getParameter("cmt");
            String cmc = request.getParameter("cmc");
            String cma = request.getParameter("cma");
            String cmq = request.getParameter("cmq");
            String cmp = request.getParameter("cmp");
            String cmpcod = request.getParameter("cmpcod");
            String cmcbar = request.getParameter("cmcbar");
            String comp_prz = request.getParameter("comp_prz");
            String comp_lot = request.getParameter("comp_lot");
            if (comp_lot == null || comp_lot.trim().length() == 0) {
                comp_lot = "NA";
            }
            if (cmpcod == null || cmpcod.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "prod code");
            }
            if (cmcbar == null || cmcbar.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "barcode");
            }
            if (cmt == null || cmt.trim().length() == 0 || cmt.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "type");
            }
            if (cmc == null || cmc.trim().length() == 0 || cmc.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "category");
            }
            if (cma == null || cma.trim().length() == 0 || cma.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "article");
            }
            if (cmq == null || cmq.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "amount");
            }
            if (cmp == null || cmp.trim().length() == 0 || cmp.equalsIgnoreCase("0.00")) {
                vldr = completefield + lang.lng(current_lang, "price");
            }
            String prazoprod = "";
            if (comp_prz == null || comp_prz.trim().length() == 0) {
                prazoprod = "2100-12-30";
            } else {
                prazoprod = "'" + request.getParameter("comp_prz") + "'";
            }
            cmp = trnsf.NumberToDecimal(cmp);
            tblins = "purchases";
            s = "insert into purchases (sector,group_factory,p_code,barcode,prod_type,category,article,quantity,price,price_other,price_cntry,comp_prz,lot_art,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + request.getParameter("cmpcod") + "','" + request.getParameter("cmcbar") + "','" + request.getParameter("cmg") + "','" + request.getParameter("cmt") + "','" + request.getParameter("cmc") + "','" + request.getParameter("cma") + "','" + request.getParameter("cmq") + "','" + cmp + "','" + request.getParameter("comp_oprec") + "','" + request.getParameter("comp_oprectp") + "'," + prazoprod + ",'" + comp_lot + "',0,0,NOW(),'" + user_register + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
            //System.out.println(s);
        } else if (a.equalsIgnoreCase("ci")) {
            String cmt = request.getParameter("cmt");
            String cmc = request.getParameter("cmc");
            String cma = request.getParameter("cma");
            String cmq = request.getParameter("cmq");
            String cmp = request.getParameter("cmp");

            String cmpcod = request.getParameter("cmpcod");
            String cmcbar = request.getParameter("cmcbar");
            String pcsartcnt = request.getParameter("pcsartcnt");

            if (cmpcod == null || cmpcod.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "prod code");
            }
            if (cmcbar == null || cmcbar.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "barcode");
            }
            if (cmt == null || cmt.trim().length() == 0 || cmt.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "type");
            }
            if (cmc == null || cmc.trim().length() == 0 || cmc.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "category");
            }
            if (cma == null || cma.trim().length() == 0 || cma.equalsIgnoreCase("NA")) {
                vldr = completefield + lang.lng(current_lang, "article");
            }
            if (cmq == null || cmq.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "amount");
            }
            if (cmp == null || cmp.trim().length() == 0 || cmp.equalsIgnoreCase("0.00")) {
                /*vldr = " Prencher Preco";*/
            }
            String[] arypcart = pcsartcnt.split(";");
            String arypcart0 = arypcart[0];
            String arypcart1 = arypcart[1];
            if (arypcart0 == null || arypcart0.trim().length() == 0) {
                arypcart0 = "0";
            }
            if (arypcart1 == null || arypcart1.trim().length() == 0) {
                arypcart1 = "0";
            }
            updprcs += "update purchases set quant_saled = quant_saled + " + cmq + " where id = " + arypcart0;
            tblins = "purchases_not_used";
            s = "insert into purchases_not_used (sector,group_factory,p_code,barcode,prod_type,category,article,quantity,price,marked_rmv,removed,user_datetime,iduser) values ('" + sector + "','" + request.getParameter("cmpcod") + "','" + request.getParameter("cmcbar") + "','" + request.getParameter("cmg") + "','" + request.getParameter("cmt") + "','" + request.getParameter("cmc") + "','" + request.getParameter("cma") + "','" + request.getParameter("cmq") + "','" + request.getParameter("cmp") + "',0,0,NOW(),'" + user_register + "')";
            retorno = new StringBuffer(insert(s, "b", vldr, prvls));
        } else if (a.equalsIgnoreCase("orgdt")) {
            String dg = request.getParameter("dg");
            String lg = request.getParameter("lg");
            String lc = request.getParameter("lc");
            String lnk_download = request.getParameter("lnk_download");
            if (dg == null || dg.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "designation");
            }
            if (lg == null || lg.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "logo");
            }
            if (lc == null || lc.trim().length() == 0) {
                vldr = completefield + lang.lng(current_lang, "location");
            }
            if (lnk_download == null || lnk_download.trim().length() == 0) {
                lnk_download = "localhost";
            }
            //cdg=" + vldg + "&clc=" + vlc + "&clg
            String cdg = request.getParameter("cdg");
            String clc = request.getParameter("clc");
            String clg = request.getParameter("clg");

            if (vldr == null || vldr.trim().length() == 0) {
                retorno = new StringBuffer(vls.insert_replace_desiglogloc(dg, lg, lc, cdg, clg, clc, lnk_download, user_register));
                return;
            } else {
                retorno = new StringBuffer(vldr);
                return;
            }
        } else if (a.equalsIgnoreCase("v")) {/*Inserir novas vendas*/
            boolean g = false;
            try {
                for (String d : request.getParameter("rgvn").split(":")) {
                    if (d == null || d.trim().length() < 6 || d.equalsIgnoreCase("NA")) {

                    } else {
                        String assclnt = request.getParameter("assclnt");
                        if(assclnt == null || assclnt.trim().length() == 0){
                           assclnt = "NA";
                        }
                        String[] c = d.split(",");
                        String grp = c[1].split("=")[1];
                        String pcod = c[2].split("=")[1];
                        String pcbar = c[3].split("=")[1];
                        String tp = c[4].split("=")[1];
                        String ct = c[5].split("=")[1];
                        String ar = c[6].split("=")[1];
                        String qt = c[7].split("=")[1];
                        String pr = c[8].split("=")[1];
                        String clt = c[9].split("=")[1];
                        String cnm = c[10].split("=")[1];
                        String pcsartcnt = c[11].split("=")[1];
                        String[] arypcart = pcsartcnt.split(";");
                        String arypcart0 = arypcart[0];
                        String arypcart1 = arypcart[1];
                        if (arypcart0 == null || arypcart0.trim().length() == 0) {
                            arypcart0 = "0";
                        }
                        if (arypcart1 == null || arypcart1.trim().length() == 0) {
                            arypcart1 = "0";
                        }
                        String aloc_stck = "";
                        try {
                            String alocstck = c[12].split("=")[1];
                            aloc_stck = alocstck;
                        } catch (Exception e) {
                            aloc_stck = "";
                        }
                        String slsalc = "";
                        try {
                            String slsalck = c[13].split("=")[1];
                            slsalc = slsalck;
                        } catch (Exception e) {
                            slsalc = "";
                        }
                        if (slsalc == null || slsalc.trim().length() == 0) {
                            slsalc = "a";
                        }
                        if (slsalc.equalsIgnoreCase("c") && !prvls.contains("u")) {
                            retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_enough_privileges_to_allocate_article") + "!</span>");
                            return;
                        }
                        updprcs += "update purchases set quant_saled = quant_saled + " + qt + " where id = " + arypcart0 + ":";
                        //System.out.println("updprcs" + updprcs);
                        if (ar == null || ar.trim().length() == 0 || ar.equalsIgnoreCase("NA")) {
                            vldr = completefield + lang.lng(current_lang, "article");
                        }
                        if (ar == null || ar.trim().length() == 0 || ar.equalsIgnoreCase("NA")) {
                        } else if (ar.equalsIgnoreCase("Sem Venda")) {
                        } else {
                            if (qt == null || qt.trim().length() == 0) {
                                vldr = completefield + lang.lng(current_lang, "amount");
                            }
                            if (pr == null || pr.trim().length() == 0 || pr.equalsIgnoreCase("0.00")) {
                                if (!slsalc.equalsIgnoreCase("c")) {
                                    vldr = completefield + lang.lng(current_lang, "price");
                                }
                            }
                        }
                        if (pcod == null || pcod.trim().length() == 0) {
                            vldr = completefield + lang.lng(current_lang, "prod code");
                        }
                        if (pcbar == null || pcbar.trim().length() == 0) {
                            vldr = completefield + lang.lng(current_lang, "barcode");
                        }
                        if (tp == null || tp.trim().length() == 0 || tp.equalsIgnoreCase("NA")) {
                            vldr = completefield + lang.lng(current_lang, "type");
                        }
                        if (ct == null || ct.trim().length() == 0 || ct.equalsIgnoreCase("NA")) {
                            vldr = completefield + lang.lng(current_lang, "category");
                        }
                        if (tp == null || tp.trim().length() == 0) {
                        } else {
                            String ss = "";
                            tblins = "sales";
                            if (!g) {
                                String sj = "insert into clients (sector,clientname,client_nr,user_datetime,iduser) values ('" + sector + "','" + cnm + "'," + clt + ",NOW(),'" + user_register + "')";
                                //s += sj;
                                if (!vls.insertClient(sj)) {
                                    retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred:_the_client_has_not_been_registered") + "!</span>");
                                    return;
                                }
                            }
                            g = true;
                            if (slsalc.equalsIgnoreCase("c")) {
                                ss = "insert into sales (sector,group_factory,p_code,barcode,prod_type,category,article,quantity,price,user_datetime,iduser,client_nr,aloc_stock,marked_rmv,removed) values ('" + sector + "','" + grp + "','" + pcod + "','" + pcbar + "','" + tp + "','" + ct + "','" + ar + "','" + qt + "','" + pr + "',NOW(),'" + user_register + "'," + clt + ",'" + aloc_stck + "',0,0):";
                            } else {
                                ss = "insert into sales (sector,group_factory,p_code,barcode,prod_type,category,article,quantity,price,user_datetime,iduser,client_nr,enrolled_client,marked_rmv,removed) values ('" + sector + "','" + grp + "','" + pcod + "','" + pcbar + "','" + tp + "','" + ct + "','" + ar + "','" + qt + "','" + pr + "',NOW(),'" + user_register + "'," + clt + ",'" + assclnt + "',0,0):";
                            }
                            s += ss;
                            //System.out.println("SX: " + s);
                        }
                    }
                }
            } catch (Exception e) {
                vldr = lang.lng(current_lang, "an_error_has_occurred:_check_that_&eacute;_the_same_sale_or_if_you_have_at_least_one_article") + "!";
                //System.out.println("Vendas lista: " + e.getMessage());
            }
            s += "update ms_requests set plc_state = 0 where msname_us_time = '" + id4 + "' and sector = '" + sector + "':";
            if (!s.contains("sales")) {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "an_error_occurred:_the_system_did_not_recognize_the_sales_list") + "!</span>");
                return;
            }
            retorno = new StringBuffer(insert(s, "a", vldr, prvls));
        } else if (a.equalsIgnoreCase("sysssn")) {
            String idsys = request.getParameter("idsys");
            String pwdsys = request.getParameter("pwdsys");
            String rsact = cssn.sessionactivation(idsys, pwdsys);
            retorno = new StringBuffer(rsact);
            return;
        } else if (a.equalsIgnoreCase("b")) {
            String di = request.getParameter("di");
            String df = request.getParameter("df");
            String prv = request.getParameter("prv");
            String id = request.getParameter("id");
            String id2 = request.getParameter("id2");
            String id3 = request.getParameter("id3");
            String yesnodlt = request.getParameter("yesnodlt");
            String yesnodlt2 = "";
            String yesnodlt22 = "";
            String yesnodlt23 = "";

            if (yesnodlt == null || yesnodlt.trim().length() == 0) {
                yesnodlt = "Todos";
            }
            if (yesnodlt.equalsIgnoreCase("Todos")) {
                yesnodlt2 = "";
                yesnodlt22 = "";
                yesnodlt23 = "";
            } else {
                yesnodlt2 = " and removed = 0 ";
                yesnodlt22 = " and sales.removed = 0 ";
                yesnodlt23 = " and purchases.removed = 0 ";
            }
            //"&nlstid=" + j + "&nrws=" + b + "&nfb=" + nrfb
            String lmt = "";
            int lstid = 0;
            int nrws = 0;
            String nfb = request.getParameter("nfb");
            if (nfb == null || nfb.trim().length() == 0) {
                nfb = "z";
            }
            try {
                int yz = Integer.parseInt(request.getParameter("nlstid"));
                lstid = yz;
            } catch (Exception e) {
                lstid = 0;
            }
            try {
                int yz = Integer.parseInt(request.getParameter("nrws"));
                nrws = yz;
            } catch (Exception e) {
                nrws = 20;
            }
            if (lstid > 0 && nrws > 0 && nfb.equalsIgnoreCase("f")) {
                lmt = " limit " + lstid + "," + nrws;
            } else if (lstid > 0 && nrws > 0 && nfb.equalsIgnoreCase("b")) {
                int lstidnrws = lstid - nrws;
                if (lstidnrws < 1) {
                    lmt = " limit 0," + nrws;
                } else {
                    lstidnrws = lstidnrws - nrws;
                    lstidnrws = lstidnrws - 1;
                    if (lstidnrws < 1) {
                        lstidnrws = 0;
                    }
                    lmt = " limit " + lstidnrws + "," + nrws;
                }
            }
            if (nfb.equalsIgnoreCase("z")) {
                lmt = " limit " + nrws;
            }
            //System.out.println("lmt: " + lmt);
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
            if (prv.equalsIgnoreCase("gvp")) {
                s = "select id,group_factory as grupo, p_code, barcode, prod_type,category,product,quantity,price,marked_rmv,removed from prices_sales where user_datetime between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) and sector = '" + sector + "' " + yesnodlt2 + lmt;
            } else if (prv.equalsIgnoreCase("gu")) {
                s = "select id,username,firstnames,surnames,category,roles,status from users";
            } else if (prv.equalsIgnoreCase("c") || prv.equalsIgnoreCase("cprz")) {
                String ordby = "";
                if (prv.equalsIgnoreCase("cprz")) {
                    ordby = " order by purchases.comp_prz desc";
                }
                s = "select purchases.id as id ,purchases.group_factory as grupo, purchases.p_code as p_codigo,"
                        + "purchases.barcode as barcode, purchases.prod_type as prod_type,purchases.category as category,"
                        + "purchases.article as article,purchases.quantity as quantity,purchases.price as price,"
                        + "purchases.price_other as price_other,purchases.price_cntry as price_cntry,"
                        + "CAST(purchases.comp_prz AS DATE) as comp_prz,"
                        + "((purchases.quantity * (select vp.price from prices_sales vp where vp.product = purchases.article and "
                        + "vp.sector='" + sector + "' limit 1)) - purchases.price) as profit,"
                        + "purchases.lot_art as lot_art,"
                        + "CONCAT(CAST(purchases.user_datetime AS DATE),CONCAT(' ',CAST(purchases.user_datetime AS TIME))) as user_datetime,"
                        + "(select username from users u where u.id = purchases.iduser limit 1) as user,"
                        + "purchases.marked_rmv as marked_rmv,"
                        + "purchases.removed as removed from purchases"
                        + " left join prices_sales on purchases.article = prices_sales.product"
                        + " AND "
                        + " purchases.p_code = prices_sales.p_code "
                        + " AND "
                        + " purchases.barcode = prices_sales.barcode "
                        + "where CAST(purchases.user_datetime AS DATE) between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) "
                        + " and purchases.sector = '" + sector + "' " + yesnodlt23 + ordby + " " + lmt;
                //System.out.println(s);
            } else if (prv.equalsIgnoreCase("ci")) {
                s = "select id,group_factory as grupo, p_code,barcode,prod_type,category,article,quantity,price,"
                        + "CONCAT(CAST(user_datetime AS DATE),CONCAT(' ',CAST(user_datetime AS TIME))) as user_datetime,"
                        + "(select username from users u where u.id = purchases_not_used.iduser limit 1) as user,"
                        + "marked_rmv,removed from purchases_not_used where CAST(user_datetime AS DATE) "
                        + "between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) and sector = '" + sector + "' " + yesnodlt2 + lmt;
            } else if (prv.equalsIgnoreCase("d")) {
                s = "select id,prod_type,price,expense_date as expense_date,observation,"
                        + "CONCAT(CAST(user_datetime AS DATE),CONCAT(' ',CAST(user_datetime AS TIME))) as user_datetime,"
                        + "(select username from users u where u.id = expenses.iduser limit 1) "
                        + " as user,"
                        + " marked_rmv,removed from expenses "
                        + " where CAST(user_datetime AS DATE) between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) and sector = '" + sector + "' " + yesnodlt2 + lmt;
            } else if (prv.equalsIgnoreCase("va")) {
                String yesnodlt22r = yesnodlt22;
                try {
                    String zw = yesnodlt22r.replaceAll("sales", "s");
                    yesnodlt22r = zw;
                } catch (Exception e) {
                }
                s = "SELECT DISTINCT s.id as id,s.group_factory as grupo,s.p_code as p_code, s.barcode as barcode, c.client_nr as client_nr,"
                        + " c.clientname as clientname,s.prod_type as prod_type,s.category as category,s.article as article,"
                        + " s.quantity as quantity,s.price as price,"
                        + "COALESCE((CASEWHEN(s.price < 0, 0,s.price) - (s.quantity * (select cost from purchases_last_prices q where q.article = s.article and "
                        + " q.sector='" + sector + "' limit 1))),0) "
                        + " as profit,"
                        + " COALESCE(p.article, 'SC') as estado,"
                        /*+ "DATE_FORMAT(s.user_datetime,'%d/%m/%Y') "*/
                        + "CONCAT(CAST(s.user_datetime AS DATE),CONCAT(' ',CAST(s.user_datetime AS TIME))) as user_datetime,"
                        + "(select username from users u where u.id = s.iduser limit 1) as user,"
                        + " s.marked_rmv as marked_rmv,s.removed as removed from sales s "
                        + " left join clients c on s.client_nr = c.client_nr "
                        + " left join purchases_last_prices p on s.article = p.article "
                        + " where CAST(s.user_datetime AS DATE) between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) and s.sector = '" + sector + "' "
                        /*+ " and c.sector = '" + sector + "' and p.sector = '" + sector + "' "*/
                        + yesnodlt22r + ""
                        + " order by s.id desc " + lmt;
                       //System.out.println(s);
            } else if (prv.equalsIgnoreCase("dhs")) {
                s = "select tbl,week(user_datetime) as semana,sum(saldo) as saldo from geral where user_datetime between CAST('" + di + "' AS DATE) and CAST('" + df + "' AS DATE) and sector = '" + sector + "' "
                        + " group by tbl,week(user_datetime) order by week(user_datetime) asc";
            } else if (prv.equalsIgnoreCase("aqp")) {
                s = "select id,product,quantity,marked_rmv,removed from used_products where article = '" + id + "' and sector = '" + sector + "' " + yesnodlt2;
            } else if (prv.equalsIgnoreCase("prodl")) {
                s = "select id,product,marked_rmv,removed from products_purchases where sector = '" + sector + "' " + lmt;
            } else if (prv.equalsIgnoreCase("fctry")) {
                s = "select id,factory,marked_rmv,removed from groups_factories where sector = '" + sector + "' " + lmt;
            } else if (prv.equalsIgnoreCase("pedartins")) {
                s = "select id,group_factory as grupo, p_code,barcode, prod_type,category,article,quantity,price,marked_rmv,removed from clients_requests "
                        + " where msname_us_time = '" + id2 + "'  and sector = '" + sector + "'";
            } else if (prv.equalsIgnoreCase("mspymtrqst")) {
                s = "select msname_us_time from ms_requests where plc_state = 2 and sector = '" + sector + "'";
            } else if (prv.equalsIgnoreCase("rqifm")) {
                s = "select id,group_factory as grupo,p_code,barcode, prod_type,category,article,quantity,price,lastqnty from clients_requests where "
                        + " msname_us_time = '" + id3 + "' and sector = '" + sector + "'";
            } else if (prv.equalsIgnoreCase("msst")) {
                s = "select id_by_sector as id,msname_us_time from ms_states where sector = '" + sector + "'";
                //System.out.println(s);
            } else if (prv.equalsIgnoreCase("dpst")) {
                s = "select id,clientname,residenty,id_number,phone,observation,CAST(last_doposit_date AS DATE) as last_doposit_date,"
                        + "total_payment,total_used,(total_payment - total_used) as balance from deposits where sector = '" + sector + "' " + lmt;
            }
            /*else if (prv.equalsIgnoreCase("est")) {
                s = "select 'Artigos' as Destino,used_products.product as product,sum(used_products.quantity) as quantity"
                        + " from sales left join used_products on sales.article = used_products.article where "
                        + " sales.user_datetime between '" + di + "' and '" + df + "' group by used_products.product"
                        + " UNION ALL "
                        + "select 'Inutilizados' as Destino,prod_type as product, quantity as quantity from purchases_not_used "
                        + " where user_datetime between '" + di + "' and '" + df + "'";
                s = "select category,group_factory,article,price,sum(stock) as stock,p_code,barcode,sum(compras) as compras,sum(vendas) as vendas "
                        + " FROM vstock2 where user_datetime between '" + di + "' and '" + df + "'"
                        + " and sector = '" + sector + "' "
                        + " group by article order by article";
            }*/
            if (prv.equalsIgnoreCase("lstprdvendas") || prv.equalsIgnoreCase("lstprdpedvendas") || prv.equalsIgnoreCase("est")) {
                retorno = new StringBuffer(vls.list_prod_ctgry(prv, sector, prv));
            } else {
                //System.out.println("SSSS: " + s);
                retorno = new StringBuffer(buscar(s, prvls, prv));
            }
        } else if (a.equalsIgnoreCase("cdbar")) {
            s = "select product as article,p_code,barcode,group_factory,category,prod_type,price,descount from prices_sales where "
                    + "(product = '" + request.getParameter("id") + "' or "
                    + " p_code = '" + request.getParameter("id") + "' or "
                    + " barcode = '" + request.getParameter("id") + "') and sector = '" + sector + "' limit 1";
            artavailb = vls.artcprzcnt(request.getParameter("id"));
            //System.out.println("S: " + s);
            retorno = new StringBuffer(buscar(s, "cdbar", "cdbar"));
        } else if (a.equalsIgnoreCase("n")) {
            String nvcl = "";
            String t = "";
            String w = "";
            Format formatter;
            java.util.Date date = new java.util.Date();
            formatter = new SimpleDateFormat("yyyyMMddHHmmsss");
            t = formatter.format(date);
            Random r = new Random();
            int u = 9;
            for (int k = 1; k < 4; k++) {
                int j = r.nextInt(u);
                w += "" + j;
            }
            nvcl = "" + t + w;
            retorno = new StringBuffer(nvcl);
        } else if (a.equalsIgnoreCase("vart") || a.equalsIgnoreCase("vart2") || a.equalsIgnoreCase("vpr") || a.equalsIgnoreCase("vpr2")) {
            retorno = new StringBuffer(vls.Artcls(request.getParameter("pt"), request.getParameter("z"), request.getParameter("q")));
        } else if (a.equalsIgnoreCase("rc") || a.equalsIgnoreCase("rd") || a.equalsIgnoreCase("rva") || a.equalsIgnoreCase("rgvp")) {/*Remover casos*/
            String id = request.getParameter("id");
            String r = request.getParameter("r");
            int rr;
            try{
              rr = Integer.parseInt(r);  
            }catch(Exception e){
              rr = 2;
            }
            // System.out.println("ZZ: " + a + "," + id + "," + r);
            String rmc = "";
            String aa = "";
            if (a.equalsIgnoreCase("rc")) {
                aa = "purchases";
            } else if (a.equalsIgnoreCase("rd")) {
                aa = "expenses";
            } else if (a.equalsIgnoreCase("rgvp")) {
                aa = "prices_sales";
            } else if (a.equalsIgnoreCase("rva")) {
                aa = "sales";
            }
            if (rr == 0) {
                rmc = "update " + aa + " set marked_rmv = 1 where id = " + id + " and removed = 0 and sector = '" + sector + "'";
            } else if (rr == 1 && ctgry_usr.equalsIgnoreCase("Gestor")) {
                rmc = "update " + aa + " set removed = 1 where id = " + id + " and marked_rmv = 1 and iduser <> " + user_register + " and sector = '" + sector + "'";
            }
            if(a.equalsIgnoreCase("rc")){
                if(rr != 0 && rr != 1){
                   rmc = "delete from " + aa + " where id = " + id;
                }
                if(!r.equalsIgnoreCase("0") && !r.equalsIgnoreCase("1")){
                   rmc = "delete from " + aa + " where id = " + id;
                }
            }
            // System.out.println("rmc: " + rmc);
            if (rr == 1 && !ctgry_usr.equalsIgnoreCase("Gestor")) {
                retorno = new StringBuffer("<span style='color: red;'>" + lang.lng(current_lang, "to_delete_a_data,_you_need_to_have_manager_category") + "!</span>");
                return;
            }
            retorno = new StringBuffer(updateobs(rmc, "", prvls));
        } else if (a.equalsIgnoreCase("edc")) {
            String id = request.getParameter("id");
            String c = request.getParameter("c");
            String p = request.getParameter("p");
            String e = request.getParameter("e");
            if (p == null || p.trim().length() == 0 || p.equalsIgnoreCase("NA")) {
                vldr = " Ver Previlegios";
            }
            if (c == null || c.trim().length() == 0 || c.equalsIgnoreCase("NA")) {
                vldr = " Ver Categoria";
            }
            if (e == null || e.trim().length() == 0 || e.equalsIgnoreCase("NA")) {
                vldr = " Ver Estado";
            }
            if (!e.equalsIgnoreCase("0") && !e.equalsIgnoreCase("1")) {
                vldr = " O estado deve ser 1 para activo e 0 para n&atilde;o activo";
            }
            try{
                String esty = e.trim();
                e = esty;
            }catch(Exception ex){}
            if (!cssn.activeduser() && e.equals("1")) {
                //retorno = new StringBuffer("<span style='color: red;'>Esta activando mais usu&aacute;rios que a subscri&ccedil;&atilde;o, pode fazer um <em>upgrade</em> ou desativar um usu&aacute;rio!</span>");
                //return;
            }
            String z = "update users set category = '" + c + "', status = '" + e + "',roles = '" + p + "' where id = " + id;
            //System.out.println("z: " + z);
            retorno = new StringBuffer(updateobs(z, vldr, prvls));
        } else if (a.equalsIgnoreCase("cmp_inf")) {
            String z = "";
            String q = "";
            String staff = request.getParameter("usrnm");
            String snh = request.getParameter("snh1");
            String snh1 = request.getParameter("snh2");
            //q = "update users set password='" + snh1 + "',user_updated = '" + staff + "', date_updated = NOW() "
            //    + " where username = '" + staff + "' and password = '" + snh + "'";
            try {
                staff = staff.trim();
                snh = snh.trim();
                snh1 = snh1.trim();
            } catch (Exception e) {
                retorno = new StringBuffer("Prencher corretamente os campos!");
                return;
            }
            if (snh.length() < 9 || snh1.length() < 9) {
                retorno = new StringBuffer("A senha deve ter pelomenos 9 caracteres!");
                return;
            }
            q = "update users set password='" + ec.enc(snh1) + "',user_updated = '" + staff + "', date_updated = NOW() "
                    + " where username = '" + staff + "'";
            if (cssn.usersession(staff, snh)) {
                retorno = new StringBuffer(updateobs(q, vldr, prvls));
            } else {
                retorno = new StringBuffer("Credencias erradas!");
            }
            //cmp_inf&usrnm=" + usrnm + "&snh1=" + snh1 + "&snh2=" + snh2 + "&imagem=" + imggs
        } else if(a.equalsIgnoreCase("cmmnts")){
           String hlpid = request.getParameter("hlpid");
           String hlpnm = request.getParameter("hlpnm");
           String hlptxt = request.getParameter("hlptxt");
           String user = request.getParameter("user");
           String sector = request.getParameter("sector");
           retorno = new StringBuffer(cssn.send_comments(hlpid, hlpnm, hlptxt, user, sector));
        }
    }

    private String updateothrs(String q, String pvl) {
        if (!pvl.contains("z")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "does_not_have_privileges_to_place_allocated_stock_as_processed") + "!</span>";
        }
        String b = "";
        try {
            con = cdb.getConnection();
            if (con == null) {
                return "<span style='color: red;'>" + lang.lng(current_lang, "server_busy._try_later") + "!</span>";
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            b = "<span style='color: green;'>Processado com sucesso: " + r + " linhas!</span>";
        } catch (Exception e) {
            b = "<span style='color: red;'>Erro ao processar!</span>";
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return b;
    }

    private String updateobs(String q, String val, String pvl) {
        String b = "";
        if (!pvl.contains("i")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_privileges_to_enter_data") + "!</span>";
        }
        if (q.contains("delete from purchases") || q.contains("marked_rmv") || q.contains("removed") || a.equalsIgnoreCase("cmp_inf") || pvl.contains("u") && q.contains("update users")) {
        } else {
            return "<span style='color: red;'>" + lang.lng(current_lang, "it_does_not_have_privileges_to_insert_or_update_users") + "!</span>";
        }
        if (val == null || val.trim().length() == 0) {
        } else {
            return "<span style='color: red;'>" + val + "!</span>";
        }
        try {
            con = cdb.getConnection();
            if (con == null) {
                return "<span style='color: red;'>" + lang.lng(current_lang, "server_busy._try_later") + "!</span>";
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate(q);
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            b = "<span style='color: green;'>Processado com sucesso: " + r + " linhas!</span>";
        } catch (Exception e) {
            b = "<span style='color: red;'>Erro ao processar!</span>";
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return b;
    }

    private String insert(String sx, String rf, String val, String pvl) {
        //System.out.println("insert: " + sx + "," + rf + "," + val + "," + pvl);
        if (!pvl.contains("i")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_privileges_to_enter_data") + "!</span>";
        }
        if (!pvl.contains("u") && tblins.equalsIgnoreCase("users")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "it_does_not_have_privileges_to_insert_or_update_users") + "!</span>";
        }

        if (!pvl.contains("c") && tblins.equalsIgnoreCase("purchases")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_do_not_have_privileges_to_insert_or_update_purchases") + "!</span>";
        }
        if (!pvl.contains("v") && tblins.equalsIgnoreCase("sales")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_dont_have_privileges_to_insert_or_update_sales") + "!</span>";
        }
        if (!pvl.contains("w") && tblins.equalsIgnoreCase("prices_sales")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_do_not_have_privileges_to_enter_or_update_sale/price") + "!</span>";
        }
        if (!pvl.contains("e") && tblins.equalsIgnoreCase("expenses")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_do_not_have_privileges_to_insert_or_update_expenses") + "!</span>";
        }
        if (!pvl.contains("n") && tblins.equalsIgnoreCase("purchases_not_used")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "you_do_not_have_privileges_to_insert_or_update_invalid_articles") + "!</span>";
        }
        if (val == null || val.trim().length() == 0) {
        } else {
            return "<span style='color: red;'>" + val + "!</span>";
        }
        if (tblins.equalsIgnoreCase("sales") && !sx.contains("sales")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "an_error_has_occurred_please_refresh_your_browser") + "!</span>";
        }
        String sx1 = sx;
        String b = "";
        //System.out.println("SX: " + sx);
        try {
            try {
                con = cdb.getConnection();
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(aw.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (con == null) {
                return "<span style='color: red;'>" + lang.lng(current_lang, "server_busy._try_later") + "!</span>";
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            if (rf.equalsIgnoreCase("b")) {
                String sx2 = sx1.replaceAll(tblins, tblins + "_duplicate");
                String sx3 = sx1.replaceAll(tblins, tblins + "_events");
                stmt.executeUpdate(sx1);
                stmt.addBatch(sx2);
                stmt.addBatch(sx3);
                //System.out.println("Q1: " + sx1);
                //System.out.println("Q2: " + sx2);
                //System.out.println("Q3: " + sx3);
                if (a.equalsIgnoreCase("stplc")) {
                    String m1 = "";
                    String m2 = "";
                    try {
                        String mm = mss.split("\\.")[0];
                        m1 = mm;
                    } catch (Exception e) {
                    }
                    try {
                        String mm = mss.split("\\.")[1];
                        m2 = mm;
                    } catch (Exception e) {
                    }
                    String idk = "";
                    try {
                        String w = m1.split("_")[1];
                        idk = w;
                    } catch (Exception e) {
                    }
                    String qms1 = "update ms_states set cliente = '" + m2 + "', msname_us_time = '" + mss + "', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms2 = "update ms_states_duplicate set cliente = '" + m2 + "', msname_us_time = '" + mss + "', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms3 = "update ms_states_events set cliente = '" + m2 + "', msname_us_time = '" + mss + "', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    //System.out.println("QMS1: " + qms1);
                    //System.out.println("QMS1: " + qms2);
                    //System.out.println("QMS1: " + qms3);
                    stmt.addBatch(qms1);
                    stmt.addBatch(qms2);
                    stmt.addBatch(qms3);
                } else if (a.equalsIgnoreCase("rqpyt")) {
                    String idk = "";
                    try {
                        String w = mss.split("_")[1];
                        idk = w;
                    } catch (Exception e) {
                    }
                    String qms1 = "update ms_states set msname_us_time = 'pending', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms2 = "update ms_states_duplicate set msname_us_time = 'pending', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms3 = "update ms_states_events set msname_us_time = 'pending', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    //System.out.println("QMS3: " + qms1);
                    //System.out.println("QMS3: " + qms2);
                    //System.out.println("QMS3: " + qms3);
                    stmt.addBatch(qms1);
                    stmt.addBatch(qms2);
                    stmt.addBatch(qms3);
                }
                if (a.equalsIgnoreCase("ci")) {
                    stmt.addBatch(updprcs);
                    String tblincp = "purchases";
                    String sk2 = updprcs.replaceAll(tblincp, tblincp + "_duplicate");
                    String sk3 = updprcs.replaceAll(tblincp, tblincp + "_events");
                    stmt.addBatch(sk2);
                    stmt.addBatch(sk3);
                }
                stmt.executeBatch();
            }
            if (rf.equalsIgnoreCase("a")) {
                //boolean fstsl = true;
                boolean fstsl = false;
                for (String c : sx.split(":")) {
                    if (c == null || c.trim().length() == 0) {
                    } else {
                        if (fstsl) {
                            stmt.executeUpdate(c);
                            String sx2 = c.replaceAll("clients", "clients_duplicate");
                            String sx3 = c.replaceAll("clients", "clients_events");
                            //System.out.println("QMS6: " + c);
                            //System.out.println("QMS6: " + sx2);
                            //System.out.println("QMS6: " + sx3);
                            stmt.addBatch(sx2);
                            stmt.addBatch(sx3);
                        } else {
                            stmt.addBatch(c);
                            String sx2 = c.replaceAll(tblins, tblins + "_duplicate");
                            String sx3 = c.replaceAll(tblins, tblins + "_events");
                            //System.out.println("QMS4: " + sx2);
                            //System.out.println("QMS4: " + sx2);
                            //System.out.println("QMS4: " + sx3);
                            stmt.addBatch(sx2);
                            stmt.addBatch(sx3);
                        }
                        fstsl = false;
                    }
                }
                if (a.equalsIgnoreCase("v")) {
                    String idk = "0";
                    try {
                        String w = id4.split("_")[1];
                        idk = w;
                    } catch (Exception e) {
                        idk = "0";
                    }
                    String qms1 = "update ms_states set msname_us_time = 'empty', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms2 = "update ms_states_duplicate set msname_us_time = 'empty', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    String qms3 = "update ms_states_events set msname_us_time = 'empty', iduser = " + user_register + " where id_by_sector = " + idk + " and sector = '" + sector + "'";
                    //System.out.println("QMS2: " + qms1);
                    //System.out.println("QMS2: " + qms2);
                    //System.out.println("QMS2: " + qms3);
                    stmt.addBatch(qms1);
                    stmt.addBatch(qms2);
                    stmt.addBatch(qms3);
                    try {
                        for (String gkk : updprcs.split(":")) {
                            if (gkk == null || gkk.trim().length() == 0) {
                            } else {
                                stmt.addBatch(gkk);
                                //System.out.println(gkk);
                            }
                        }
                    } catch (Exception e) {
                    }
                }
                stmt.executeBatch();
            }
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
            b = "<span style='color: green;'>Processado com sucesso!</span>";
        } catch (SQLException e) {
            b = "<span style='color: red;'>Erro ao processar!</span>";
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException e) {
                //System.out.println("" + e.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        return b;
    }

    private String buscar(String s, String pvl, String p) {
        if (!pvl.contains("b")) {
            return "<span style='color: red;'>" + lang.lng(current_lang, "does_not_have_privileges_to_visualize_data") + "!</span>";
        }
        String b = "";
        Double saldo = 0.0;
        Double tb_p = 0.0;
        Double tb_e = 0.0;
        Double tb_s = 0.0;

        String tbp = "";
        String tbe = "";
        String tbs = "";
        String smns = "";
        String sn = "a";
        String sn2 = "";
        //System.out.println(s);
        //System.out.println(p);
        //System.out.println(pvl);
        try {

            con = cdb.getConnection();
            if (con == null) {
                return lang.lng(current_lang, "server_busy._try_later") + "!";
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(s);
            int y = 1;
            int jk = 1;
            if (p.equalsIgnoreCase("mspymtrqst")) {
                b += "<a href=\"#\" onclick=\"checklstofms(),processar('mspymtrqst', 'b')\" style=\"text-decoration: none;\">"
                        + lang.lng(current_lang, "view_payment_requests") + "</a>:<br><table><tr><td>";
            }
            int zy = 0; //resolve the problem of last sales that has more records
            while (rs.next()) {
                if (p.equalsIgnoreCase("dhs")) {
                    String tbll = rs.getString("tbl");
                    String tbvls = rs.getString("saldo");

                    if (tbll == null || tbll.trim().length() == 0) {
                        tbll = "_";
                    }
                    //b += vls.dshtbls(tbll, tbvls);
                    try {
                        Double sld = Double.parseDouble(tbvls);
                        saldo = saldo + sld;
                        //System.out.println("w: " + sld + "," + saldo);
                    } catch (Exception e) {
                        // System.out.println("we: " + e.getMessage());
                    }

                    Double zz = 0.0;
                    try {
                        Double jj = Double.parseDouble(tbvls);
                        zz = jj;
                    } catch (Exception e) {
                        zz = 0.0;
                        //System.out.println("we: " + e.getMessage());
                    }

                    if (tbll.equalsIgnoreCase("purchases")) {
                        tb_p = tb_p + zz;
                        tbp += zz + ",";
                        sn2 += "purchases,";
                    } else if (tbll.equalsIgnoreCase("expenses")) {
                        tb_e = tb_e + zz;
                        tbe += zz + ",";
                        sn2 += "expenses,";
                    } else if (tbll.equalsIgnoreCase("sales")) {
                        tb_s = tb_s + zz;
                        tbs += zz + ",";
                        sn2 += "sales,";
                    }

                    if (smns == null || smns.trim().length() == 0) {
                        smns += rs.getString("semana") + ",";
                    } else if (!smns.contains(rs.getString("semana"))) {
                        smns += rs.getString("semana") + ",";
                        if (!sn.equalsIgnoreCase(rs.getString("semana"))) {
                            if (!sn2.contains("purchases")) {
                                tbp += "0.0,";
                            }
                            if (!sn2.contains("expenses")) {
                                tbe += "0.0,";
                            }
                            if (!sn2.contains("sales")) {
                                tbs += "0.0,";
                            }
                            sn2 = "";
                        }

                    }
                    sn = rs.getString("semana");
                } else if (p.equalsIgnoreCase("mspymtrqst")) {
                    String brr = "";
                    if (jk == 8 || jk == 15 || jk == 22 || jk == 30 || jk == 38 || jk == 35 || jk == 42) {
                        brr = "</td></tr><tr><td style='height: 18px;'></td></tr><tr><td>";
                    } else {
                        brr = "";
                    }
                    b += "<span onclick=\"prcnmbrrq('" + rs.getString("msname_us_time") + "'),processar('rqif', 'n')\" style=\"padding: 6px; background-color: #7DCEA0; border-radius: 6px; width: 120px;\">" + rs.getString("msname_us_time") + "</span><span style='color: white;'>hhhhhhhh</span>" + brr;
                    jk = jk + 1;
                } else if (p.equalsIgnoreCase("cdbar")) {
                    int descount = rs.getInt("descount");
                    //descount = 100 - descount;
                    String inpd = "";
                    if (descount != 0) {
                        inpd = "Desconto(%): <input type='number' id='txtdescnt' min='1' max='" + descount + "' "
                                + " onkeyup=\"processdescount('" + descount + "')\" onchange=\"processdescount(this.value)\" "
                                + " style=\"width: 60px;\">";
                    }
                    //Converting price
                    String sc_price = rs.getString("price");
                    sc_price = trnsf.NumberToDecimal(sc_price);
                    /*double c_price = 0.00;
                    try{
                        String scprc = sc_price.trim();
                        sc_price = scprc;
                    }catch(Exception ee){
                    
                    }
                    try{
                        c_price = Double.parseDouble(sc_price);
                        DecimalFormat df = new DecimalFormat("#.00");
                        sc_price = df.format("" + c_price);
                    }catch(Exception ee){
                        c_price = 0.00;
                    }*/
                    b += vls.rmvSpcChar(rs.getString("p_code")) + "," + vls.rmvSpcChar(rs.getString("barcode"))
                            + "," + vls.rmvSpcChar(rs.getString("group_factory"))
                            + "," + vls.rmvSpcChar(rs.getString("prod_type")) + "," + vls.rmvSpcChar(rs.getString("category"))
                            + "," + rs.getString("article") + "," + sc_price
                            + "," + inpd + "," + artavailb[0] + ";" + artavailb[1];
                } else {
                    if (zy == 0) {
                        try {
                            for (int j = 1; j < 40; j++) {
                                String z = rs.getString(j);
                                zy = j;
                            }
                        } catch (Exception e) {
                        }
                    }
                    try {
                        for (int j = 1; j < 40; j++) {
                            String z = rs.getString(j);
                            if(z == null || z.trim().length() == 0 || z.equalsIgnoreCase("null")){
                                if (p.equalsIgnoreCase("c") && j == 13) {
                                      z = "0";
                                }else{
                                      z = "NA";
                                }
                            }
                            try {
                                String m = z.replaceAll(":", ".");
                                z = m;
                            } catch (Exception e) {
                                break;
                            }
                            if (p.equalsIgnoreCase("va")) {
                                if (zy != j) {
                                    b += "" + z + ";";
                                }
                            } else{
                                b += "" + z + ";";
                            }
                        }
                    } catch (SQLException e) {
                        //break; 
                    }
                    b += ":";
                    y = y + 1;
                    //System.out.println("b1: " + b);
                }
            }
            if (p.equalsIgnoreCase("mspymtrqst")) {
                b += "</td></tr></table>";
            }
            if (!sn2.contains("purchases")) {
                tbp += "0.0,";
            }
            if (!sn2.contains("expenses")) {
                tbe += "0.0,";
            }
            if (!sn2.contains("sales")) {
                tbs += "0.0,";
            }
        } catch (Exception e) {
            retorno = new StringBuffer("<div style='color: red;'>Falhou 1 , " + e.getMessage() + "tente novamente</div>");
            //System.out.println("" + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                cdb.devolveConnection(con);
            } catch (SQLException eb) {
                //System.out.println("" + eb.getMessage());
            }
            try {
                stmt.close();
            } catch (Exception e) {
            };
        }
        if (p.equalsIgnoreCase("dhs")) {
            DecimalFormat twoDc = new DecimalFormat("#.00");
            String a = vls.dshtbls("Saldo", "" + twoDc.format(saldo));
            //System.out.println("a: " + a);

            tbe += ",";
            tbp += ",";
            tbs += ",";
            smns += ",";
            try {
                String r = tbe.replaceAll(",,", "");
                tbe = r;
            } catch (Exception e) {
            }
            try {
                String r = tbp.replaceAll(",,", "");
                tbp = r;
            } catch (Exception e) {
            }
            try {
                String r = tbs.replaceAll(",,", "");
                tbs = r;
            } catch (Exception e) {
            }
            try {
                String r = smns.replaceAll(",,", "");
                smns = r;
            } catch (Exception e) {
            }
            //Second query in database
            if (p.equalsIgnoreCase("dhs")) {
                s = s.split("between")[1];
                s = s.split("group")[0];
                try {
                    String[] sw = s.split("and");
                    String sw1 = sw[0].trim();
                    String sw2 = sw[1].trim();
                    String tw = " CAST('" + sw1 + "' AS DATE) and CAST('" + sw2 + "' AS DATE)";
                    s = tw;
                } catch (Exception e) {
                }
                s = "select tbl,sum(saldo) as saldo from geral where user_datetime between " + s + " and sector = '" + sector + "' group by tbl";
                try {

                    con = cdb.getConnection();
                    if (con == null) {
                    }
                    stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(s);
                    while (rs.next()) {
                        String z = rs.getString("tbl");
                        String t = rs.getString("saldo");
                        b += vls.dshtbls(z, t);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        cdb.devolveConnection(con);
                    } catch (SQLException eb) {
                        //System.out.println("" + eb.getMessage());
                    }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                    };
                }
            }
            //End of second query in database
            b = "<table><tr>" + a + b + "</tr></table>::" + tb_e + "," + tb_p + "," + tb_s + "::" + tbe + ":" + tbp + ":" + tbs + ":" + smns;
            //System.out.println("ww" + tbe + ":" + tbp + ":" + tbs);
            try {
                //String n = b.replaceAll("-", ""); 
                //b = n;
            } catch (Exception e) {

            }
        }
        //System.out.println("b2: " + b);
        if(p.equalsIgnoreCase("c")) {
           b = vls.removeDuplicateById(b);
        }
        return b;
    }

    public String getR() {
        return retorno.toString();
    }
}
