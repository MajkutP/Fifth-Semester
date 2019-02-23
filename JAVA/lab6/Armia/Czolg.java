package Armia;

public class Czolg implements SluchaRozkazow{
	private Rozkaz[] wydaneRozkazy;

	public void wykonajRozkaz(Rozkaz rozkaz){
		int iloscPrzyjetychRozkazow = 1;

		if(wydaneRozkazy != null){
			iloscPrzyjetychRozkazow = wydaneRozkazy.length + 1;
		}

		Rozkaz[] noweRozkazy = new Rozkaz[iloscPrzyjetychRozkazow];

		for(int index = 0; index < iloscPrzyjetychRozkazow - 1; index++){
			noweRozkazy[index] = wydaneRozkazy[index];
		}

		noweRozkazy[iloscPrzyjetychRozkazow - 1] = rozkaz;
		wydaneRozkazy = noweRozkazy;
	}

	public String ostatniRozkaz(){
		String meldunek = new String("Ostatni rozkaz do mnie: ");
		String raport = meldunek + wydaneRozkazy[wydaneRozkazy.length - 1].toString();
		return raport;
	}

	public String toString(){
		String meldunek = new String();

		for(int index = 0; index <= wydaneRozkazy.length - 1; index++){
			meldunek += wydaneRozkazy[index] + "\n";
		}

		return meldunek; 
	}
}
