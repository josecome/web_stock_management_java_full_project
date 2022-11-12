/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.regex.Pattern;

/**
 *
 * @author Admin
 */
public class get_lng_file {

    public String[][] getlngs() throws IOException {
        String[][] v = new String[800][10];
        URL path = get_lng_file.class.getResource("languages.csv");
        String path2 = path.toString();
        try{
            String a = path2.replaceAll(Pattern.quote("file:/"), "");
            path2 = a;
        }catch(Exception e){}
        String pthfl = Strngs.pth_current_java_f_local;
        if (!(getPathIrprt()).contains("Apache Tomcat 8.0.27")) {
            pthfl = getPathIrprt() + "\\webapps\\SGRB\\WEB-INF\\classes\\a";
        }
        try (FileInputStream fstream = new FileInputStream(pthfl + "\\languages.csv")) {
            BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
            String strLine;
            int x = 1;
            try {
                while ((strLine = br.readLine()) != null) {
                    //System.out.println("str: " + strLine);
                    String[] w = strLine.split("\",\"");
                    v[x][1] = rplc(w[0]);
                    v[x][2] = w[1] == null || w[1].trim().length() == 0 ? rplc(w[0]) : rplc(w[1]);
                    v[x][3] = w[2] == null || w[2].trim().length() == 0 ? rplc(w[0]) : rplc(w[2]);
                    v[x][4] = w[3] == null || w[3].trim().length() == 0 ? rplc(w[0]) : rplc(w[3]);
                    x = x + 1;
                }
            } catch (Exception e) {
                //System.out.println("e: " + e.getMessage());
            }

        }
        //System.out.println("v: " + v.toString());
        return v;
    }
    private String rplc(String a){
      try{
          String b = a.replaceAll("\"", "");
          a = b;
      }catch(Exception e){}      
      return a;
    }
    public String getPathIrprt() {
        String g = "";
        try {
            String s = "" + (System.getProperty("user.dir")).replaceAll("bin\\\\", "");
            s = s.replaceAll("bin", "");
            g = s;
        } catch (Exception e) {
            //System.out.println("ee: " + e.getMessage());
        }
        try {
            String s = g.replaceAll("\\\\", "\\");
            g = s;
        } catch (Exception e) {
            //System.out.println("ee: " + e.getMessage());
        }
        return g;
    }
}
