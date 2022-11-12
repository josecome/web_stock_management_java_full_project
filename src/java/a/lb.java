package a;

import ed.encr;
import java.io.IOException;
import java.sql.*;
import java.util.Date;

public class lb {

    protected String username = "m";
    protected String firstnames = "";
    protected String surnames = "";
    protected boolean status = false;
    protected String roles = "";
    protected String motivo = "";
    protected String login = "";
    protected String pwrd = "";
    protected boolean nvl = false;
    protected String ysts = "no";
    protected String one_session_token = "xx";
    language lang;
    PreferedLang plng; 
    String current_lang = "";
    encr ec;

    public lb(String login, String senha, String tmp, String tnkn) {
        this.login = login;
        Connection con = null;
        Statement stmt = null;
        ec = new encr();
        get_lng_file glng = new get_lng_file();
        try { 
            lang = new language(glng.getlngs());
        } catch (IOException ex) {
            
        }
        plng = new PreferedLang();
        current_lang = plng.getPreferedLang();
        Date date = new Date();
        Timestamp timestmp = new Timestamp(date.getTime());
        one_session_token = ("" + timestmp).trim();
        //System.out.println("c: " + one_session_token);
        //ID	username	firstnames	surnames	status	roles	entrydatetime	user_register
        senha = senha.trim();
        String consulta = "select username,firstnames,surnames,status,roles,password from users where username "
                + "= '" + login + "'";
        //System.out.println("c: " + consulta);
        try {
            con = cdb.getConnection();
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(consulta);

            if (rs.next()) {
                String  stts = rs.getString("status");
                if(stts == null || stts.trim().length() == 0){
                   stts = "0";
                }
                if(stts.equalsIgnoreCase("1")){
                     username = rs.getString("username");
                     firstnames = rs.getString("firstnames");
                     surnames = rs.getString("surnames");
                     status = true;
                     roles = rs.getString("roles");
                     motivo = "";
                     ysts = "yes";
                } else {
                     motivo = "Usuario nao ativo";
                }
                //System.out.println(username + "," + firstnames + "," + surnames + "," + status + "," + roles);
            }
            /*if (!status) {
                motivo = motivo.equalsIgnoreCase("Usuario nao ativo") ? motivo : "Credenciais eradas";
            }*/
            
            pwrd = rs.getString("password");
            //System.out.println(pwrd);
            try {
                pwrd = ec.dec(pwrd);
            } catch (Exception e) {
                status = false;
            }

            //System.out.println(pwrd);
            //System.out.println(senha);

        } catch (Exception e) {
           //System.out.println(e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception ee) {
            }
            try {
                cdb.devolveConnection(con);
            } catch (SQLException ex) {
            }
        }
        if (!pwrd.equalsIgnoreCase(senha)) {
            status = false;
            ysts = "no";
            motivo = "Credenciais eradas";
        }
        if (senha.equalsIgnoreCase("abcdefghij")) {
            status = false;
            motivo = "Mudar senha";
        }
        //Add session token
        if(tnkn.equalsIgnoreCase("yes")){
        try {
            con = cdb.getConnection();
            if (con == null) {
            }
            con.setAutoCommit(false);
            DatabaseMetaData meta = con.getMetaData();
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_REPEATABLE_READ)) {
                con.setTransactionIsolation(con.TRANSACTION_REPEATABLE_READ);
            }
            stmt = con.createStatement();
            String r = "" + stmt.executeUpdate("UPDATE users set session_token = '" + one_session_token + "' where username = '" + login + "'");
            con.setAutoCommit(true);
            if (meta.supportsTransactionIsolationLevel(con.TRANSACTION_READ_COMMITTED)) {
                con.setTransactionIsolation(con.TRANSACTION_READ_COMMITTED);
            }
        } catch (Exception e) {
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
       }
    }

    public String getLogin() {
        return login;
    }

    ;
public String getNome() {
        return firstnames;
    }

    ;
public boolean getStatus() {
        return status;
    }

    ;
public String getMotivo() {
        return motivo;
    }

    ;
public String getRoles() {
        return roles;
    }

    ;
public String getUser() {
        return username;
    }

;
public String getStatusYesNo() {
        return ysts;
    }

;
public String getOne_session_token(){
       return one_session_token;
};
}
