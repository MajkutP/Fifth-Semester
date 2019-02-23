--1--
SELECT kurs_opis.opis, 
CAST((100*(SELECT COUNT(*) FROM uczest_kurs
	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa)/
		(SELECT COUNT(*) FROM uczest_kurs)) AS numeric(10, 1)) AS stat_osob,
CAST((100*(SELECT COUNT(ocena) FROM uczest_kurs 
 	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa AND ocena>=4)/
		(SELECT COUNT(ocena) FROM uczest_kurs  
			WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa)) AS numeric(10, 1)) AS stat_ocena
FROM kurs_opis JOIN kurs ON kurs.id_kurs=kurs_opis.id_kurs;

--2--
SELECT uczestnik.imie, uczestnik.nazwisko,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 1 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 1) AS k1,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 2 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 2) AS k2,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 3 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 3) AS k3,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 4 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 4) AS k4,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 5 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 5) AS k5,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 6 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 6) AS k6,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 7 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 7) AS k7,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 8 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 8) AS k8,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 9 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 9) AS k9,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 10 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 10) AS k10,
(SELECT CASE WHEN  uczest_kurs.id_kurs = 11 THEN 'x' END FROM  uczest_kurs WHERE uczest_kurs.id_uczest = uczestnik.id_uczestnik AND uczest_kurs.id_kurs = 11) AS k11
FROM uczestnik;

--3--
SELECT kurs_opis.opis, 
(SELECT COUNT(ocena) FROM uczest_kurs
	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa AND ocena=3) AS ocena_3,
(SELECT COUNT(ocena) FROM uczest_kurs
	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa AND ocena=4) AS ocena_4,
(SELECT COUNT(ocena) FROM uczest_kurs
	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa AND ocena=5) AS ocena_5,
(SELECT COUNT(*) FROM uczest_kurs
	WHERE kurs.id_kurs=uczest_kurs.id_kurs AND kurs.id_grupa=uczest_kurs.id_grupa AND ocena!=5 AND ocena!=4 AND ocena!=3) AS ocena_n
FROM kurs_opis JOIN kurs ON kurs.id_kurs=kurs_opis.id_kurs;