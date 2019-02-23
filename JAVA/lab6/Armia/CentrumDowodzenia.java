package Armia;

public class CentrumDowodzenia implements Rozkazuje{
	private Czolg[] batalionCzolgow;

	public void zarejestrujCzolg(Czolg numerRejestrowanegoCzolgu){
		int stanWojska = 1;
		
		if(batalionCzolgow != null){
			stanWojska = batalionCzolgow.length + 1;
		}

		Czolg[] Uzupelnienia = new Czolg[stanWojska];
		
		for(int index = 0; index < stanWojska - 1; index++){
			Uzupelnienia[index] = batalionCzolgow[index];
		}

		Uzupelnienia[stanWojska - 1] = numerRejestrowanegoCzolgu;
		batalionCzolgow = Uzupelnienia;
	}

	public void wydajRozkaz(String NumerRozkazu, Rozkaz WydanyRozkaz){
		int NumerRozkazuInt = Integer.parseInt(NumerRozkazu);
		batalionCzolgow[NumerRozkazuInt - 1].wykonajRozkaz(WydanyRozkaz);
	}

	public String toString(){
		String pelenRaport = new String();
		pelenRaport += "Do tej pory centrum dowodzenia wyslalo nastepujace rozkazy:\n";

		for(int index = 0; index <= batalionCzolgow.length - 1; index++){
			pelenRaport += "Czolg nr " + (index + 1) + " otrzymal rozkazy: \n" + batalionCzolgow[index] + "\n";
		}

		return pelenRaport;
	}
}
