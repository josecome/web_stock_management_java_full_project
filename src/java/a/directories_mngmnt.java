/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

import java.io.File;
import java.io.IOException;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class directories_mngmnt {

    public void deleteAllfiles() {
        File folder = new File(Strngs.fl);
        File[] listOfFiles = folder.listFiles();
        try {
            for (int i = 0; i < listOfFiles.length; i++) {
                File fld = new File(Strngs.fl + File.separator + listOfFiles[i].getName());
                try {
                    fld.delete();
                } catch (Exception e) {
                }
            }
        } catch (Exception e) {
        }
        try {
            File directory = new File(Strngs.fl);
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception ex) {
        }
    }

    public void cpybckflToCFloldr(String vlsgetpath) {
        File source = new File(vlsgetpath + "\\webapps\\SGRB\\BCKUPS");
        File dest = new File("C:\\SGRB\\BCKUPS");
        try {
            FileUtils.copyDirectory(source, dest);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void creatTmpFldr() {
        try {
            File directory = new File("c:\\temp");
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception e) {
        }
    }

    public void checkIfDrctyExistandCreateIt(String vlsgetpath) {
        for (String f : "\\webapps\\SGRB\\BCKUPS,\\webapps\\SGRB\\TEMPPATH,C:\\SGRB\\BCKUPS,C:\\SGRB\\TEMPPATH,C:\\SGRB\\SOURF".split(",")) {
            if (f == null || f.trim().length() == 0) {
            } else {
                try {
                    //System.out.println("V: " + vlsgetpath + f);
                    String fpth;
                    if (f.equalsIgnoreCase("C:\\SGRB\\BCKUPS") || f.equalsIgnoreCase("C:\\SGRB\\TEMPPATH") || f.equalsIgnoreCase("C:\\SGRB\\SOURF")) {
                        fpth = f;
                        //System.out.println("V: " + fpth);
                    } else {
                        fpth = vlsgetpath + f;
                        //System.out.println("V: " + fpth);
                    }
                    File directory = new File(fpth);
                    if (!directory.exists()) {
                        directory.mkdirs();
                    } else {
                        if (!f.equalsIgnoreCase("C:\\SGRB\\BCKUPS") && f.equalsIgnoreCase("C:\\SGRB\\TEMPPATH")) {
                            deleteAllfiles();
                        }
                    }
                } catch (Exception e) {
                    //System.out.println("E:" + e.getMessage());
                }
            }
        }
    }

    public void creatDBFolder() {
        try {
            File directory = new File(Strngs.dbfolder);
            if (!directory.exists()) {
                directory.mkdir();
            }
        } catch (Exception e) {
        }
    }
}
