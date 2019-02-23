import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.nio.file.Files;

public class FileOperations {
	private float[] tab = null;
	private String  FileName;

	public FileOperations(String filePath) {
		this.FileName = filePath;
	}

	public void getDataFromFile() throws Exception {
		try (BufferedReader bufferedReader = Files.newBufferedReader(new File(FileName).toPath())) {
			String nextLine = null;

			while ((nextLine = bufferedReader.readLine()) != null) {
				float newFloat = Float.parseFloat(nextLine);

				//przepisanie tablicy
				if (tab == null) {
				tab = new float[1];
				tab[0] = newFloat;
				return;
				}

				float[] tmp = tab;
				tab = new float[tab.length+1];

				for (int i = 0; i < tab.length - 1; i++){
					tab[i] = tmp[i];
				}

				tab[tab.length-1] = newFloat;
			}
		}
		//blad odczytu
		catch (java.io.IOException exception) {
			throw new FileException();
		}
	}

	public void printAverage() {
		float sum = 0;
		float avg;
		int i;

		for (i = 0; i < tab.length; i++)
			sum = sum + tab[i];
		
		if (i == 0){
			throw new DzieleniePrzezZero();
		}

		avg = sum/i;

		System.out.println("Srednia: " + avg);
	}
}
