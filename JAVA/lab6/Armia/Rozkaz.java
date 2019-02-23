package Armia;

public class Rozkaz{
	private String przechowywanyRozkaz;

	public Rozkaz(String wydanyRozkaz){
		przechowywanyRozkaz = wydanyRozkaz;
	}

	public String toString(){
		return przechowywanyRozkaz;
	}
}
