<%@ page import ="java.sql.*" %>
<%
    String id = "" + request.getParameter("id");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from groups where G_id ="+id+" ;");
    
    if (rs.next()) {         
        String time=""+ rs.getString("start_time");
        time= time.substring(0,5);
%>
    
        <font color="black" ><strong>Name       :   <%="" + rs.getString("name") %></strong></font><br>
        <font color="black" ><strong>Start Time :   <%="" + rs.getString("start_time") %></strong></font><br>
        <font color="black" ><strong>End Time   :   <%="" + rs.getString("end_time") %></strong></font><br>
        <font color="black" ><strong>Car        :   <%="" + rs.getString("car_type") %></strong></font><br>
        <input type="hidden" name="usertime" id="usertime" value="<%=""+time%>"/>
        <input type="hidden" name="del" id="del" value="<%=""+id%>"/>
        <input type="hidden" name="days" id="days" value="<%="" + rs.getString("operation_days") %>"/>
        
<%
        }
%>