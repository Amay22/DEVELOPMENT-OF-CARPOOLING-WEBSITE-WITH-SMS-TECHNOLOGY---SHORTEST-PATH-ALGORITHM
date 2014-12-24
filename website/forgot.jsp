<%@ page import ="Route.*" %>
<%
    
    Mail.forgotPass(request.getParameter("email1"));
    response.sendRedirect("TYReg.jsp?e="+request.getParameter("email1"));
%>
