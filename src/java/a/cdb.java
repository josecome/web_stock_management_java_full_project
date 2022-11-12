package a;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;
import java.sql.Connection;
import org.apache.commons.dbcp.BasicDataSource;
import org.hsqldb.Server;
import org.hsqldb.persist.HsqlProperties;
import org.hsqldb.server.ServerAcl.AclFormatException;

public class cdb {

    //private static final String jdbcURL = "jdbc:hsqldb:hsql://localhost/sgrb";
    private static final String jdbcURL = "jdbc:hsqldb:file:" + Strngs.dbfolder + ";sql.syntax_mys=true";
    private static final String jdbcUsername = "SA";
    private static final String jdbcPassword = "";

    public static Connection getConnection() throws ClassNotFoundException {
        Connection connection = null;
        Class.forName("org.hsqldb.jdbcDriver");

        try {
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            //System.err.println("Connected Successfully!");
        } catch (SQLException e) {
            //System.err.println("Erro de conexao: " + e.getMessage());
            /*ProcessBuilder processBuilder = new ProcessBuilder();
            // Windows
            Values vls = new Values();
            String abpth = vls.getPathIrprt() + "\\webapps\\SGRB\\WEB-INF\\";
            if (abpth.contains("Apache Tomcat 8.0.27")) {
                abpth = "C:\\Users\\Admin\\Documents\\drivers\\sgrb\\hsqldb-2.6.1\\hsqldb-2.6.1\\hsqldb\\";
            }

            String cmmd = "java -classpath \"" + abpth + "lib\\hsqldb-jdk8.jar\" org.hsqldb.server.Server --database.0 file:hsqldb/sgrb --dbname.0 sgrb";
            System.err.println(cmmd);
            processBuilder.command("cmd.exe", "/c", cmmd);
            try {
                Process process = processBuilder.start();
                BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }
                int exitCode = process.waitFor();
                System.out.println("\nExited with error code : " + exitCode);

            } catch (IOException | InterruptedException ex) {
                e.printStackTrace();
            }*/
        }
        return connection;
    }

    /* private static final BasicDataSource dataSource = new BasicDataSource();

    static {
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/sgrb");
        dataSource.setUsername(Strngs.db);
        dataSource.setPassword(Strngs.pwd);
        //the settings below are optional -- dbcp can work with defaults
        //dataSource.setMinIdle(5);
        //dataSource.setMaxIdle(20);
        dataSource.setMaxActive(140);
        //dataSource.setMaxOpenPreparedStatements(180);
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }*/
    public static void devolveConnection(Connection con) throws SQLException {
        // Closing Connection Object
        if (con != null) {
            con.close();
        }
    }
}
