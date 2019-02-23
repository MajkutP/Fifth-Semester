--1)--
SELECT opis, 
COUNT(*) 
FROM kurs_opis 
JOIN kurs ON kurs.id_kurs_nazwa = kurs_opis.id_kurs
JOIN uczest_kurs ON kurs.id_kurs = uczest_kurs.id_kurs
GROUP BY opis;

--2)--
SELECT opis, 
SUM(uczest_kurs.oplata) 
FROM kurs_opis 
JOIN kurs ON kurs_opis.id_kurs = kurs.id_kurs_nazwa 
JOIN uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs 
GROUP BY opis;

--3)--
SELECT opis, 
AVG(uczest_kurs.ocena) 
FROM kurs_opis 
JOIN kurs ON kurs_opis.id_kurs = kurs.id_kurs_nazwa 
JOIN uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs 
GROUP BY opis;

--4)--
SELECT imie, nazwisko, 
COUNT(*) 
FROM wykladowca
JOIN wykl_kurs ON wykladowca.id_wykladowca = wykl_kurs.id_wykl
JOIN kurs ON kurs.id_kurs = wykl_kurs.id_kurs 
GROUP BY imie, nazwisko;

--5)--
SELECT imie, nazwisko 
FROM wykladowca  
LEFT JOIN wykl_kurs wk ON wykladowca.id_wykladowca = wykl_kurs.id_wykl 
WHERE wykl_kurs.id_wykl is null;

--6)--
SELECT imie, nazwisko 
FROM uczestnik 
JOIN uczest_kurs ON  uczestnik.id_uczestnik = uczest_kurs.id_uczest 
JOIN kurs ON uczest_kurs.id_kurs = kurs.id_kurs
GROUP BY imie, nazwisko 
HAVING COUNT(*) >= 2;

--7)--
SELECT imie, nazwisko, 
COUNT(*), SUM(uczest_kurs.oplata), AVG(uczest_kurs.ocena), MIN(uczest_kurs.ocena), MAX(uczest_kurs.ocena)  
FROM uczestnik 
JOIN uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik 
JOIN kurs ON kurs.id_kurs = uczest_kurs.id_kurs 
GROUP BY uczestnik.imie, uczestnik.nazwisko; 

--8)--
SELECT imie, nazwisko, 
SUM(uczest_kurs.oplata) 
FROM uczestnik 
JOIN uczest_kurs ON uczestnik.id_uczestnik = uczest_kurs.id_uczest 
JOIN kurs ON uczest_kurs.id_kurs = kurs.id_kurs
GROUP BY uczestnik.imie, uczestnik.nazwisko 
ORDER BY SUM(uczest_kurs.oplata) 
DESC LIMIT 1;

--9)--
SELECT DISTINCT wykladowca.nazwisko, wykladowca.imie, wykladowca.id_wykladowca,
uczestnik.id_uczestnik, uczestnik.imie, uczestnik.nazwisko
FROM wykladowca
JOIN wykl_kurs ON wykladowca.id_wykladowca = wykl_kurs.id_wykl
JOIN kurs ON wykl_kurs.id_kurs = kurs.id_kurs
JOIN uczest_kurs ON kurs.id_kurs = uczest_kurs.id_uczest
JOIN uczestnik ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
ORDER BY wykladowca.id_wykladowca, wykladowca.nazwisko, wykladowca.imie;

--10)--
SELECT wykladowca.nazwisko, wykladowca.imie, wykladowca.id_wykladowca,
COUNT(*) 
FROM wykladowca
JOIN wykl_kurs ON wykladowca.id_wykladowca = wykl_kurs.id_wykl
JOIN kurs ON wykl_kurs.id_kurs = kurs.id_kurs
JOIN uczest_kurs ON kurs.id_kurs = uczest_kurs.id_uczest
JOIN uczestnik ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
GROUP BY wykladowca.id_wykladowca, wykladowca.nazwisko, wykladowca.imie;