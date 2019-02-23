public class Point extends Shape{
	protected double _x;
	protected double _y;

	Point(double x, double y){
		this._x = x;
		this._y = y;
	}

	public String getName(){
		return "Point";
	}

	public String toString(){
		return "["+_x+", "+_y+"]";
	}

	public double area(){
		return 0;
	}

	public double volume(){
		return 0;
	}
}