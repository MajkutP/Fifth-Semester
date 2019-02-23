public class lab3string{

	public static int dlugosc(String text){
		 return text.length();
		}
	
	public static int ile_razy_literka_wystepuje(String text, char letter){
		int counter = 0;
		for (int i = 0; i < text.length(); i++){
			if(text.charAt(i) == letter)
				counter += 1;
		}

		return counter;
	}

	public static boolean czy_takie_same(String text1, String text2){
		return text1.equals(text2);
	}
	 
	public static String wspak(String textToReverse){
		StringBuilder text = new StringBuilder(textToReverse);
		text.reverse();

		return text.toString();
	} 

	public static boolean czy_plaindrom(String text){
		String reversed = wspak(text);
		
		return reversed.equals(text);
	}

	public static boolean czy_abecadlowe(String text){

		for(int i = 1; i < text.length(); i++){
			if(text.charAt(i-1) <= text.charAt(i))
				continue;
			
			else
				return false;		
		}

		return true;
	}

	public static String rot13(String textToRot){
		String rot13String = new String("");

		for(int i = 0; i < textToRot.length(); i++){
			if(Character.isLetter(textToRot.charAt(i))){
				if(Character.isUpperCase(textToRot.charAt(i))){
					if(textToRot.charAt(i) >= 'N')
						rot13String += (char) (textToRot.charAt(i) - 13);
					else
						rot13String += (char) (textToRot.charAt(i) + 13);
				}
				else{
					if(textToRot.charAt(i) >= 'n')
						rot13String += (char) (textToRot.charAt(i) - 13);
					else
						rot13String += (char) (textToRot.charAt(i) + 13);
				}
			}
			else
				rot13String += textToRot.charAt(i);			
		}

		return rot13String;
	} 

}