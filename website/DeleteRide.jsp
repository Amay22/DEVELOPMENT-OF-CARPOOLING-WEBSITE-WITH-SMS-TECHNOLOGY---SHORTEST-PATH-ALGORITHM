<%@ page import ="java.sql.*" %>
<%@page import="Route.Mail"%>
<%@ page import ="java.util.Date" %>
<%
    String user = "" + session.getAttribute("userID");
    String g_id = ("" + request.getParameter("butt")).substring(1).trim();
    String check = ("" + request.getParameter("butt")).substring(0, 1);
    java.util.Date date= new java.util.Date();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    if (check.equals("d")) {
        ResultSet r = st.executeQuery("Select * from groups where G_id=" + g_id + ";");
        r.next();
        Mail.DeletePostedRideMail("" + session.getAttribute("userEmail"), "" + session.getAttribute("userName"), r.getString("name"), g_id);
        int i = st.executeUpdate("DELETE from groups where G_id=" + g_id + ";");
        i = st.executeUpdate("DELETE from cust_group where G_id=" + g_id + ";");
        i = st.executeUpdate("UPDATE  counts set groups=groups-1 where pri=1;");
        response.sendRedirect("welcome.jsp?del=1");
    } else {
        String d = "", n = "";
        ResultSet r = st.executeQuery("Select * from groups where G_id=" + g_id + ";");
        r.next();
        d = r.getString("C_id") + ",";
        n = r.getString("name");

        ResultSet rs = st.executeQuery("Select * from cust_group where G_id = " + g_id + ";");
        while (rs.next()) {
            d += rs.getString("C_id") + ",";
        }
        d = d.substring(0, d.length() - 1);

        Mail.DeleteJoinRideMail("" + session.getAttribute("userEmail"), "" + session.getAttribute("userName"), n, g_id, "" + session.getAttribute("userMobile"));
        String str = ""+session.getAttribute("userName")+"aeiouy"+new Timestamp(date.getTime())+"aeiouySorry, Everyone I am leaving this carpool groupaeiouy"+d+"yuoiea";    
        String start = "";
        String end = "";
        ResultSet rs1 = st.executeQuery("Select * from cust_group where G_id=" + g_id + " AND C_id = " + user + ";");
        if (rs1.next()) {
            start = "" + rs1.getString("Start_User");
            end = "" + rs1.getString("Stop_User");
        }
        int z = st.executeUpdate("DELETE from cust_group where G_id=" + g_id + " AND C_id = " + user + ";");
        z = st.executeUpdate("UPDATE groups SET Messages = concat(Messages, '"+str+"') WHERE G_id = "+g_id+" ;");   
        for (int i = 1; i <= 16; i++) {
            z = st.executeUpdate("UPDATE  groups set p" + i + "= null where p" + i + " = '" + start + "' AND G_id=" + g_id + " ;");
            z = st.executeUpdate("UPDATE  groups set p" + i + "= null where p" + i + " = '" + end + "' AND G_id=" + g_id + " ;");
        }
        z = st.executeUpdate("UPDATE  groups set people_in = people_in - 1 where G_id=" + g_id + " ;");
        response.sendRedirect("welcome.jsp?del=1");
    }
%>