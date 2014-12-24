package Route;

import java.sql.*;

public class MessageParser {

    public static String messages = "";
    int position = 0;

    public static int unread(int user) throws Exception {
        fetchMessages(user);
        String tmp = messages;
        int count = 0;       
        while (tmp != null && tmp.indexOf("yuoiea") > 0) {
            tmp = tmp.substring(0, tmp.lastIndexOf("yuoiea") + 1);
            if (tmp.substring(tmp.lastIndexOf("aeiouy")).contains("y" + user + ",")
                    || tmp.substring(tmp.lastIndexOf("aeiouy")).contains("," + user + "y")
                    || tmp.substring(tmp.lastIndexOf("aeiouy")).contains("," + user + ",")
                    || tmp.substring(tmp.lastIndexOf("aeiouy")).contains("y" + user + "y")) {
                count++;
            }
        }
        return count;
    }

    public static void fetchMessages(int user) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        messages = "";
        ResultSet rs = st.executeQuery("select * from groups where C_id =" + user + " ;");
        if (rs.next()) {
            messages = rs.getString("Messages");
        }
        String gid[] = new String[50];
        int pos = 0;
        ResultSet rs1 = st.executeQuery("select * from cust_group where C_id =" + user + " ;");
        while (rs1.next()) {
            gid[pos++] = rs1.getString("G_id");
        }
        while (pos >= 0) {
            ResultSet rs2 = st.executeQuery("select * from groups where G_id =" + gid[pos--] + " ;");
            if (rs2.next()) {
                messages += rs2.getString("Messages");
            }
        }
    }

    public static void read(int user, String msg) throws Exception {
        msg += "aeiouy";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from groups where C_id =" + user + " ;");
        int gid = 0;
        String txt = "";
        String tmp = "";
        String m = "", m2 = "", m3 = "";
        if (rs.next()) {
            txt = rs.getString("Messages");
            gid = Integer.parseInt(rs.getString("G_id"));
        }
        if (txt.contains(msg)) {
            m = txt.substring(0, txt.indexOf(msg) + msg.length());
            m2 = txt.substring(txt.indexOf(msg) + msg.length());
            m2 = m2.substring(0, m2.indexOf("aeiouy") + 6);
            tmp = txt.substring(txt.indexOf(msg) + msg.length());
            m3 = tmp.substring(tmp.indexOf("yuoiea"));
            tmp = tmp.substring(tmp.indexOf("aeiouy") + 5);
            tmp = tmp.substring(0, tmp.indexOf("yuoiea") + 1);
            tmp = tmp.replace("y" + user + ",", "");
            tmp = tmp.replace("," + user + "y", "");
            tmp = tmp.replace("," + user + ",", ",");
            tmp = tmp.replace("y" + user + "y", "");
            tmp = tmp.replace("y", "");
            txt = m + m2 + tmp + m3;            
            int z = st.executeUpdate("UPDATE groups SET Messages = '" + txt + "' WHERE G_id = " + gid + " ;");
            return;
        }

        String gids[] = new String[50];
        int pos = 0;
        ResultSet rs1 = st.executeQuery("select * from cust_group where C_id =" + user + " ;");
        while (rs1.next()) {
            gids[pos++] = rs1.getString("G_id");
        }
        
        while (pos >= 0) {
            ResultSet rs2 = st.executeQuery("select * from groups where G_id =" + gids[pos--] + " ;");
            if (rs2.next()) {
                txt = rs2.getString("Messages");            
            if (txt.contains(msg)){                
                m = txt.substring(0, txt.indexOf(msg) + msg.length());
                m2 = txt.substring(txt.indexOf(msg) + msg.length());
                m2 = m2.substring(0, m2.indexOf("aeiouy") + 6);
                tmp = txt.substring(txt.indexOf(msg) + msg.length());
                m3 = tmp.substring(tmp.indexOf("yuoiea"));
                tmp = tmp.substring(tmp.indexOf("aeiouy") + 5);
                tmp = tmp.substring(0, tmp.indexOf("yuoiea") + 1);
                tmp = tmp.replace("y" + user + ",", "");
                tmp = tmp.replace("," + user + "y", "");
                tmp = tmp.replace("," + user + ",", ",");
                tmp = tmp.replace("y" + user + "y", "");
                tmp = tmp.replace("y", "");
                txt = m + m2 + tmp + m3;                
                int z = st.executeUpdate("UPDATE groups SET Messages = '" + txt + "' WHERE G_id = " + gids[pos + 1] + " ;");
            }
            }
        }

    }
}
