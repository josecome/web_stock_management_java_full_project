package a;

import java.io.File;
import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.model.enums.CompressionLevel;
import net.lingala.zip4j.model.enums.EncryptionMethod;

public class AppZipbs {

    public void zipIt(String cz, String pwd, String fl) throws ZipException {//cz:compressed.zip pwd:password fl:folder to add
        ZipParameters prmts = new ZipParameters();
        prmts.setEncryptFiles(true);
        prmts.setCompressionLevel(CompressionLevel.HIGHER);
        prmts.setEncryptionMethod(EncryptionMethod.AES);
        ZipFile zipFile = new ZipFile(cz, pwd.toCharArray());
        zipFile.addFolder(new File(fl), prmts);
    }

    public void extractzip(String cz, String pwd, String dst) throws ZipException {//cz:compressed.zip pwd:password dst:folder destination
        ZipFile zipFile = new ZipFile(cz, pwd.toCharArray());
        zipFile.extractAll(dst);
    }
}
