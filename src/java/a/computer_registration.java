/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package a;

/**
 *
 * @author HP
 */
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class computer_registration {

    public String computer_macc_address() {
        InetAddress ip;
        StringBuilder sb = new StringBuilder();
        try {

            ip = InetAddress.getLocalHost();
            //System.out.println("Current IP address : " + ip.getHostAddress());

            NetworkInterface network = NetworkInterface.getByInetAddress(ip);

            byte[] mac = network.getHardwareAddress();

            //System.out.print("Current MAC address : ");
            try {
                for (int i = 0; i < mac.length; i++) {
                    sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
                }
            } catch (Exception e) {
            }
            //System.out.println(sb.toString());

        } catch (UnknownHostException e) {

            e.printStackTrace();

        } catch (SocketException e) {

            e.printStackTrace();

        }

        return sb.toString();

    }

    public String computer_name() throws UnknownHostException {
        String hostname = null;
        try {
            InetAddress addr;
            addr = InetAddress.getLocalHost();
            hostname = addr.getHostName();
            //System.out.println(hostname);
            //System.out.println(System.getProperty("user.name"));

        } catch (UnknownHostException e) {
        }
        return hostname;
    }

    public String user_name() throws UnknownHostException {
        String user_name = null;
        InetAddress addr;
        addr = InetAddress.getLocalHost();
        //hostname = addr.getHostName();
        //System.out.println(hostname);
        user_name = System.getProperty("user.name");
        return user_name;
    }

    public String computer_name_mac_address() {
        String a = "";
        computer_registration c = new computer_registration();
        try {
            a = "" + c.computer_name() + c.computer_macc_address();
        } catch (UnknownHostException ex) {
        }
        return a;
    }

    public String[] computer_name_mac_addresses() throws SocketException {
        String[] a = new String[3];
        int j = 0;
        computer_registration c = new computer_registration();
        Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
        while (networkInterfaces.hasMoreElements()) {
            NetworkInterface ni = networkInterfaces.nextElement();
            byte[] hardwareAddress = ni.getHardwareAddress();
            if (hardwareAddress != null) {
                String[] hexadecimalFormat = new String[hardwareAddress.length];
                for (int i = 0; i < hardwareAddress.length; i++) {
                    hexadecimalFormat[i] = String.format("%02X", hardwareAddress[i]);
                }
                String mc = String.join("-", hexadecimalFormat);
                try {
                    if(!mc.equalsIgnoreCase(c.computer_macc_address())){
                         a[j] = "" + c.computer_name() + mc;
                         //System.out.println(a[j]);
                    }                    
                } catch (UnknownHostException ex) {
                }
                j = j + 1;
            }
        }
        return a;
    }
}
