import java.lang.Integer;

public class lab4{
	public static void main(String[] args){
		Life life = new Life(Integer.valueOf(args[0]), Integer.valueOf(args[1]), Integer.valueOf(args[2]), Integer.valueOf(args[3]));
		life.begin();
	}
}