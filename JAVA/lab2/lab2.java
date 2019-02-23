import java.util.Random;

public class lab2
{
 public static void main(String args[])
 {
  Rnd x=new Rnd(10,100);
  x.Print();
  System.out.println("minimum = "+x.Min());
  System.out.println("maksimum = "+x.Max());
  System.out.println("avg = "+x.Average());
  x.Draw();
 }
}

class Rnd{

	public double []array;
	public double size;

	Rnd(int arraySize, int randMult){
		this.size = arraySize;
		array = new double[arraySize];
		Random randomDouble = new Random();

		for (int i = 0; i < arraySize; i++){
			for(int j =0; j < randMult; j++){
				array[i] += randomDouble.nextDouble();
			}
		}
	}

	public void Print(){
		for(int i = 0; i < size; i++){
			System.out.println("["+i+"] = "+array[i]);
		}
	}

	public double Min(){
		double min = array[0];
		for(int i = 1; i < size; i++){
			if(array[i] < min){
				min = array[i];
			}
		}

		return min;
	}

	public double Max(){
		double max = array[0];
		for(int i = 1; i < size; i++){
			if(array[i] > max){
				max = array[i];
			}
		}

		return max;

	}

	public double Average(){
		double all = 0;
		for (int i = 0; i < size; i++) {
			all += array[i];
		}

		return all/size;
	}

	public void Draw(){
		for (int i = 0; i < size; i++){
			System.out.print("["+i+"]: ");
			for(int j = 0; j < 50 * (array[i]-Min())/(Max()-Min()); j++){
				System.out.print("*");
			}
			System.out.println();
		}
	}
}