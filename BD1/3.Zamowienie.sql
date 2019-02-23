CREATE SCHEMA zamowienie;
SET SEARCH_PATH TO Zamowienie;

create table klient (id_klienta int UNIQUE, imie varchar, nazwisko varchar, telefon varchar, email varchar);
create table zamowienie (id_zamowienia int UNIQUE, id_klienta int, id_stan_zamowienia int, data_zamowienia varchar);
create table zamowienie_produkt (id_produktu int, id_zamowienia int, ilosc int);
create table produkt (id_produktu int UNIQUE, id_producenta int, id_dzialu int, opis varchar);
create table producent (id_producenta int UNIQUE, nazwa_producenta varchar);
create table dzial (id_dzialu int UNIQUE, nazwa_dzialu varchar);
create table stan_zamowienia(id_stan_zamowienia int UNIQUE, opis varchar);

alter table klient add primary key (id_klienta);
alter table zamowienie add primary key (id_zamowienia, id_klienta, id_stan_zamowienia);
alter table zamowienie_produkt add primary key (id_zamowienia, id_produktu);
alter table produkt add primary key (id_produktu, id_producenta, id_dzialu);
alter table producent add primary key (id_producenta);
alter table dzial add primary key (id_dzialu);
alter table stan_zamowienia add primary key (id_stan_zamowienia);

alter table zamowienie add foreign key (id_klienta) references klient (id_klienta);
alter table zamowienie add foreign key (id_stan_zamowienia) references stan_zamowienia (id_stan_zamowienia);
alter table zamowienie_produkt add foreign key (id_zamowienia) references zamowienie (id_zamowienia);
alter table zamowienie_produkt add foreign key (id_produktu) references produkt (id_produktu);
alter table produkt add foreign key (id_producenta) references producent (id_producenta);
alter table produkt add foreign key (id_dzialu) references dzial (id_dzialu);

insert into stan_zamowienia(id_stan_zamowienia, opis) values (1, 'anulowane'), (2, 'wyslane'), (3, 'oczekiwanie na towar'), (4, 'w realizacji');
insert into klient(id_klienta, imie, nazwisko, telefon, email) values (1, 'Adam', 'Abacki', '1112223344', 'Adamos@kek'), (2, 'Zbyszek', 'Zbychawski', '555666777888', 'Zbysio@lel');
insert into producent (id_producenta, nazwa_producenta) values (1, 'Yamaha'), (2, 'Fedner');
insert into dzial (id_dzialu, nazwa_dzialu) values (1, 'Akustyk'), (2, 'Elektryk');
insert into produkt (id_produktu, id_producenta, id_dzialu, opis) values (1, 1, 1, 'Yamaha-Akustyk'), (2, 1, 2, 'Yamaha-Elektryk'), (3, 2, 1, 'Fedner-Akustyk'), (4, 2, 2, 'Fedner-Akustyk');
insert into zamowienie(id_zamowienia, id_klienta, id_stan_zamowienia, data_zamowienia) values (1,1,2, '13.12.18'), (2,1,1, '14.12.18'), (3,2,3, '15.12.18'), (4,2,4, '16.12.18');
insert into zamowienie_produkt(id_produktu, id_zamowienia, ilosc) values (1, 1, 5), (2, 1, 10), (3, 2, 15), (4, 2, 50);		

drop table klient cascade;
drop table zamowienie cascade;
drop table zamowienie_produkt cascade;
drop table produkt cascade;
drop table producent cascade;
drop table dzial cascade;
drop table stan_zamowienia cascade;

--1--
SELECT 
zamowienie.id_zamowienia,
zamowienie.data_zamowienia,
stan_zamowienia.opis,
klient.nazwisko,
klient.imie,
klient.email
FROM
zamowienie JOIN klient ON zamowienie.id_klienta = klient.id_klienta
JOIN stan_zamowienia ON zamowienie.id_stan_zamowienia = stan_zamowienia.id_stan_zamowienia
JOIN zamowienie_produkt ON zamowienie.id_zamowienia = zamowienie_produkt.id_zamowienia
JOIN produkt ON zamowienie_produkt.id_produktu = produkt.id_produktu
GROUP BY
zamowienie.id_zamowienia,
zamowienie.data_zamowienia,
stan_zamowienia.opis,
klient.nazwisko,
klient.imie,
klient.email
ORDER BY stan_zamowienia.opis;

--2--
SELECT
stan_zamowienia.opis,
klient.nazwisko,
klient.imie,
klient.email,
klient.telefon,
zamowienie.data_zamowienia,
zamowienie_produkt.ilosc,
produkt.opis,
dzial.nazwa_dzialu,
producent.nazwa_producenta
FROM 
zamowienie JOIN stan_zamowienia ON zamowienie.id_stan_zamowienia = stan_zamowienia.id_stan_zamowienia
JOIN klient ON zamowienie.id_klienta = klient.id_klienta
JOIN zamowienie_produkt ON zamowienie.id_zamowienia = zamowienie_produkt.id_zamowienia
JOIN produkt ON zamowienie_produkt.id_produktu = produkt.id_produktu
JOIN dzial ON produkt.id_dzialu = dzial.id_dzialu
JOIN producent ON produkt.id_producenta = producent.id_producenta
WHERE zamowienie.id_zamowienia = 2;