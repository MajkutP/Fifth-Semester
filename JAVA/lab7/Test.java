import java.util.Random;

public class Test{
	
	int dataNumbers;
	int numberOfTests;

	Test(int [] preset){
		this.dataNumbers = preset[0];
		this.numberOfTests = preset[1];
	}

	public void checkCorrectness(){
		int correct = 1;
		int [] data = new int[dataNumbers];
		int numberOfTeams = numberOfTests * 2;
		int [][] teams = new int[numberOfTests][numberOfTests];
		int [][] ifChecked = new int [dataNumbers][dataNumbers - 1];
		Random generator = new Random();
		int [] generatedNumber = new int[dataNumbers];
		int ok_pass = 1;
		int rand;

		for (int i = 0; i < dataNumbers; i++){	 //tabelka poprawnosci			
			for (int j = 0; j < dataNumbers - 1; j++)
				ifChecked[i][j] = 1;
		}

		for (int i = 0; i < data.length; i++){
		 	data[i] = i + 1;
		} 

		for (int i = 0; i < numberOfTests; i++){    //podzial na grupy

			for (int k = 0; k < numberOfTeams; i++){
				generatedNumber[k] = k + 1;
			}
															
			for (int j = 0; j < numberOfTeams; j++){		 //czy sie powtarza
				do{
					int rand_pass = 0;
				 	rand = generator.nextInt(dataNumbers) + 1;
					for (int z = 0; z<numberOfTeams; z++) {
						if(rand == generatedNumber[z]){
							rand_pass  = 1;
							generatedNumber[z] = -1;
							ok_pass = 0;
							break;
						}
					}

				}while(ok_pass == 1);
				ok_pass = 1;
				teams[i][j] = rand;
			}
		}

		for (int i = 0; i < numberOfTests; i++){    	//test
			for(int k = 0; k < numberOfTeams; k++)		//wiersz															
				for (int j = 0; j < numberOfTeams; j++){	//dla kazdej liczby
					if(j > numberOfTests/2 ){
						
					}
					else{

					}
			}
		}

		for (int i = 0; i < dataNumbers; i++){    //sprawdzenie wyniku
			for (int j = 0; j < dataNumbers; j++)
				if(ifChecked[i][j] == 0){
					correct = 0;
				}
		}

		if(correct == 1){
			System.out.print("TAK");
		}
		else{
			System.out.print("NIE");
		}
	}
}