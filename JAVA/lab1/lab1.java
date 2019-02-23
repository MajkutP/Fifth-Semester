public class lab1{

	public static void main(String[] args){

		double R = 1.7;
		double r = 1.2;
		double h = 1.3;

		for (double t = 1.4; t <= 29.65; t+=0.005 ) {
			double x = (R - r) * Math.cos(t)  + h * Math.cos(((R-r)/r)*t);
			double y = (R - r) * Math.sin(t) -  h * Math.sin(((R-r)/r)*t);
			System.out.println(x + " " + y);
		}

	}

}