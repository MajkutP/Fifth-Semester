import java.lang.Math;

public class Life{
	
	int xSize;
	int ySize;
	int [][] tab;
	int step;
	int preset;
	int [][] currentStep;

	Life(int x, int y, int step, int preset){
		this.xSize = x;
		this.ySize = y;
		this.tab = new int [x][y];
		this.step = step;
		this.preset = preset;
	}

	private void showTab(int s){
		System.out.println("-----------" + s + "------------");
		for (int x = 0; x < xSize; x++ ){
			for (int y = 0; y < ySize; y++ ){
				if(tab[x][y] == 1){
					System.out.print("X"); 
				}
				else{
					System.out.print(".");
				}
			}
			System.out.print("\n");
		}
	}

	private void initializeTab(int p){
		for (int x = 0; x < xSize; x++ ){
			for (int y = 0; y < ySize; y++ ){
				this.tab[x][y] = 0;
			}
		}

		if(p == 0){
			for (int x = 0; x < xSize; x++ ){
				for (int y = 0; y < ySize; y++ ){
				this.tab[x][y] = (int) (Math.random() + 0.5);
				}
			}
		}

		if(p == 1){
			tab[xSize / 2 - 1][xSize / 2 - 2] = 1;
			tab[xSize / 2 - 1][xSize / 2 - 1] = 1;
			tab[xSize / 2][xSize / 2 - 2] = 1;
			tab[xSize / 2][xSize / 2] = 1;
			tab[xSize / 2 + 1][xSize / 2 - 1] = 1;
		}

		if(p == 2){
			tab[xSize / 2 - 1][xSize / 2 - 1] = 1;
			tab[xSize / 2][xSize / 2 - 1] = 1;
			tab[xSize / 2 + 1][xSize / 2 - 1] = 1;
		}

		if(p == 3)
		{
			tab[xSize / 2 - 1][xSize / 2 - 2] = 1;
			tab[xSize / 2 - 1][xSize / 2 - 1] = 1;
			tab[xSize / 2 - 1][xSize / 2 ] = 1;
			tab[xSize / 2][xSize / 2 - 2] = 1;
			tab[xSize / 2 + 1][xSize / 2 - 1] = 1;
		}
	}

private void makeNextStep()
	{
		for(int i = 0; i < xSize; i++){
			for(int j = 0; j < ySize; j++){
				int howMany = 0;
				
				for(int x = -1; x < 2; x++){
					if(x == 0)
						break;
					
					if((0 <= (i + x)) && ((i + x) < ySize) && (0 <= (j + x)) && ((j + x) < xSize) && (tab[i + x][j + x] != 0)){
						howMany++;			
					}

					if((0 <= (i + x)) && ((i + x) < ySize) && (tab[i + x][j] != 0)){
						howMany++;		
					}

					if((0 <= (j + x)) && ((j + x) < xSize) && (tab[i][j + x] != 0)){
						howMany++;
					}

					if((0 <= (i + x)) && ((i + x) < ySize) && (0 <= (j - x)) && ((j - x) < xSize) && (tab[i + x][j - x] != 0)){
						howMany++;
					}
				}

				if(tab[i][j] == 0 && howMany == 3){
					tab[i][j] = 1;
				}
				if(tab[i][j] == 1 && howMany < 2 && howMany > 3){
					tab[i][j] = 0;
				}

			}
		}
	}

	public void begin(){
		initializeTab(preset);
		showTab(0);
		for(int s = 1; s < (step + 1); s++){
			makeNextStep();
			showTab(s);
		}
	}
}