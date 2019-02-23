CREATE SCHEMA SklepMuzyczny;
SET SEARCH_PATH TO SklepMuzyczny;

create table historia_adres (data_zmiany_adresu varchar UNIQUE, id_klienta int, adres varchar);
create table klient (id_klienta int UNIQUE, imie varchar, nazwisko varchar, telefon varchar, email varchar);
create table zamowienie (id_zamowienia int UNIQUE, id_klienta int, kwota int, data_zamowienia varchar, data_odbioru varchar, czy_zrealizowano int);
create table zamowienie_produkt (id_produktu int, id_zamowienia int);
create table produkt (id_produktu int UNIQUE, id_producenta int, id_dzialu int, opis varchar);
create table historia_cen (data_ceny varchar UNIQUE, id_produktu int, cena int);
create table zdjecie (id_zdjecia int UNIQUE, data_zdjecia varchar, base64 varchar);
create table zdjecie_produkt(id_zdjecia int, id_produktu int);
create table producent (id_producenta int UNIQUE, nazwa_producenta varchar);
create table dzial (id_dzialu int UNIQUE, nazwa_dzialu varchar);
create table kategoria	(id_kategorii int UNIQUE, id_dzialu int, nazwa_kategorii varchar);

alter table historia_adres add primary key (id_klienta, data_zmiany_adresu);
alter table klient add primary key (id_klienta);
alter table zamowienie add primary key (id_zamowienia, id_klienta);
alter table zamowienie_produkt add primary key (id_zamowienia, id_produktu);
alter table produkt add primary key (id_produktu, id_producenta, id_dzialu);
alter table historia_cen add primary key (data_ceny, id_produktu);
alter table zdjecie add primary key (id_zdjecia);
alter table zdjecie_produkt add primary key (id_zdjecia, id_produktu);
alter table producent add primary key (id_producenta);
alter table dzial add primary key (id_dzialu);
alter table kategoria add primary key (id_kategorii, id_dzialu);

alter table historia_adres add foreign key (id_klienta) references klient (id_klienta);
alter table zamowienie add foreign key (id_klienta) references klient (id_klienta);
alter table zamowienie_produkt add foreign key (id_zamowienia) references zamowienie (id_zamowienia);
alter table zamowienie_produkt add foreign key (id_produktu) references produkt (id_produktu);
alter table produkt add foreign key (id_producenta) references producent (id_producenta);
alter table produkt add foreign key (id_dzialu) references dzial (id_dzialu);
alter table historia_cen add foreign key (id_produktu) references produkt (id_produktu);
alter table kategoria add foreign key (id_dzialu) references dzial (id_dzialu);
alter table zdjecie_produkt add foreign key (id_zdjecia) references zdjecie (id_zdjecia);
alter table zdjecie_produkt add foreign key	(id_produktu) references produkt (id_produktu);

--Widok 1--
CREATE VIEW Historia_Zamowien AS
SELECT 
zamowienie.id_zamowienia,
zamowienie.data_zamowienia,
klient.nazwisko,
klient.imie,
klient.email,
klient.telefon
FROM
zamowienie JOIN klient ON zamowienie.id_klienta = klient.id_klienta
JOIN zamowienie_produkt ON zamowienie.id_zamowienia = zamowienie_produkt.id_zamowienia
JOIN produkt ON zamowienie_produkt.id_produktu = produkt.id_produktu
GROUP BY
zamowienie.id_zamowienia,
zamowienie.data_zamowienia,
klient.nazwisko,
klient.imie,
klient.email,
klient.telefon
ORDER BY zamowienie.data_zamowienia;

--Widok 2--
CREATE VIEW Zamowienia_z_darmowym_dojazdem AS
SELECT DISTINCT
historia_adres.adres,
klient.nazwisko,
klient.imie,
klient.email,
klient.telefon,
zamowienie.data_zamowienia,
zamowienie.kwota,
produkt.opis
FROM 
historia_adres Left JOIN klient ON klient.id_klienta = historia_adres.id_klienta
Left JOIN zamowienie ON zamowienie.id_klienta = klient.id_klienta
Left JOIN zamowienie_produkt ON zamowienie.id_zamowienia = zamowienie_produkt.id_zamowienia
Left JOIN produkt ON zamowienie_produkt.id_produktu = produkt.id_produktu
WHERE zamowienie.kwota > 199
GROUP BY historia_adres.adres,
klient.nazwisko,
klient.imie,
klient.email,
klient.telefon,
zamowienie.data_zamowienia,
zamowienie.kwota,
produkt.opis;

--Funkcja 1--
CREATE OR REPLACE FUNCTION ilosc_przeprowadzonych_transakcji(stan_realizacji int)
RETURNS TABLE (liczba_transakcji bigint) AS
$$
	SELECT COUNT(*) FROM zamowienie WHERE zamowienie.czy_zrealizowano = stan_realizacji;
$$
LANGUAGE SQL;
	
--Funkcja 2--
CREATE OR REPLACE FUNCTION producent_statystyki_sprzedazy(opis_producenta varchar)
RETURNS TABLE (nazwa_producenta varchar, suma bigint, min_kwota int, max_kwota int) AS
$$
	SELECT sklepmuzyczny.producent.nazwa_producenta, SUM(sklepmuzyczny.zamowienie.kwota), MIN(sklepmuzyczny.zamowienie.kwota), MAX(sklepmuzyczny.zamowienie.kwota)
	FROM sklepmuzyczny.zamowienie JOIN sklepmuzyczny.zamowienie_produkt ON sklepmuzyczny.zamowienie.id_zamowienia = sklepmuzyczny.zamowienie_produkt.id_zamowienia
	JOIN sklepmuzyczny.produkt ON sklepmuzyczny.zamowienie_produkt.id_produktu = sklepmuzyczny.produkt.id_produktu
	JOIN sklepmuzyczny.producent ON sklepmuzyczny.produkt.id_producenta = sklepmuzyczny.producent.id_producenta 
	WHERE sklepmuzyczny.producent.nazwa_producenta = opis_producenta
	GROUP BY sklepmuzyczny.producent.nazwa_producenta;
$$
LANGUAGE SQL;

--Funkcja 3--
CREATE OR REPLACE FUNCTION produkty_ponizej_danej_kwoty(zadana_kwota int)
RETURNS TABLE (kwota int, produkt varchar, dzial varchar, producent varchar) AS
$$
	SELECT DISTINCT sklepmuzyczny.zamowienie.kwota, sklepmuzyczny.produkt.opis, sklepmuzyczny.dzial.nazwa_dzialu, sklepmuzyczny.producent.nazwa_producenta
	FROM sklepmuzyczny.zamowienie JOIN sklepmuzyczny.zamowienie_produkt ON sklepmuzyczny.zamowienie.id_zamowienia = sklepmuzyczny.zamowienie_produkt.id_zamowienia
	JOIN sklepmuzyczny.produkt ON sklepmuzyczny.zamowienie_produkt.id_produktu = sklepmuzyczny.produkt.id_produktu
	JOIN sklepmuzyczny.producent ON sklepmuzyczny.produkt.id_producenta = sklepmuzyczny.producent.id_producenta 
	JOIN sklepmuzyczny.dzial ON sklepmuzyczny.produkt.id_dzialu = sklepmuzyczny.dzial.id_dzialu
	WHERE sklepmuzyczny.zamowienie.kwota <= zadana_kwota;
$$
LANGUAGE SQL;
