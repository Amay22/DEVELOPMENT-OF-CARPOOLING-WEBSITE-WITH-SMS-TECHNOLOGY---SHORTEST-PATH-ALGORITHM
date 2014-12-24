<%@ page import ="java.sql.*" %>
<%
    String g_id = ("" + request.getParameter("del")).trim();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    String homelat1 = "" + request.getParameter("homelat");
    String homelng1 = "" + request.getParameter("homelng");
    String officelat1 = "" + request.getParameter("officelat");
    String officelng1 = "" + request.getParameter("officelng");
    ResultSet rs = st.executeQuery("select * from groups where G_id=" + g_id + ";");
    
    String driverName = "";
    String driverPhone = "";
    String driverEmail = "";
    int j = 0;
    if (rs.next()) {
        j = Integer.parseInt(rs.getString("people_in"));
        ResultSet driv = st.executeQuery("select * from customer where C_id=" + rs.getString("C_id") + ";");        
        if (driv.next()) {
            driverName = (driv.getString("first") + " " + driv.getString("last"));
            driverPhone = driv.getString("email");
            driverEmail = driv.getString("mobile");            
        }
    }    
    ResultSet rs1 = st.executeQuery("select * from groups where G_id=" + g_id + ";");
    String name = "", car = "", stime = "", etime = "", fuel = "", days = "", sourceLat = "", sourceLng = "", destLat = "", destLng = "", points[] = new String[19];
    int i = 1;
    if (rs1.next()) {
        name = "" + rs1.getString("name");
        car = rs1.getString("car_type");
        stime = rs1.getString("start_time");
        etime = rs1.getString("end_time");
        fuel = rs1.getString("fuel_type");
        days = rs1.getString("operation_days");
        String source = rs1.getString("source");
        sourceLat = source.substring(0, source.indexOf(","));
        sourceLng = source.substring(source.indexOf(",") + 1);
        String dest = rs1.getString("dest");
        destLat = dest.substring(0, dest.indexOf(",")).trim();
        destLng = dest.substring(dest.indexOf(",") + 1);
        for (; i < points.length && (rs1.getString("p" + i) != (null)); i++) {
            points[i] = rs1.getString("p" + i);
        }
    }
String url = "joinRide.jsp?homelat=" + homelat1 + "&homelng=" + homelng1 + "&officelat=" + officelat1 + "&officelng=" + officelng1 + "&points=" + i + "&driver="
            + driverName + "&name=" + name + "&car=" + car + "&stime=" + stime + "&etime=" + etime + "&fuel=" + fuel + "&days=" + days + "&sourceLat=" + sourceLat + "&sourceLng="
            + sourceLng + "&destLat=" + destLat + "&destLng=" + destLng + "&usertime=" + request.getParameter("usertime") + "&id=" + g_id+ "&phone=" + driverPhone+ "&email=" + driverEmail+ "&members=" + j;
    for (int k = 1; k < i; k++) {
        url += "&p"+k+"lat" + "=" + points[k].substring(0,points[k].indexOf(","));
        url += "&p"+k+"lng" + "=" + points[k].substring(points[k].indexOf(",")+1);
    }     
    response.sendRedirect(url);
%>