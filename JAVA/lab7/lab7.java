import java.util.Scanner;

public class lab7{
	public static void main(String[] args){
		Scanner scanner = new Scanner(System.in); 
		int[] dane = new int[2];

		for (int i = 0; i < dane.length; i++){
		 	dane[i] = scanner.nextInt();
		} 

		Test test = new Test(dane);
		test.checkCorrectness();
	}
}