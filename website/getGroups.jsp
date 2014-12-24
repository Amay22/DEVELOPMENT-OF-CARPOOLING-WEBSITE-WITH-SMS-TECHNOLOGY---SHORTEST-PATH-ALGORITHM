<%@ page import ="java.sql.*" %>
<%
    String id = "" + session.getAttribute("userID");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    int i = 0 ;
    ResultSet rs = st.executeQuery("select * from groups where C_id ="+id+" ;");    
    while (rs.next()) {         
        i++;
%>        
        <input class="checkbox-inline" name="groups<%=""+i%>" onchange="return invalidateChecks();" type="checkbox" id="groups<%=""+i%>" value="<%=""+rs.getString("G_id")%>"><%=""+rs.getString("name")%><BR>
                        
<%
    }
    String gid[] = new String[50];int pos = 0;
    ResultSet rs1 = st.executeQuery("select * from cust_group where C_id ="+id+" ;");
    while (rs1.next()) {
        gid[pos++] = rs1.getString("G_id");
    }
     while (pos >= 0) {
        ResultSet rs2 = st.executeQuery("select * from groups where G_id ="+gid[pos--]+" ;");
        
        if (rs2.next()) {     
            i++;
%>
        <input class="checkbox-inline" name="groups<%=""+i%>" onchange="return invalidateChecks();" type="checkbox" id="groups<%=""+i%>" value="<%=""+rs2.getString("G_id")%>"><%=""+rs2.getString("name")%><BR>
<%
        }  } 
    
    if(i==0){
%>
<font color="red" ><strong> Sorry but you are not a member of any rides Hence You cannot send a message</strong></font><BR>
<%
    } 
%>
<input type="hidden" name="i" id="i" value="<%=""+i%>"/>