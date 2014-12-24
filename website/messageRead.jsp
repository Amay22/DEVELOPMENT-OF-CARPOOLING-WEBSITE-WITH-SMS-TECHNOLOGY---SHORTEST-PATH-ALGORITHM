<%@ page import ="java.sql.*" %>
<%@ page import ="Route.*" %>
<%    
    MessageParser.read(Integer.parseInt(""+session.getAttribute("userID")), ""+request.getParameter("n"));
    
%>