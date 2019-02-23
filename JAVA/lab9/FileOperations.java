import java.util.List;
import java.util.ArrayList;
import java.io.*;
import java.util.Collections;

class FileException extends IOException{}

class FileOperations{
	private String fileName;
	private List <PointClass> pixels;
	private int xSize;
	private int ySize;
	private int numberOfPoints;
	private String outputfileName;	

	FileOperations(String inputfileName){
		this.fileName = inputfileName;
		pixels = new ArrayList<PointClass>();
	}

	void getDataFromFile(){
		File file = new File(fileName);

		int lineNumber = 0;
		String currentLine;
		try(BufferedReader bufferedReader = new BufferedReader(new FileReader(file))){

			while((currentLine = bufferedReader.readLine()) != null){
				lineNumber += 1;
				if(lineNumber == 1){
					String[] fragments = currentLine.split(" ");
					xSize = Integer.parseInt(fragments[0]);
					ySize = Integer.parseInt(fragments[1]);
					outputfileName = fragments[2];
				}
				else if(lineNumber == 2){
					numberOfPoints = Integer.parseInt(currentLine);
				}
				else{
					String[] fragments = currentLine.split(",");
					pixels.add(new PointClass(Integer.parseInt(fragments[0]), Integer.parseInt(fragments[1])));
				}
			}
		}
		catch(IOException excepiton){
			System.out.println("Error occured while loading the file!");
		}
	}

	void saveToFile()
	{
		File file = new File(outputfileName);
		List<Double> distanceToPoint = new ArrayList<Double>();
					
		try (BufferedWriter bufferedWriteer = new BufferedWriter(new FileWriter(file))){
			bufferedWriteer.write("P3\n" + "#Piotr Majkut\n" + xSize + " " + ySize + "\n255\n" );

			for(int i=0; i<ySize; i++){
				for(int j=0; j<xSize; j++){
					for(int fragments = 0; fragments<numberOfPoints - 1; fragments++){

						double dis1 = Math.pow(pixels.get(fragments).x-j, 2) + Math.pow(pixels.get(fragments).y-i, 2);
						double dis2 = Math.pow(pixels.get(fragments+1).x-j, 2) + Math.pow(pixels.get(fragments+1).y-i, 2);

						distanceToPoint.add(dis1);
						distanceToPoint.add(dis2);
					}

					Collections.sort(distanceToPoint);
					if(Math.abs(distanceToPoint.get(0) - distanceToPoint.get(1)) > Math.pow(10, -8))
						bufferedWriteer.write("255 255 255 ");
					else
						bufferedWriteer.write("0 0 0 ");		
				}
			}
		}
		catch(IOException excepiton){
			System.out.println("Error occured while saving the file!");
		}
	}


}