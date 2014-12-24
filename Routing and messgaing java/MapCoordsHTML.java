package Route;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class MapCoordsHTML {

    public static void writePoints(List<IntersectionI> list, String filename , double d) {
        try {
            BufferedWriter out = new BufferedWriter(new FileWriter(filename));
            //write heading to js file
            out.write("<html> <head> <title>Final Project</title><script src=\"https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false\"></script>");
            out.newLine();
            out.write("<script>function initialize() {var myLatLng = new google.maps.LatLng("+list.get(0).getLocation().getX()+","+list.get(0).getLocation().getY()+");var mapOptions = {zoom: 15,center: myLatLng,panControl: true,zoomControl: true,scaleControl: true,mapTypeId: google.maps.MapTypeId.ROADMAP};");
            out.newLine();
            out.write("var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);");
            out.newLine();
            out.write("var pathPoints = [");
            out.newLine();
            //write the points
            for (int i = 0; i < list.size(); i++) {
                out.write("new google.maps.LatLng(" + list.get(i).getLocation().getX());
                if(i == list.size() - 1 ){out.write("," + list.get(i).getLocation().getY() +")");break;}
                out.write("," + list.get(i).getLocation().getY() +"),");
            }
            out.write("];");
            out.newLine();
            out.write("var RoutePath = new google.maps.Polyline({path: pathPoints,strokeColor: '#000000',strokeOpacity: 1.0,strokeWeight: 2});");
            out.newLine();
            out.write("RoutePath.setMap(map);};google.maps.event.addDomListener(window, 'load', initialize);</script></head>");
            out.newLine();
            out.write("  <body>SHORTEST PATH using DIJIKSTA'S<div id=\"map-canvas\" style=\"width:1200px;height:650px;border:solid black 1px;\"></div><BR> Distance = "+d+"</body></html>");
            out.newLine();
            out.close();
        } catch (IOException e) {
            throw new RuntimeException("cannot write file: " + filename, e);
        }
    }
}
