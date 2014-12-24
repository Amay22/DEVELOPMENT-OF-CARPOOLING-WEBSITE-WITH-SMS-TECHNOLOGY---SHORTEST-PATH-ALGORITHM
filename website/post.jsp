<%@ page import ="java.sql.*" %>
<%@ page import ="Route.*" %>
<%
    String user = ""+session.getAttribute("userID");
    int c_id = Integer.parseInt(user);
    String from = ""+request.getParameter("FromInput").trim() ;
    String name = from + "  TO  " + request.getParameter("ToInput");
    String country = from.substring(from.lastIndexOf(",")+1).trim();
    from = from.substring(0,from.lastIndexOf(",")).trim();
    from = from.substring(0,from.lastIndexOf(",")).trim();
    String city = from.substring(from.lastIndexOf(",")+1).trim();
    String source=request.getParameter("homelat").trim();
    source=source+","+request.getParameter("homelng").trim();
    String dest=request.getParameter("officelat").trim();
    dest=dest+","+request.getParameter("officelng").trim();    
    String days="";
    for(int i = 1 ; i <= 7 ; i++){
        if(!request.getParameter("day"+i).equals("null")){            
            days += ""+i;
        }
    }        
    String car = request.getParameter("car").trim();
    String stime = request.getParameter("stime").trim()+":00";
    String fuel=request.getParameter("fueltype");
    String etime=request.getParameter("etime").trim()+":00";
    String sdate=request.getParameter("sdate").trim();
    String edate=request.getParameter("edate").trim();
    int capacity=Integer.parseInt(request.getParameter("carcapacity").trim());
    double distance=Double.parseDouble((""+request.getParameter("distance1")).trim());
    double time=Double.parseDouble((""+request.getParameter("time1")).trim());
    source = source.trim();
    dest = dest.trim();
    sdate = sdate.substring(6)+"-"+sdate.substring(0,2)+"-"+sdate.substring(3,5);
    edate = edate.substring(6)+"-"+edate.substring(0,2)+"-"+edate.substring(3,5);
    String center = ((Double.parseDouble(source.substring(0,source.indexOf(",")))+ Double.parseDouble(dest.substring(0,dest.indexOf(","))))/2)+"," + ((Double.parseDouble(source.substring(source.indexOf(",")+1))+ Double.parseDouble(dest.substring(dest.indexOf(",")+1)))/2);    
    double eucDist = Math.sqrt(Math.pow(Double.parseDouble(source.substring(0,source.indexOf(","))) - Double.parseDouble(dest.substring(0,dest.indexOf(","))),2) + Math.pow(Double.parseDouble(source.substring(source.indexOf(",")+1)) - Double.parseDouble(dest.substring(dest.indexOf(",")+1)),2));
 
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    int i = st.executeUpdate("UPDATE  counts set groups=groups+1 where pri=1;");
    i = st.executeUpdate("insert into groups(name,C_id, car_type,fuel_type,capacity,start_time,end_time,operation_days,people_in,country,city,source,dest,centre,euc_dist,cost,distance,time,start_date,end_date,messages)"
            + " values ('"+name+"'," +c_id+",'" +car+ "','" + fuel + "',"+ 
            capacity +",'" + stime + "','" + etime + "','" + days + "',1,'"+country+"','"+city+"','"+source+"','"+dest+"','"+center+"',"+eucDist+",0,"+distance+","+time+",'"+sdate+"','"+edate+"','')");
    Mail.PostRideMail(""+session.getAttribute("userEmail"), ""+session.getAttribute("userName"), name, stime, etime);
    if(i > 0) {
        response.sendRedirect("welcome.jsp"); 
    } else {
        response.sendRedirect("Allreadymember.jsp" );
    }
%>
