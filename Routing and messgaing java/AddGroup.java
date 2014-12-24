package Route;
import java.sql.*;
public class AddGroup {    
    
    public static String getCustGroups(String user ,String homelat, String homelng, String officelat, String officelng, String days, String time) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
        Statement st = con.createStatement();
        Point userStart = new Point(Double.parseDouble(homelat), Double.parseDouble(homelng));
        Point userEnd = new Point(Double.parseDouble(officelat), Double.parseDouble(officelng));
        String stime = (Integer.parseInt(time.substring(0, 2)) - 1) + time.substring(2);
        String etime = (Integer.parseInt(time.substring(0, 2)) + 1) + time.substring(2);
        ResultSet rs = st.executeQuery("select * from groups where  operation_days='" + days + "'  AND people_in < capacity AND C_id != "+user+" AND start_time Between '" + stime + "' AND '" + etime + "';");
        String output = "";
        while (rs.next()){
            Point start = new Point(Double.parseDouble(rs.getString("source").substring(0, rs.getString("source").indexOf(","))),
                    Double.parseDouble(rs.getString("source").substring(rs.getString("source").indexOf(",") + 1)));
            Point end = new Point(Double.parseDouble(rs.getString("dest").substring(0, rs.getString("dest").indexOf(","))),
                    Double.parseDouble(rs.getString("dest").substring(rs.getString("dest").indexOf(",") + 1)));
            Point centre = new Point(Double.parseDouble(rs.getString("centre").substring(0, rs.getString("centre").indexOf(","))),
                    Double.parseDouble(rs.getString("centre").substring(rs.getString("centre").indexOf(",") + 1)));
            double euclidean = Double.parseDouble(rs.getString("euc_dist"));
            if ((EllipticalSearch(userStart, userEnd, centre, start, end, euclidean))) {
                output += rs.getString("name")+"`"+rs.getString("G_id")+"`";
            }
        }
        if(output.length() > 1){
            output = output.substring(0,output.length()-1);
        }
        return output;        
    }
    
    public static double EucDist(Point a, Point b) {
        return Math.sqrt(Math.pow(b.getX() - a.getX(), 2) + Math.pow(b.getY() - a.getY(), 2));
    }

    public static boolean RadialSearch(Point user, Point p, double ed) {
        return ((Math.pow(p.getX() - user.getX(), 2)) + (Math.pow(p.getY() - user.getY(), 2))) <= ed;
    }

    public static boolean SameDir(Point userStart, Point userEnd, Point start, Point end) {
        return EucDist(userStart, start) <= EucDist(userStart, end) || EucDist(userEnd, start) >= EucDist(userEnd, end);
    }

    public static boolean EllipticalSearch(Point userSource, Point userDest, Point center, Point start, Point end, double ed) {
        if (SameDir(userSource, userDest, start, end) && RadialSearch(userSource, center, ed) && RadialSearch(userDest, center, ed)) {
            if (start.getX() == end.getX()) {
                start.setX(start.getX() + 0.00001);
            }
            if (start.getY() == end.getY()) {
                start.setY(start.getY() + 0.00001);
            }            
            Point extE = new Point(0, 0), extS = new Point(0, 0);
            double slope, A, extra;
            boolean latbound = true;
            extra = 2000;
            if (extra > (ed / 6)) {
                extra = (ed / 6);
            }
            slope = (start.getY() - end.getY()) / (start.getX() - end.getX());
            if (start.getX() - end.getX() < 0) {
                extS.setX(start.getX() - extra / Math.sqrt(1 + Math.pow(slope, 2)));
                extE.setX(end.getX() + extra / Math.sqrt(1 + Math.pow(slope, 2)));
            } else {
                extS.setX(start.getX() + extra / Math.sqrt(1 + Math.pow(slope, 2)));
                extE.setX(end.getX() - extra / Math.sqrt(1 + Math.pow(slope, 2)));
            }
            if (start.getY() - end.getY() < 0) {
                extS.setY(start.getY() - extra / Math.sqrt(1 + Math.pow(slope, 2)));
                extE.setY(end.getY() + extra / Math.sqrt(1 + Math.pow(slope, 2)));
            } else {
                extS.setY(start.getY() + extra / Math.sqrt(1 + Math.pow(slope, 2)));
                extE.setY(end.getY() - extra / Math.sqrt(1 + Math.pow(slope, 2)));
            }
            A = Math.sqrt(Math.pow((center.getX() - extE.getX()), 2) + Math.pow((center.getY() - extE.getY()), 2));
            if ((extS.getX() - extE.getX()) > (extS.getY() - extE.getY())) {
                latbound = false;
            }
            if (latbound && (((Math.pow(((userSource.getX() - center.getX()) / A), 2)) + (Math.pow(((userSource.getY() - center.getY()) * 2/ A), 2))) <= 1) && (((Math.pow(((userDest.getX() - center.getX()) / A), 2)) + (Math.pow(((userDest.getY() - center.getY()) * 2/ A), 2))) <= 1)) {
                return true;
            } else if (!latbound && (((Math.pow(((userSource.getY() - center.getY()) / A), 2)) + (Math.pow(((userSource.getX() - center.getX()) * 2/ A), 2))) <= 1) && (((Math.pow(((userDest.getY() - center.getY()) / A), 2)) + (Math.pow(((userDest.getX() - center.getX()) * 2/ A), 2))) <= 1)) {
                return true;
            }
        }
        return false;
    }
}
