<%@ page import ="java.sql.*" %>
<%
    String id = "" + session.getAttribute("userID");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from groups where C_id=" + id + ";");
    String from = "",to="";    
    if (rs.next()) {
        from = ("" + rs.getString("name")).substring(0,("" + rs.getString("name")).indexOf("TO"));
        to = ("" + rs.getString("name")).substring(("" + rs.getString("name")).indexOf("TO")+2);        
        %>
        <table><tr><td>
            <font color="black" ><strong>FROM</strong></font> </td><td><font color="black" ><strong>TO</strong></font></td><td><font color="black" ><strong>VIEW</strong></font></td><td><font color="black" ><strong>REMOVE</strong></font></td></tr>
        <tr><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><a href="#" data-toggle="modal" data-target="#ViewModal"><button type="button" value="<%=""+rs.getString("G_id")%>"  onclick="vButton(this.value)" class="btn btn-default btn-lg"><i class="glyphicon glyphicon-eye-open"></i>&nbsp;&nbsp;&nbsp;&nbsp;View</button></a></td><td>
        <a href="#" data-toggle="modal" data-target="#DeletionModal"><button type="button" value="<%="d"+rs.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-warning" ><i class="glyphicon glyphicon-remove"></i>&nbsp;&nbsp;Remove</button></a></td></tr>
<%
        while (rs.next()) {
            from = ("" + rs.getString("name")).substring(0,("" + rs.getString("name")).indexOf("TO"));
        to = ("" + rs.getString("name")).substring(("" + rs.getString("name")).indexOf("TO")+2);    
%>
            <tr><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><a href="#" data-toggle="modal" data-target="#ViewModal"><button type="button" value="<%=""+rs.getString("G_id")%>"  onclick="vButton(this.value)" class="btn btn-default btn-lg"><i class="glyphicon glyphicon-eye-open"></i>&nbsp;&nbsp;&nbsp;&nbsp;View</button></a></td><td>
        <a href="#" data-toggle="modal" data-target="#DeletionModal"><button type="button" value="<%="d"+rs.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-warning" ><i class="glyphicon glyphicon-remove"></i>&nbsp;&nbsp;Remove</button></a></td></tr>
<%
    }
} else {
%>
<font color="red" ><strong> No Posted Rides</strong></font><BR>

<%
    }
%>
</table>
<h3>Member of Carpool Group</h3>
<%
ResultSet rs1 = st.executeQuery("select g.name,g.G_id from cust_group c , groups g  where g.G_id=c.G_id AND c.C_id=" + id + ";");
if (rs1.next()) {
    from = ("" + rs1.getString("name")).substring(0,("" + rs1.getString("name")).indexOf("TO"));
        to = ("" + rs1.getString("name")).substring(("" + rs1.getString("name")).indexOf("TO")+2);   
        %>
        <table><tr><td>
            <font color="black" ><strong>FROM</strong></font> </td><td><font color="black" ><strong>TO</strong></font></td><td><font color="black" ><strong>VIEW</strong></font></td><td><font color="black" ><strong>REMOVE</strong></font></td></tr>
        <tr><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><a href="#" data-toggle="modal" data-target="#ViewModal"><button type="button" value="<%=""+rs1.getString("G_id")%>"  onclick="vButton(this.value)" class="btn btn-default btn-lg"><i class="glyphicon glyphicon-eye-open"></i>&nbsp;&nbsp;&nbsp;&nbsp;View</button></a></td><td>
        <a href="#" data-toggle="modal" data-target="#DeletionModal"><button type="button" value="<%="c"+rs1.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-warning" ><i class="glyphicon glyphicon-remove"></i>&nbsp;&nbsp;Remove</button></a></td></tr>
<%
        while (rs1.next()) {
            from = ("" + rs1.getString("name")).substring(0,("" + rs1.getString("name")).indexOf("TO"));
        to = ("" + rs1.getString("name")).substring(("" + rs1.getString("name")).indexOf("TO")+2);    
%>
        <tr><td><font color="black" ><strong><%="" + from %></strong></font></td><td><font color="black" ><strong><%="" + to %></strong></font></td><td><a href="#" data-toggle="modal" data-target="#ViewModal"><button type="button" value="<%=""+rs1.getString("G_id")%>"  onclick="vButton(this.value)" class="btn btn-default btn-lg"><i class="glyphicon glyphicon-eye-open"></i>&nbsp;&nbsp;&nbsp;&nbsp;View</button></a></td><td>
        <a href="#" data-toggle="modal" data-target="#DeletionModal"><button type="button" value="<%="c"+rs1.getString("G_id")%>" onclick="whichButton(this.value)" class="btn btn-lg btn-warning" ><i class="glyphicon glyphicon-remove"></i>&nbsp;&nbsp;Remove</button></a></td></tr>
<%
    }
} else {
%>
<font color="red" ><strong> No Carpool Group</strong></font><BR>

<%
    }
%>
        </table>