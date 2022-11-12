<%-- 
    Document   : aaaabbbbccccdddd
    Created on : Apr 1, 2022, 5:25:14 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="a.cdb"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SGRB</title>
    </head>
    <body>
        <%
            String r = "";
            Connection con = null;
            Statement stmt = null;
            if (true) {
                String q = "CREATE INDEX indx1  ON  purchases ALTER COLUMN quant_saled SET DEFAULT 0";
                String q2 = "CREATE INDEX indx1  ON  purchases_duplicate ALTER COLUMN quant_saled SET DEFAULT 0";
                String q3 = "CREATE INDEX indx1  ON  purchases_events ALTER COLUMN quant_saled SET DEFAULT 0";

                String q4 = "update purchases set quant_saled = 0 where quant_saled is null";
                String q5 = "update purchases_duplicate set quant_saled = 0 where quant_saled is null";
                String q6 = "update purchases_events set quant_saled = 0 where quant_saled is null";

                int x = 0;
                try {
                    con = cdb.getConnection();
                } catch (ClassNotFoundException ex) {
                }
                try {
                    stmt = con.createStatement();
                } catch (SQLException ex) {
                }
                try {
                    /*stmt.executeUpdate(q);                 
                 stmt.executeUpdate(q2); 
                 stmt.executeUpdate(q3);
                 stmt.executeUpdate(q4);                 
                 stmt.executeUpdate(q5); 
                 stmt.executeUpdate(q6);*/
                    stmt.executeUpdate("CREATE INDEX index_client_nr ON clients (client_nr)");
                    stmt.executeUpdate("CREATE INDEX indx1  ON  prices_sales (sector)");
                    stmt.executeUpdate("CREATE INDEX indx2  ON  sales (sector)");
                    stmt.executeUpdate("CREATE INDEX indx3  ON  purchases (sector)");
                    stmt.executeUpdate("CREATE INDEX indx4  ON  expenses (sector)");
                    stmt.executeUpdate("CREATE INDEX indx5  ON  clients (sector)");
                    stmt.executeUpdate("CREATE INDEX indx6  ON  clients_requests (sector)");
                    stmt.executeUpdate("CREATE INDEX indx7  ON  deposits (sector)");
                    stmt.executeUpdate("CREATE INDEX indx8  ON  groups_factories (sector)");
                    stmt.executeUpdate("CREATE INDEX indx9  ON  ms (sector)");
                    stmt.executeUpdate("CREATE INDEX indx10  ON  product_type (sector)");
                    stmt.executeUpdate("CREATE INDEX indx11  ON  products_purchases (sector)");
                    stmt.executeUpdate("CREATE INDEX indx12  ON  prices_sales (sector)");
                    stmt.executeUpdate("CREATE INDEX indx13  ON  purchases_not_used (sector)");
                    stmt.executeUpdate("CREATE INDEX indx14  ON  prices_sales (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx15 ON  sales (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx16  ON  purchases (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx17  ON  expenses (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx18  ON  clients (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx19  ON  clients_requests (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx20  ON  deposits (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx21  ON  groups_factories (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx22  ON  ms (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx23  ON  product_type (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx24  ON  products_purchases (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx25  ON  prices_sales (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx26  ON  purchases_not_used (user_datetime)");
                    stmt.executeUpdate("CREATE INDEX indx27  ON  prices_sales (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx28  ON  sales (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx29  ON  purchases (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx30  ON  expenses (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx31  ON  clients (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx32  ON  clients_requests (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx33  ON  deposits (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx34  ON  groups_factories (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx35  ON  ms (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx36  ON  product_type (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx37  ON  products_purchases (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx38  ON  prices_sales (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx39  ON  purchases_not_used (iduser)");
                    stmt.executeUpdate("CREATE INDEX indx40  ON  prices_sales (removed)");
                    stmt.executeUpdate("CREATE INDEX indx41  ON  sales (removed)");
                    stmt.executeUpdate("CREATE INDEX indx42  ON  purchases (removed)");
                    stmt.executeUpdate("CREATE INDEX indx43  ON  expenses (removed)");
                    stmt.executeUpdate("CREATE INDEX indx47  ON  groups_factories (removed)");
                    stmt.executeUpdate("CREATE INDEX indx50  ON  products_purchases (removed)");
                    stmt.executeUpdate("CREATE INDEX indx51  ON  prices_sales (removed)");                    
                    stmt.executeUpdate("CREATE INDEX indx53  ON  prices_sales (product)");
                    stmt.executeUpdate("CREATE INDEX indx54  ON  sales (article)");
                    stmt.executeUpdate("CREATE INDEX indx55  ON  purchases (article)");
                    stmt.executeUpdate("CREATE INDEX indx56  ON  prices_sales (p_code)");
                    stmt.executeUpdate("CREATE INDEX indx57  ON  sales (p_code)");
                    stmt.executeUpdate("CREATE INDEX indx58  ON  purchases (p_code)");
                    stmt.executeUpdate("CREATE INDEX indx59  ON  prices_sales (barcode)");
                    stmt.executeUpdate("CREATE INDEX indx60  ON  sales (barcode)");
                    stmt.executeUpdate("CREATE INDEX indx61  ON  purchases (barcode)");
                    stmt.executeUpdate("CREATE INDEX indx62  ON  prices_sales (group_factory)");
                    stmt.executeUpdate("CREATE INDEX indx63  ON  sales (group_factory)");
                    stmt.executeUpdate("CREATE INDEX indx64  ON  purchases (group_factory)");
                    stmt.executeUpdate("CREATE INDEX indx52  ON  purchases_not_used (removed)");
                    con.commit();
                    stmt.close();
                    r = "ii: " + r;
                } catch (SQLException e) {
                    r = "ee: " + e.getMessage() + ", " + x;
                }
            }
            /*try {
            con = cdb.getConnection();
            if (con == null) {
            }
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from purchases");
            while (rs.next()) {
                try{
                for(int i = 1; i < 60; i++){
                      String z = rs.getString(i);
                      r += z + ",";
                }
                }catch(Exception ee){}
                r += "<br>";

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
        }*/
        %>
        <%=r%>
    </body>
</html>
