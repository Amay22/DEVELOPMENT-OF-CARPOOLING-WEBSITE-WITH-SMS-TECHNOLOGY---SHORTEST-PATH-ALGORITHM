<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="Route.*" %>
<%    
    
    String pwd = request.getParameter("pass1");
    String fname = request.getParameter("first");
    String lname = request.getParameter("last");
    String email = request.getParameter("email");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("datepicker");
    String countrycode = request.getParameter("country");
    String mobile = request.getParameter("mobile");
    String home=request.getParameter("homelat");
    home=home+","+request.getParameter("homelng");
    String houseNo = ""+request.getParameter("HouseNo");
    String HomeAddr = ""+request.getParameter("pac-input");
    Class.forName("com.mysql.jdbc.Driver");    
    dob = dob.substring(6)+"-"+dob.substring(0,2)+"-"+dob.substring(3,5);
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root", "");
    Statement st = con.createStatement();      
    int i = st.executeUpdate("UPDATE  counts set users=users+1 where pri=1;"); 
    i = st.executeUpdate("insert into customer(first, last, email, pwd, CountryCode ,mobile, dob, gender,HouseNo,HomeAddr,homelatlng) values "
            + "('"+fname+"','"+lname+"','"+email+"','"+pwd+"','"+countrycode+"','"+mobile+"','"+dob+"','"+gender+"','"+houseNo+"','"+HomeAddr+"','"+home+"')");    
    Mail.RegMail(email, (fname+" "+lname), pwd, (houseNo+" , "+HomeAddr),  mobile, gender);    
    response.sendRedirect("TYReg.jsp?e="+email);       
%>
