package Route;

import java.util.*;
import java.io.*;

public class GraphMaker {

    Point start;
    Point end;
    Map<Point, HashMap<Point, StreetI>> map;
    HashMap<Point, IntersectionI> isect;
    HashSet<StreetI> streets;

    GraphMaker() {
        map = new HashMap<Point, HashMap<Point, StreetI>>();
        isect = new HashMap<Point, IntersectionI>();
        streets = new HashSet<StreetI>();
    }
    public Point getStart() {
        return this.start;
    }

    public Point getEnd() {
        return this.end;
    }

    public Map<Point, HashMap<Point, StreetI>> getMap() {
        return map;
    }

    public HashMap<Point, IntersectionI> getIsect() {
        return isect;
    }

    public void readFile() throws Exception {
        try {
            Scanner scan = new Scanner(GetRoute.input());
            int lineNum = 0;
            while (scan.hasNextLine()) {
                lineNum++;
                storeData(scan.nextLine(), lineNum);
            }
        } //Throws exceptions if not found or I/O error
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    //Stores data from each line
    private void storeData(String line, int lineNum){
        Scanner scanner = new Scanner(line);
        scanner.useDelimiter(",");
        if (scanner.hasNext()) {
            //sets the start and end points
            if (lineNum == 2) {
                this.start = new Point(Double.parseDouble(scanner.next()),
                        Double.parseDouble(scanner.next()));
                this.end = new Point(Double.parseDouble(scanner.next()),
                        Double.parseDouble(scanner.next()));
            } //stores points into hashmaps 
            //each has a hashset of hashmaps with key: points, values: street
            else if (lineNum > 2) {
                try{
                StreetI s = new Street();
                s.setIdNumber(Integer.parseInt(scanner.next()));
                Point a = new Point(Double.parseDouble(scanner.next()),
                        Double.parseDouble(scanner.next()));
                Point b = new Point(Double.parseDouble(scanner.next()),
                        Double.parseDouble(scanner.next()));
                s.setPoints(a, b);
                s.setLength(Double.parseDouble(scanner.next()));
                s.setTime(Integer.parseInt(scanner.next()));
                s.setName(scanner.next());
                addEdge(a, b, s);
                }catch(Exception e){}
                
            } 
        }
    }
    //Makes an undirected graph using an adjacency list
    public void addEdge(Point a, Point b, StreetI s) {
        HashMap<Point, StreetI> adjacentA = map.get(a);
        HashMap<Point, StreetI> adjacentB = map.get(b);
        if (adjacentA == null && adjacentB != null) {
            adjacentA = new HashMap<Point, StreetI>();
            map.put(a, adjacentA);
        } else if (adjacentA != null && adjacentB == null) {
            adjacentB = new HashMap<Point, StreetI>();
            map.put(b, adjacentB);
        } else if (adjacentA == null && adjacentB == null) {
            adjacentA = new HashMap<Point, StreetI>();
            map.put(a, adjacentA);
            adjacentB = new HashMap<Point, StreetI>();
            map.put(b, adjacentB);
        }
        adjacentA.put(b, s);
        adjacentB.put(a, s);
        streets.add(s);
    }

    public HashSet<StreetI> getStreets() {
        return streets;
    }
    //creates a hashset of all the intersections

    public void setIsect(Map<Point, HashMap<Point, StreetI>> m) {
        //Iterates through key/values of the map
        HashMap<Point, IntersectionI> tempIsect = new HashMap<Point, IntersectionI>();
        for (Point a : m.keySet()) {
            //Sets the location of intersection
            IntersectionI tempI = new Intersection();
            tempI.setPointOfIntersection(a);
            //Sets the streets of intersection
            List<StreetI> tempS = new ArrayList<StreetI>();
            tempS.addAll(m.get(a).values());
            tempI.setStreetList(tempS);
            //Adds new intersection to the hashset
            tempIsect.put(a, tempI);
        }
        isect.putAll(tempIsect);
    }
}
