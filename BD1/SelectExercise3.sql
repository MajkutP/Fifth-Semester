--1--
with cte as (
	SELECT id_uczest,
	SUM(case when id_zaj = 1 then obec end) as z1,
	SUM(case when id_zaj = 2 then obec end) as z2,
	SUM(case when id_zaj = 3 then obec end) as z3,
	SUM(case when id_zaj = 4 then obec end) as z4,
	SUM(case when id_zaj = 5 then obec end) as z5,
	SUM(case when id_zaj = 6 then obec end) as z6,
	SUM(case when id_zaj = 7 then obec end) as z7,
	SUM(case when id_zaj = 8 then obec end) as z8,
	SUM(case when id_zaj = 9 then obec end) as z9,
	SUM(case when id_zaj = 10 then obec end) as z10,
	SUM(obec) as sum
	FROM uczest_zaj
	WHERE id_kurs = 1 AND id_grupa = 1
	GROUP BY id_uczest
)
SELECT uczestnik.nazwisko, uczestnik.imie, cte.z1, cte.z2, cte.z3, cte.z4, cte.z5, cte.z6, cte.z7, cte.z8, cte.z9, cte.z10, cte.sum
FROM uczestnik 
JOIN cte ON (uczestnik.id_uczestnik = cte.id_uczest)
ORDER BY uczestnik.nazwisko, uczestnik.imie;

--2--
CREATE VIEW lista_obecnosci_wszystkie_kursy AS
WITH kursy_grupy AS
	(SELECT DISTINCT id_kurs, id_grupa FROM uczest_zaj)
SELECT kurs_opis.opis as "Kurs", kursy_grupy.id_grupa as "Grupa",
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 1) as z1,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 2) as z2,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 3) as z3,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 4) as z4,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 5) as z5,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 6) as z6,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 7) as z7,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 8) as z8,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 9) as z9,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa AND id_zaj = 10) as z10,
	(SELECT SUM(obec) FROM uczest_zaj WHERE id_kurs = kurs.id_kurs AND id_grupa = kurs.id_grupa) as "Suma"
FROM kurs_opis, kursy_grupy, kurs
WHERE kurs.id_kurs = kursy_grupy.id_kurs AND kurs_opis.id_kurs = kurs.id_kurs_nazwa;
SELECT * FROM lista_obecnosci_wszystkie_kursy;

--3--
with cte as (
	SELECT id_wykl,
	SUM(case when id_kurs = 1 then 1 end) as k1,
	SUM(case when id_kurs = 2 then 1 end) as k2,
	SUM(case when id_kurs = 3 then 1 end) as k3,
	SUM(case when id_kurs = 4 then 1 end) as k4,
	SUM(case when id_kurs = 5 then 1 end) as k5,
	SUM(case when id_kurs = 6 then 1 end) as k6,
	SUM(case when id_kurs = 7 then 1 end) as k7,
	SUM(case when id_kurs = 8 then 1 end) as k8,
	SUM(case when id_kurs = 9 then 1 end) as k9,
	SUM(case when id_kurs = 10 then 1 end) as k10,
SUM(case when id_kurs = 10 then 1 end) as k11,
	COUNT(*) as sum
	FROM wykl_kurs
	GROUP BY id_wykl
)
SELECT wykladowca.nazwisko, wykladowca.imie, cte.k1, cte.k2, cte.k3, cte.k4, cte.k5, cte.k6, cte.k7, cte.k8, cte.k9, cte.k10, cte.k11, cte.sum
FROM wykladowca 
JOIN cte ON (wykladowca.id_wykladowca = cte.id_wykl)
ORDER BY wykladowca.nazwisko, wykladowca.imie;