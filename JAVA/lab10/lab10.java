import java.io.*;
import java.util.HashMap;

@SuppressWarnings (value="unchecked") //unchecked cast, line 15

public class lab10{
	public static void main(String[] args){

		Dictionary dictionary = new Dictionary();
		File file = new File("slownik.ser");

	if (file.exists() && !file.isDirectory()) {
		try{
			ObjectInputStream objectInputStream = new ObjectInputStream(new FileInputStream("slownik.ser"));
			dictionary.hashMap = (HashMap<String, String>) objectInputStream.readObject();
			objectInputStream.close();
		}

		catch (Exception exception) {
			System.out.println(exception);
		}
	}	

	if(args.length == 3){ //args[0] == "add"
			dictionary.add(args[1], args[2]);
		}
		
		if(args.length == 2){ //args[0] == "del"
			dictionary.removeWord(args[1]);
		}

		if(args.length == 1){
			dictionary.findTranslation(args[0]);
		}

		if(args.length == 0){
			System.out.println("Program needs arguments to run properly:\n");
			System.out.println("java lab10 add word translation\n");
			System.out.println("java lab10 del word/translation\n");
			System.out.println("java lab10 wordToTranslate");
		}

		try {
			ObjectOutputStream objectOutputStream = new ObjectOutputStream(new FileOutputStream("slownik.ser"));
			objectOutputStream.writeObject(dictionary.hashMap);
			objectOutputStream.close();	
		}

		catch (Exception excepton) {
			System.out.println(excepton);
		}

	}
}