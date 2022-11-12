package a;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

public class r extends HttpServlet {

    String typUsr = "w";
    language lang;
    String current_lang = "";
    PreferedLang plng; 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performTask(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performTask(request, response);
    }

    protected void performTask(HttpServletRequest request, HttpServletResponse response) {
        String url = null;
        HttpSession sessao;
        Values vls = new Values();
        client_session cssn = new client_session();
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
        String ts = request.getParameter("t");
        if (ts == null || ts.trim().length() == 0) {
            ts = "0";
        }
        int tss = 0;
        try {
            int s = Integer.parseInt(ts);
            tss = s;
        } catch (Exception e) {
        }
        String dsbld = request.getParameter("dsbld");
        if (dsbld == null || dsbld.trim().length() == 0) {
            dsbld = "a";
        }
        if (dsbld.equalsIgnoreCase("disabled")) {
            try {
                getServletContext().getRequestDispatcher("/Page2.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(r.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        //////////////////////////////////////////////////////////////////////////////////////////
        String cngpwd = request.getParameter("acao");
        if (cngpwd == null || cngpwd.trim().length() == 0) {
            cngpwd = "a";
        }
        /////////////////////////////////////////////////////////////////////////////////////////
        if(tss != 0 && tss != 3 && tss != 100 && !cngpwd.equalsIgnoreCase("cmp_inf")){
           if(checkSessionToken(request) == false){
              PrintWriter out = null; 
              try {                   
                   out = response.getWriter();
                   try {
                       response.setContentType("text/xml");
                       out.println("newpageloginagain");
                       return;
                   } finally {
                       out.close();
                   }
                 } catch (IOException ex) {
               } finally {
                   out.close();
              }
           }
        }
        try {
            switch (tss) {
                /*Initializing WEB session of current user*/
                case 0:
                    //System.out.println("a");
                    String login = request.getParameter("login");
                    String senha = request.getParameter("password");
                    //System.out.println("Usuarios: " + login + "," + senha);
                    String tmp = request.getParameter("data_ser");
                    typUsr = request.getParameter("tusr");
                    /*Web User*/
                    if (login == null || senha == null) {
                        url = "/Login.jsp";
                    } else {
                        //System.out.println("b");
                        sessao = request.getSession(true);
                        sessao.setAttribute("lb", new lb(login, senha, tmp, "yes"));
                        //System.out.println("b2");
                        url = "/MainPage.jsp";
                        //System.out.println("b3");
                    }
                    break;
                case 1:
                    sessao = request.getSession(false);
                    if (sessao == null) {
                        url = "/Login.jsp";
                    } else {
                        url = "/MainPage.jsp";
                    }
                    break;
                case 12:
                    sessao = request.getSession(false);
                    if (sessao == null) {
                        url = "/Login.jsp";
                    } else {
                        url = "/updtart.jsp";
                    }
                    break;
                case 3:
                    sessao = request.getSession(false);
                    sessao.invalidate();
                    url = "/Login.jsp";
                    break;
                case 100:
                    //System.out.println("k: " + request.getParameter("keysys"));
                    String vlky = cssn.getKeyValidation(request.getParameter("keysys"));
                    //System.out.println("k2: " + vlky);
                    if (vlky.equalsIgnoreCase("valido")) {
                        url = "/Login.jsp";
                    } else if (vlky.equalsIgnoreCase("Tem chave activa, esta ainda nao foi usada")) {
                        url = "/Login.jsp?z=" + lang.lng(current_lang, "has_an_active_key_this_has_not_been_used_yet"); //vlky;
                    } else if (vlky.equalsIgnoreCase("usada")) {
                        url = "/Page2.jsp?v=Chave Usada!";
                    } else if (vlky.contains("correu um erro")) {
                        url = "/Page2.jsp?v=" + vlky;
                    } else if (vlky.contains("atualize")) {
                        url = "/Page2.jsp?v=" + lang.lng(current_lang, "this_version_is_not_updated._download_new_version_before_proceeding") + "!";
                    } else {
                        url = "/Page2.jsp?v=" + lang.lng(current_lang, "invalid_key") + "!";
                    }
                    break;
                case 2:
                    processar(request, response);
                    break;
                default:
                //processar(request, response);
                //break;
            }
            if (ts.equalsIgnoreCase("0") || ts.equalsIgnoreCase("1") || ts.equalsIgnoreCase("3")
                    || ts.equalsIgnoreCase("12") || ts.equalsIgnoreCase("100")) {
                //System.out.println("c:" + tss + "," + url);
                getServletContext().getRequestDispatcher(url).forward(request, response);
            }
        } catch (IOException | ServletException e) {
            //System.out.println("Servlet falhou, tente novamente!" + e.getMessage());
        }
    }

    private void processar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        aw abb = new aw(request);
        //System.out.println("HOSP1a: ");
        PrintWriter out = response.getWriter();
        String resp_from_server = "";
        //System.out.println("HOSP1b: ");
        /*if (1 ==  1) {
                                String login = request.getParameter("login");
                    String senha = request.getParameter("password");
                    System.out.println("UUU: " + login + "," + senha);
			resp_from_server = "<span style='color: red;'>Server refused comunication!</span>";
                        System.out.println("HOSP1c: ");
        } else {
            System.out.println("HOSP1: ");
            resp_from_server = abb.getR();
            System.out.println("HOSP: " + resp_from_server);
        }*/
        resp_from_server = abb.getR();
        //System.out.println("GETR: " + resp_from_server);
        try {
            response.setContentType("text/xml");
            out.println(resp_from_server);
        } finally {
            out.close();
        }
    }

    private boolean checkUser(String login, String senha) {
        lb Lb = new lb(login, senha, "", "no");
        return Lb.getStatus();
    }
    private boolean checkSessionToken(HttpServletRequest request) {
        HttpSession session = null;
        session = request.getSession(false);
        a.lb Lb = (a.lb) session.getAttribute("lb");
        boolean z = false;
        Connection con = null;
        Statement stmt = null;
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select session_token from users where username = '" + Lb.getLogin() + "'");
            while (rs.next()) {
                String tknb = rs.getString("session_token");
                String tknc = Lb.getOne_session_token();
                //System.out.println("c1: " + tknb);
                //System.out.println("c2: " + tknc);
                tknb = tknb == null || tknb.trim().length() == 0 ? "a" : tknb;
                tknc = tknc == null || tknc.trim().length() == 0 ? "b" : tknc;
                if(tknb.equalsIgnoreCase(tknc)){
                   z = true;
                }
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
        return z;
    }
}
