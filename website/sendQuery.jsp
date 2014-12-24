<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="Route.*" %>
<%    
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");            
    Mail.QueryMail(email,name,message); 
    response.sendRedirect("contact.jsp?s=1" );
%>
