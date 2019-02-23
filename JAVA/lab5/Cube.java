public class Cube extends Square{
	Cube(double side, double x, double y){
		super(side, x, y);
	}

	public String getName(){
		return "Cube";
	}

	public String toString(){
		return super.toString()+"; depth = "+super._side;
	}

	public double area(){
		return 6*Math.pow(super._side, 2);
	}

	public double volume(){
		return Math.pow(super._side, 3);
	}
}