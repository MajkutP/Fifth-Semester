CREATE OR REPLACE FUNCTION dodaj_uzytkownika(id_uczestnik int, id_kurs int)
RETURNS INTEGER AS
$$

DECLARE
	i_ int := 1;
	size int;
	max_size int;
	zajecia_ilosc int;
	rec RECORD;
	grupa int;
BEGIN
	SELECT COUNT(*) INTO size FROM uczest_kurs WHERE uczest_kurs.id_kurs = id_kurs;
	SELECT kurs.max_uczest INTO max_size FROM kurs WHERE kurs.id_kurs = id_kurs;	
	IF size > max_size-1  THEN
		RETURN 2;
	END IF;

	FOR rec IN (SELECT uczest_kurs.id_uczest FROM uczest_kurs uk WHERE uczest_kurs.id_kurs = id_kurs)
	LOOP
		IF id_uczestnik = rec.id_uczest THEN
			RETURN 1;
		END IF;
	END LOOP;

	
	SELECT kurs.id_grupa INTO grupa FROM kurs WHERE kurs.id_kurs = id_kurs;
	SELECT COUNT(*) INTO zajecia_ilosc FROM zajecia WHERE zajecia.id_kurs = id_kurs;
	INSERT INTO uczest_kurs (id_uczest, id_kurs, id_grupa) values (id_uczestnik, id_kurs, grupa);
	WHILE i_ <= zajecia LOOP
		INSERT INTO Uczest_zaj(id_kurs, id_grupa, id_uczest, id_zaj) values (id_ku, grupa, id_uczestnik, i_);
		i_ := i_+1;
	END LOOP;
	RETURN 0;
END;
$$
LANGUAGE 'plpgsql';


SELECT COUNT(*) FROM uczest_kurs uk WHERE uk.id_kurs = 1;

SELECT CASE WHEN uk.id_kurs = 2 AND uk.id_uczest = 2 THEN 1 END FROM uczest_kurs uk;

SELECT uk.id_uczest FROM uczest_kurs uk WHERE uk.id_kurs = 2;

SELECT k.id_grupa FROM kurs k WHERE k.id_kurs = 5;

SELECT COUNT(*) FROM zajecia WHERE zajecia.id_kurs = 2;