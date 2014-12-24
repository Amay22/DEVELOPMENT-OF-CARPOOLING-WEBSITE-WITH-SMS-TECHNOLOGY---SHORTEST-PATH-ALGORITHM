package Route;
public interface StreetI {
	
	public void setIdNumber(int id);
	
	public void setName(String name);

	public String getName();

	public void setPoints(Point firstPoint, Point secondPoint);

	public Point getFirstPoint();

	public Point getSecondPoint();

	public int getIdNumber();
	
        public void setLength(double length);
        
	public Double getLength();
        
        public void setTime(int time);
        
	public int getTime();
        
	//Distance Formula
	public Double getDistance();


}
