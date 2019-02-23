class ElementStosu<T>{
	ElementStosu<T> wskaznik;
	T wartosc;

	ElementStosu(ElementStosu<T> wskaznik, T wartosc){
		this.wskaznik = wskaznik;
		this.wartosc = wartosc;
	}
}