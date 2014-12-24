
<%@ page import ="java.sql.*" %>
<%    
    String email = request.getParameter("val");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root", "");
    Statement st = con.createStatement();      
    ResultSet rs = st.executeQuery("select * from customer where email='"+email+"';");    
    if (rs.next()){          
%>
    <font color="red" ><strong>User already exists</strong></font>
<%
}else{
%>
<font color="green" ><strong> User does not exist</strong></font>
<%
}
%>
