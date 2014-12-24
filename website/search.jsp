<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import ="Route.*" %>

<%
    String user = ""+session.getAttribute("userID");
    String days="";
    for(int i = 1 ; i <= 7 ; i++){
        if(!request.getParameter("day"+i).equals("null")){            
            days += ""+i;
        }
    }            
    String str = AddGroup.getCustGroups(user,"" + request.getParameter("homelat"), "" + request.getParameter("homelng"), "" + request.getParameter("officelat"), "" + request.getParameter("officelng"), days, request.getParameter("stime").trim() + ":00");    
    Scanner scanner = new Scanner(str);
    scanner.useDelimiter("`");
    while (scanner.hasNext()) {
%>
        <font color="black" ><strong><%="" + scanner.next()%></strong></font>
        <a href="#" data-toggle="modal" data-target="#JoiningModal"><button type="button" value="<%="" + scanner.next()%>" onclick="whichButton(this.value)" class="btn btn-default" >Join Me</button></a><BR>
           
<%
       return; }
%>
        <font color="red" ><strong> No Rides Came back Compatible to your search Parameters</strong></font>

