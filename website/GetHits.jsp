<%@ page import ="java.sql.*" %>
<%    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    int i = st.executeUpdate("UPDATE  counts set hits=hits+1 where pri=1;");    
    ResultSet rs = st.executeQuery("Select * from counts where pri=1;");    
    String hits="",user="",groups="";
    if(rs.next()){
        hits = rs.getString("Hits");
        user = rs.getString("Users");
        groups = rs.getString("groups");
    }        
%>
<input type="hidden" name="hits" id="hits" value="<%=hits%>"/>
<input type="hidden" name="user" id="user" value="<%=user%>"/>
<input type="hidden" name="groups" id="groups" value="<%=groups%>"/>