package Route;

import java.util.*;

public class AStar {

    List<IntersectionI> shortest;
    PriorityQueue<Vertex> closed;
    PriorityQueue<Vertex> open;
    HashSet<Vertex> traveled;
    static double dist = 0;
    //Constructor for ShortestPath
    public AStar() {
        shortest = new ArrayList<IntersectionI>();
        closed = new PriorityQueue<Vertex>();
        open = new PriorityQueue<Vertex>(1000, new Comparator<Vertex>() {                   
            @Override
            public int compare(Vertex o1, Vertex o2) {
                return Double.compare(o1.actualCost, o2.actualCost);                
            }
        });
        traveled = new HashSet<Vertex>();
    }

    //Creates Vertex class
    class Vertex implements Comparable<Vertex> {

        Point value;
        Vertex previous;
        double heurCost;
        double actualCost;

        public Point getValue() {
            return value;
        }

        public void setValue(Point value) {
            this.value = value;
        }       
        public Vertex getPrevious() {
            return previous;
        }

        public void setPrevious(Vertex previous) {
            this.previous = previous;
        }

        public double getHeurCost() {
            return heurCost;
        }

        public double getActualCost() {
            return actualCost;
        }

        public void setHeurCost(double heurCost) {
            this.heurCost = heurCost;
        }

        public void setActualCost(double actualCost) {
            this.actualCost = actualCost;
        }

        public int compareTo(Vertex arg0) {
            return Double.compare(actualCost + heurCost, arg0.actualCost + arg0.heurCost);
        }

        public boolean equals(Vertex v) {
            if (this.value.equals(v.value)) {
                return true;
            } else {
                return false;
            }
        }
    }

    //Find shortest path using modified Dijkstra's
    //When calculating costs, also takes into account heuristic values from current node to end
    //Along with priority queue data structure, not needing to traverse through all N nodes reduces running time
    public List<IntersectionI> compute(IntersectionI start, IntersectionI end, Map<Point, HashMap<Point, StreetI>> map, HashMap<Point, IntersectionI> isect) {
        //Store first point in open list        
        Vertex current = new Vertex();        
        current.setValue(start.getLocation());
        current.setPrevious(null);
        current.setActualCost(0);
        current.setHeurCost(computeDist(current.getValue(), end.getLocation()));
        closed.add(current);
        //Updates queues based on current point       
        while(!current.getValue().equals(end.getLocation())){
            for (Point p : map.get(current.value).keySet()) {                
                Point adjacent = new Point(p.getX(), p.getY());
                //Sets values for vertex of adjacent node      
                Vertex adj = new Vertex();
                adj.setValue(adjacent);
                adj.setPrevious(current);
                adj.setActualCost(current.actualCost + map.get(current.value).get(p).getLength() + computeDist(current.getValue(), adjacent));
                //adj.setActualCost(current.actualCost + computeDist(current.getValue(), adjacent));
                adj.setHeurCost(computeDist(adjacent, end.getLocation())); 
                open.add(adj);                                                                           
            }                        
            Iterator<Vertex> itr1 = closed.iterator();
            Vertex closeV = new Vertex();
            //Iterates through values stored in open and closed to find same object
            while (itr1.hasNext()) {
                closeV = itr1.next();
                Iterator<Vertex> itr = open.iterator();
                Vertex openV = new Vertex();
                while (itr.hasNext()) {
                    openV = itr.next();
                    if (openV.getValue().getX() == closeV.getValue().getX() && openV.getValue().getY() == closeV.getValue().getY()){                        
                        itr.remove();
                    }
                }
            }             
            closed.add(current = open.poll());            
            open.removeAll(open);
        }
        dist = current.getActualCost();
        return construct(current, isect);
    }

    public double computeDist(Point a, Point b) {
        return Math.sqrt(Math.pow(b.getX() - a.getX(), 2) + Math.pow(b.getY() - a.getY(), 2));
    }

    //Constructs a list given the end vertex
    public List<IntersectionI> construct(Vertex v, HashMap<Point, IntersectionI> isect) {
        Stack<IntersectionI> reverse = new Stack<IntersectionI>();
        while (v != null) {
            IntersectionI temp = new Intersection();
            temp.setPointOfIntersection(v.getValue());
            temp.setStreetList(isect.get(v.value).getStreetList());
            reverse.add(temp);
            v = v.getPrevious();
        }
        while (!reverse.isEmpty()) {
            shortest.add(reverse.pop());
        }
        return shortest;
    }
}
