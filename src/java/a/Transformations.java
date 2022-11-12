/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.text.DecimalFormat;

/**
 *
 * @author Admin
 */
public class Transformations {

    public String NumberToDecimal(String b) {
        //System.out.println("b: " + b);
        if (b == null || b.trim().length() == 0 || b.equalsIgnoreCase("0") || b.equalsIgnoreCase("null")) {
            return "0.00";
        }
        if (!b.contains(".")) {
            b = b + ".00";
        }
        //System.out.println("b2: " + b);
        double p = 0.00;
        try {
            double p1 = Double.parseDouble(b);
            p = p1;
        } catch (Exception e) {
        }
        DecimalFormat df = new DecimalFormat("#.00");
        b = "" + df.format(p);
        try {
            String z = b.replaceAll(",", ".");
            b = z;
        } catch (Exception e) {
        }
        return b;
    }

}
