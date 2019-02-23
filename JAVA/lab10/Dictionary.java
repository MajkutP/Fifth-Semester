import java.util.Map;
import java.util.HashMap;

public class Dictionary{
	HashMap<String, String> hashMap = new HashMap<String, String>();

	public void add(String word, String translation){
		hashMap.put(word, translation);
	}

	public void findTranslation(String word){
		if(hashMap.containsValue(word)){
			for (Map.Entry<String, String> param : hashMap.entrySet()) {
				if (param.getValue().equals(word)) {
					System.out.println(param.getKey());
				}
			}
		}

		else if(hashMap.containsKey(word))
			System.out.println(hashMap.get(word));

		else
			System.out.println("There is no such word in dictionary");
	}

	public void removeWord(String word){
		hashMap.remove(word);
	}

}
