import java.util.Scanner;
import java.io.IOException;
import java.nio.file.NoSuchFileException;

class WrongNumberOfInputArguments extends Exception{}
class FileException extends IOException{}
class DzieleniePrzezZero extends ArithmeticException {}

public class lab08 {
	public static void main(String[] args) throws Exception {
		
		try{
			if(args.length != 1){
				throw new WrongNumberOfInputArguments();
			}

			FileOperations fileO = new FileOperations(args[0]);	

			fileO.getDataFromFile();
			fileO.printAverage();
		}

		catch(WrongNumberOfInputArguments exception){
			System.err.println("Zla liczba argumentow przy odpaleniu pliku");
		}
		catch (NoSuchFileException exception) {
			System.err.println("Nie podano pliku wejsciowego");
		}
		catch (DzieleniePrzezZero exception) {
			System.err.println("Dzielenie przez zero");
		}
		catch (FileException exception) {
			System.err.println("Zly odczyt pliku wejsciowego");
		}

	}	
}