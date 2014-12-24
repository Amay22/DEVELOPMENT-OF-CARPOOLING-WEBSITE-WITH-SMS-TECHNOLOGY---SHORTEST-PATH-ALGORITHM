<%@ page import ="java.sql.*" %>
<%@ page import ="Route.*" %>
<%
    String email = request.getParameter("emailsign");    
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from customer where email='"+email+"' AND pwd='"+pwd+"';");
    if (rs.next()) {
        session.setAttribute("userEmail", email);
        session.setAttribute("userpwd", pwd);
        session.setAttribute("userName", rs.getString("first")+" "+rs.getString("last"));
        session.setAttribute("userID", rs.getString("C_id"));
        session.setAttribute("userHouseNo", rs.getString("HouseNo"));    
        session.setAttribute("userHomeAddr", rs.getString("HomeAddr"));       
        session.setAttribute("userHomeLatLng", rs.getString("homelatlng"));        
        session.setAttribute("userMobile", rs.getString("mobile"));
        session.setAttribute("userGender", rs.getString("gender"));        
        session.setAttribute("NumMessages", MessageParser.unread(Integer.parseInt(rs.getString("C_id"))));
        response.sendRedirect("welcome.jsp");
    }else {
        response.sendRedirect("UserDoesntExist.jsp");
    }
%>
