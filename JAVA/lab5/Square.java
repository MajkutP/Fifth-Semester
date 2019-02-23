public class Square extends Point{
	protected double _side;

	Square(double side, double x, double y){
		super(x,y);
		this._side = side;
	}

	public String getName(){
		return "Square";
	}

	public String toString(){
		return "Corner = "+super.toString()+"; side = "+_side;
	}

	public double area(){
		return Math.pow(_side, 2);
	}
}