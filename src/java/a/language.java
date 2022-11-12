/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

/**
 *
 * @author Admin
 */
public class language {
    private String lngs[][] = null;
    public language(String[][] s){
       this.lngs = s;
    }
    public String lng(String lng, String optn){
       String a = "";
       try{
           for(int i = 1; i < 1000; i++){
               String v = lngs[i][1];
               if(v.equalsIgnoreCase(optn)){
                   if(lng.equalsIgnoreCase("english")){
                      a = lngs[i][2];
                   } else if(lng.equalsIgnoreCase("portuguese")){
                      a = lngs[i][3];
                   } else if(lng.equalsIgnoreCase("spanish")){
                      a = lngs[i][4];
                   } else if(lng.equalsIgnoreCase("french")){
                      a = lngs[i][5];
                   } else {
                      a = lngs[i][3];
                   }
                   break;
               }
           }       
       }catch(Exception e){}
       return a;    
    }
}
