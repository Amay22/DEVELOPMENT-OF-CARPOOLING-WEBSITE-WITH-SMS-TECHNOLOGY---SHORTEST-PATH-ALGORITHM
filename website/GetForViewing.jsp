<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>

<%    
    String g_id = ("" + request.getParameter("butt")).trim();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from groups where G_id=" + g_id + ";");
    String driverName = "";
    String driverPhone = "";
    String driverEmail = "";
    int j = 0, i = 1;
    String name = "", car = "", stime = "", etime = "", fuel = "", days = "", sourceLat = "", sourceLng = "", destLat = "", destLng = "", points[] = new String[19];
    if (rs.next()) {
        j = Integer.parseInt(rs.getString("people_in"));
        name = "" + rs.getString("name");
        car = rs.getString("car_type");
        stime = rs.getString("start_time");
        etime = rs.getString("end_time");
        fuel = rs.getString("fuel_type");
        days = rs.getString("operation_days");
        String source = rs.getString("source");
        sourceLat = source.substring(0, source.indexOf(","));
        sourceLng = source.substring(source.indexOf(",") + 1);
        String dest = rs.getString("dest");
        destLat = dest.substring(0, dest.indexOf(",")).trim();
        destLng = dest.substring(dest.indexOf(",") + 1);
        for (; i < points.length && (rs.getString("p" + i) != (null)); i++) {
            points[i] = rs.getString("p" + i);
        }
        ResultSet driv = st.executeQuery("select * from customer where C_id=" + rs.getString("C_id") + ";");
        if (driv.next()) {
            driverName = (driv.getString("first") + " " + driv.getString("last"));
            driverPhone = driv.getString("email");
            driverEmail = driv.getString("mobile");
        }
    }
    
    String url = "ViewARide.jsp?points=" + i + "&driver="
            + driverName + "&name=" + name + "&car=" + car + "&stime=" + stime + "&etime=" + etime
            + "&fuel=" + fuel + "&days=" + days + "&id=" + g_id + "&phone=" + driverPhone
            + "&email=" + driverEmail + "&members=" + j+ "&sourceLat=" + sourceLat + "&sourceLng="
            + sourceLng + "&destLat=" + destLat + "&destLng=" + destLng ;
    for (int k = 1; k < i; k++) {
        url += "&p" + k + "lat" + "=" + points[k].substring(0, points[k].indexOf(","));
        url += "&p" + k + "lng" + "=" + points[k].substring(points[k].indexOf(",") + 1);
    }
    response.sendRedirect(url);
%>