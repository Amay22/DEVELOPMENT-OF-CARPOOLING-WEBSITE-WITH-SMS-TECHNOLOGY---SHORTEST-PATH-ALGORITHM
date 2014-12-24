<%@ page import ="java.sql.*" %>
<%
    String id = "" + session.getAttribute("userID");

    session.setAttribute("userpwd", request.getParameter("pwd"));
    session.setAttribute("userHouseNo", request.getParameter("HouseNo"));
    session.setAttribute("userHomeAddr", request.getParameter("pac-input"));
    session.setAttribute("userMobile", request.getParameter("mobile"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    String home = request.getParameter("homelat");
    home = home + "," + request.getParameter("homelng");
    session.setAttribute("userHomeLatLng", home);
    int i = st.executeUpdate("UPDATE  customer set pwd = '" + request.getParameter("pwd")
            + "', HouseNo = '" + request.getParameter("HouseNo")
            + "', HomeAddr = '" + request.getParameter("pac-input")
            + "', mobile = '" + request.getParameter("mobile")
            + "', homelatlng = '" + home
            + "' where C_id = " + id + ";");
    response.sendRedirect("EditProfile.jsp?ed=1");
%> 