class Stos<T> {
	private ElementStosu<T> pierwszyNaGorze = null;

	public void push(T wartosc){
		ElementStosu<T> kolejnyElement = new ElementStosu<T>(pierwszyNaGorze, wartosc);
		pierwszyNaGorze = kolejnyElement;
	}

	public void pop(){
		pierwszyNaGorze = pierwszyNaGorze.wskaznik;
	}

	public String toString(){
		ElementStosu<T> elementStosu = pierwszyNaGorze;
		String wyjscie = "";

		while(elementStosu != null) {
			wyjscie += "{" + elementStosu.wartosc + "} ";
			elementStosu = elementStosu.wskaznik;
		}

		return wyjscie;
	}
}