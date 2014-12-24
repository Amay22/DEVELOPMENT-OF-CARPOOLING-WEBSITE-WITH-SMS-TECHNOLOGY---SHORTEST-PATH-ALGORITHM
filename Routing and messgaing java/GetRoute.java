package Route;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Scanner;

public class GetRoute {

    public static String mapData = "";
    public static String in = "";
    public static String RouteParser = "";
    public static String dest = "";
    public static String maps[] = new String[50];
    public static int pos = 0 ;
    
    public static String input() throws Exception {
        String tmp[] = new String[8];
        int pos = -1;
        int points = 0;
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("\nEnter Origin        :  ");
        String or = nameOrLatLng(br.readLine().trim());
        System.out.print("\nEnter Destination   :  ");
        dest = nameOrLatLng(br.readLine().trim());
        dest = ("" + dest.charAt(0)).toUpperCase() + dest.substring(1);
        or = ("" + or.charAt(0)).toUpperCase() + or.substring(1);
        System.out.print("\nEnter Stops(or n)   :  ");
        while (((pos++) < tmp.length) && !(tmp[pos] = nameOrLatLng(br.readLine().trim())).equalsIgnoreCase("n")) {
            System.out.print("\nEnter Stops(or n)   :  ");
        }
        in = "http://maps.googleapis.com/maps/api/directions/json?origin=" + or + "&destination=" + dest;
        if (pos != 0) {
            in += "&waypoints=optimize:true|";
            for (int i = 0; i <= pos && i < tmp.length && !tmp[i].equalsIgnoreCase("n"); i++) {
                in += tmp[i] + "|";
                points++;
            }
            in = in.substring(0, in.length() - 1);
        }
        in += "&alternatives=true&mode=driving&units=metrics&sensor=false";        
        //System.out.println(in);
        return UrlConn();
    }

    public static String nameOrLatLng(String xy) throws Exception {
        if (xy.charAt(0) > '0' && xy.charAt(0) < '9') {
            xy = xy.replaceAll(" ", "");
        } else {
            xy = xy.replaceAll(" ", "+");
        }
        return xy;
    }

    public static String UrlConn() throws Exception {
        URL url = new URL(in);
        URLConnection urlConnection = url.openConnection();
        BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
        String inputLine;
        while ((inputLine = br.readLine()) != null) {
            mapData += inputLine.trim();
        }        
        br.close();
        return makefile();
    }

    public static String makefile() throws Exception {
        int idx = 1;
        String tmp = mapData, toWrite = "FORMAT: fid, endPt1lat, endPt1lon, endPt2lat, endPt2lon dist time name", xy = "";
        RouteParser += toWrite + "\n";
        toWrite = tmp.substring(tmp.lastIndexOf("end_location"));
        xy = (toWrite.substring(toWrite.indexOf("lat") + 7, toWrite.indexOf(",")) + "," + toWrite.substring(toWrite.indexOf("lng") + 7, toWrite.indexOf("}"))).trim();
        toWrite = tmp.substring(tmp.indexOf("start_location"));
        xy = (toWrite.substring(toWrite.indexOf("lat") + 7, toWrite.indexOf(",")) + "," + toWrite.substring(toWrite.indexOf("lng") + 7, toWrite.indexOf("}"))).trim() + "," + xy;
        RouteParser += xy + "\n";
        while (mapData.contains("legs") == true) {
            tmp = mapData;
            tmp = mapData.substring(mapData.indexOf("legs"), mapData.indexOf("overview_polyline"));
            while (mapData.contains("steps") == true) {
                tmp = mapData.substring(mapData.indexOf("steps"), mapData.indexOf("via_waypoint"));
                while (tmp.contains("distance") == true) {
                    toWrite = tmp.substring(tmp.indexOf("value") + 9, tmp.indexOf("},")).trim() + ",";
                    tmp = tmp.substring(tmp.indexOf("},") + 2);
                    toWrite += tmp.substring(tmp.indexOf("value") + 9, tmp.indexOf("},")).trim() + ",";
                    tmp = tmp.substring(tmp.indexOf("},") + 2);
                    toWrite = (tmp.substring(tmp.indexOf("lat") + 7, tmp.indexOf(",")) + "," + tmp.substring(tmp.indexOf("lng") + 7, tmp.indexOf("}"))).trim() + "," + toWrite;
                    tmp = tmp.substring(tmp.indexOf("},") + 2);
                    xy = tmp.substring(tmp.indexOf("html_instructions"), tmp.indexOf("polyline"));
                    tmp = tmp.substring(tmp.indexOf("},") + 2);
                    while (xy.indexOf("\\u003cb\\u003e") > 0) {
                        xy = xy.substring(xy.indexOf("\\u003cb\\u003e") + "\\u003cb\\u003e".length());
                        toWrite += " " + xy.substring(0, xy.indexOf("\\u003c/b\\u003e"));
                        xy = xy.substring(xy.indexOf("h\\u003c/b\\u003e") + "h\\u003c/b\\u003e".length());
                    }
                    toWrite = (idx++) + "," + (tmp.substring(tmp.indexOf("lat") + 7, tmp.indexOf(",")) + "," + tmp.substring(tmp.indexOf("lng") + 7, tmp.indexOf("}"))).trim() + "," + toWrite;
                    tmp = tmp.substring(tmp.indexOf("DRIVING"));
                    tmp = tmp.substring(tmp.indexOf("},") + 2);
                    RouteParser += toWrite + "\n";
                }
                mapData = mapData.substring(mapData.indexOf("via_waypoint") + "via_waypoint".length());
            }
            mapData = mapData.substring(mapData.indexOf("overview_polyline"));
            if (mapData.indexOf("legs") > 0) {
                mapData = mapData.substring(mapData.indexOf("legs"));
            } else {
                break;
            }
        }
        //System.out.println(RouteParser);
        return RouteParser;
    }
}
