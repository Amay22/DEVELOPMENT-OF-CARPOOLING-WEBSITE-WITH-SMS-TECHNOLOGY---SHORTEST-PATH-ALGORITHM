<%@page import="Route.Mail"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date" %>
<%
    String user = ""+session.getAttribute("userID");
    String source=""+request.getParameter("homelat").trim();
    source=source+","+request.getParameter("homelng").trim();
    String dest=""+request.getParameter("officelat").trim();
    dest=dest+","+request.getParameter("officelng").trim();    
    String id = (""+request.getParameter("gid")).trim();
    int people  = Integer.parseInt(""+request.getParameter("members").trim())+2;
    String dist = ""+request.getParameter("distance1").trim();
    String time = ""+request.getParameter("time1").trim();
    java.util.Date date= new java.util.Date();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    int x = 0,y = 0;
    String name="",stime="", etime="",d="";
    ResultSet rs1 = st.executeQuery("Select * from groups where G_id = "+id+";");
    if(rs1.next()){
        for (int i = 1; i <= 16; i++) { 
            if(rs1.getString("p"+i)==(null) && x ==0){
                x = i;
            }
            if(rs1.getString("p"+i)==(null) && x !=i && y == 0){
                y = i;
                break;
            }
        }
        name=rs1.getString("name");
        stime=rs1.getString("start_time");
        etime=rs1.getString("end_time");
        d = rs1.getString("C_id")+",";
    }       
    ResultSet rs = st.executeQuery("Select * from cust_group where C_id = "+user+" AND G_id = "+id+";");
    if(rs.next()){
        response.sendRedirect("AllreadyMember.jsp"); 
    }else{
        rs = st.executeQuery("Select * from cust_group where G_id = "+id+";");
        while(rs.next()){
            d += rs.getString("C_id")+",";
        }
    }
    d=d.substring(0,d.length()-1);
    String str = ""+session.getAttribute("userName")+"aeiouy"+new Timestamp(date.getTime())+"aeiouyHello, Everyone I have just joined your groupaeiouy"+d+"yuoiea";   
    Mail.JoinRideMail(""+session.getAttribute("userEmail"), ""+session.getAttribute("userName"), name, id, stime, etime,  ""+session.getAttribute("userMobile"));
    int i = st.executeUpdate("insert into cust_group(C_id,G_id,Start_User,Stop_User) values ("+user+"," +id+",'" +source+ "','" + dest + "');");
    i = st.executeUpdate("UPDATE groups SET Messages = concat(Messages, '"+str+"') WHERE G_id = "+id+" ;");   
    i = st.executeUpdate("UPDATE  groups set people_in = "+people+","+"distance="+dist+","+"time="+time+","+"p"+x+"='"+source+"', p"+y+"='"+dest+"' where G_id = "+id+";");
    
    
        
    if(i > 0) {
        response.sendRedirect("welcome.jsp"); 
    } else {
        response.sendRedirect("Allreadymember.jsp" );
    }
%>
