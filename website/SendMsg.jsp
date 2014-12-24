<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date" %>
<%
    int num = Integer.parseInt(""+request.getParameter("i"));
    String gid[] = new String[num];int pos=0;
    String u = "";
    String user = ""+session.getAttribute("userName");
    String str = "";int z = 0;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    java.util.Date date= new java.util.Date();
    for (int i = num; i > 0; i--) {
        if(request.getParameter("groups"+i)!=(null)){  
            gid[pos++] = ""+request.getParameter("groups"+i);
            ResultSet rs = st.executeQuery("select * from cust_group where G_id ="+request.getParameter("groups"+i)+";");
            while(rs.next()){
                u += rs.getString("C_id")+",";
            }
            ResultSet rs1 = st.executeQuery("select * from groups where G_id ="+request.getParameter("groups"+i)+";");
            if(rs1.next()){
                u += rs1.getString("C_id")+",";
            }
        }
    }      
    for(int k = 0 ; k < u.length(); k++ ){
        if(u.charAt(k) != ','){        
        u = u.substring(0,k+1) + u.substring(k+1).replaceAll(u.charAt(k)+",", "");
    }
    }
    if(u.substring(u.length()-1).equals(",")){
        u = u.substring(0,u.length()-1);
    }
    for (int i = 0; i < pos; i++) { 
        str = user+"aeiouy"+new Timestamp(date.getTime())+"aeiouy"+request.getParameter("message")+"aeiouy"+u+"yuoiea";
        z= st.executeUpdate("UPDATE groups SET Messages = concat(Messages, '"+str+"') WHERE G_id = "+gid[i]+" ;");    
    }
        
    if(z > 0) {
        response.sendRedirect("messages.jsp?sent=1"); 
    } else {
        response.sendRedirect("Allreadymember.jsp" );
    }   
%>