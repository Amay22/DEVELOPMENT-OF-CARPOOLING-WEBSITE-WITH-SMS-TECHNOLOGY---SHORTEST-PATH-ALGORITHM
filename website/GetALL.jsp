<%@ page import ="java.sql.*" %>
<%
    String id = "" + session.getAttribute("userID");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from groups where C_id !="+id+" ;");
    String from = "",to="",stime="",etime="";
    if (rs.next()) {
        from = ("" + rs.getString("name")).substring(0,("" + rs.getString("name")).indexOf("TO"));
        to = ("" + rs.getString("name")).substring(("" + rs.getString("name")).indexOf("TO")+2);
        stime = "" + rs.getString("start_time");
        etime = "" + rs.getString("end_time");
%>
        <table><tr><td><font color="black" ><strong>COUNTRY</strong></font></td><td><font color="black" ><strong>FROM</strong></font></td><td><font color="black" ><strong>TO</strong></font></td><td><font color="black" ><strong>STARTS</strong></font></td><td><font color="black" ><strong>STOPS</strong></font></td><td><font color="black" ><strong>JOIN</strong></font></td></tr>
        <tr><td><font color="black" ><strong><%="" + rs.getString("country") %></strong></font></td><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><font color="black" ><strong><%="" + stime %></strong></font></td><td><font color="black" ><strong><%="" + etime %></strong></font></td><td>
        <a href="#" data-toggle="modal" data-target="#JoiningModal"><button type="button" value="<%=""+rs.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-success" ><i class="glyphicon glyphicon-plus-sign"></i>&nbsp;&nbsp;JOIN ME</button></a></td></tr>
<%
        while (rs.next()) {
            from = ("" + rs.getString("name")).substring(0,("" + rs.getString("name")).indexOf("TO"));
        to = ("" + rs.getString("name")).substring(("" + rs.getString("name")).indexOf("TO")+2);
        stime = "" + rs.getString("start_time");
        etime = "" + rs.getString("end_time");
%>        
        <tr><td><font color="black" ><strong><%="" + rs.getString("country") %></strong></font></td><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><font color="black" ><strong><%="" + stime %></strong></font></td><td><font color="black" ><strong><%="" + etime %></strong></font></td><td>
        <a href="#" data-toggle="modal" data-target="#JoiningModal"><button type="button" value="<%=""+rs.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-success" ><i class="glyphicon glyphicon-plus-sign"></i>&nbsp;&nbsp;JOIN ME</button></a></td></tr>
<%
        }
} else {
%>
<font color="red" ><strong> No Rides at ALL</strong></font><BR>

<%
    }
%>
</table>
