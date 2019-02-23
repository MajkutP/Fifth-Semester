public class lab9{
	public static void main(String[] args){
		
		if(args.length == 1){
			FileOperations fileOperations = new FileOperations(args[0]);
			fileOperations.getDataFromFile();
			fileOperations.saveToFile();
		}
		else{
			System.out.println("Wrong number of args!");
		}

	}
}