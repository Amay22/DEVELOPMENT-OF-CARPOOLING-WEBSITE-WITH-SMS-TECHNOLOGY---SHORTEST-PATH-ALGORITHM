package Route;
import java.awt.Desktop;
import java.io.File;
import java.util.*;

public class MapMaker {

    public static void main(String[] args) throws Exception{
        double d = 0;
        GraphMaker g = new GraphMaker();
        g.readFile();
        g.setIsect(g.getMap());
        ShortestPath dijk = new ShortestPath();
        List<IntersectionI> dpath = new ArrayList<IntersectionI>();
        dpath = dijk.compute(g.getIsect().get(g.getStart()), g.getIsect().get(g.getEnd()), g.getMap(), g.getIsect());
        d = ShortestPath.dist;
        MapCoordsHTML.writePoints(dpath, "index.html" , d);
        Desktop.getDesktop().open(new File("index.html"));
        
        AStar a = new AStar();
        dpath = a.compute(g.getIsect().get(g.getStart()), g.getIsect().get(g.getEnd()), g.getMap(), g.getIsect());
        d = AStar.dist;
        MapCoordsHTMLAStar.writePoints(dpath, "index1.html",d);
        Desktop.getDesktop().open(new File("index1.html"));
    }
}
