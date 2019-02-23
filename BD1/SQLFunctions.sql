--1--
CREATE OR REPLACE FUNCTION equ_tables(a numeric, b numeric, c numeric, xStart int, step int, size int)
RETURNS TABLE (i int, x int, y int) AS
$$
DECLARE
    x_ INTEGER := xStart;
    y_ INTEGER := 0;
    i_ INTEGER := 1;
BEGIN
    WHILE i_ <= size LOOP
        y_ := a*x_*x_ + b*x_ + c;
        i  := i_;
        x  := x_;
        y  := y_;
        i_ := i_+1;
        x_ := x_+step;
        RETURN NEXT;
    END LOOP;
END;
$$ 
LANGUAGE 'plpgsql';            

--2--
CREATE OR REPLACE FUNCTION equ_solve(a numeric, b numeric, c numeric)
RETURNS TABLE (x1 text, x2 text) AS
$$
DECLARE
    delta numeric;
BEGIN
   delta := b*b - 4*a*c;
   RAISE INFO 'Delta: %', delta;
   IF delta = 0 THEN
        RAISE INFO 'Rozwiazanie posiada jedno rzeczywiste rozwiazanie x1=x2';
        x1 :=(-b/2*a)::text;
        x2 := x1;
        RAISE INFO 'x1 = x2 = %', x2;
        RETURN NEXT;
   ELSEIF delta > 0 THEN
        RAISE INFO 'Rozwiazanie posiada dwa rzeczywiste rozwiazania';
        x1 := ((-b - sqrt(delta))/2*a)::text;
        x2 := ((-b + sqrt(delta))/2*a)::text;
        RAISE INFO 'x1 = %', x1;
        RAISE INFO 'x2 = %', x2;
        RETURN NEXT;
   ELSE
        RAISE INFO 'Rowzwizanie w dziedzinie liczb zespolonych';
        delta := -delta;
        x1 := (-b/(2*a))::text || ' ' || (-sqrt(delta)/(2*a))::text || 'i';
        x2 := (-b/(2*a))::text || ' ' || (sqrt(delta)/(2*a))::text || 'i';
        RAISE INFO 'x1 = %', x1;
        RAISE INFO 'x2 = %', x2;
        RETURN NEXT;
   END IF;
END;
$$
LANGUAGE 'plpgsql';

--3--
CREATE OR REPLACE FUNCTION uczest_wykladowca(index int)
RETURNS TABLE (nazwisko varchar, imie varchar) AS
$$
    SELECT DISTINCT wykladowca.nazwisko, wykladowca.imie FROM uczest_kurs 
    JOIN wykl_kurs ON uczest_kurs.id_kurs = wykl_kurs.id_kurs
    JOIN wykladowca ON wykladowca.id_wykladowca = wykl_kurs.id_wykl
    WHERE uczest_kurs.id_uczest = index;
$$
LANGUAGE SQL;

--4--
CREATE OR REPLACE FUNCTION uczest_kurs(index int)
RETURNS TABLE (z_opis varchar) AS
$$
    SELECT kurs_opis.opis FROM kurs_opis
    JOIN kurs ON kurs.id_kurs_nazwa = kurs_opis.id_kurs
    JOIN uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs
    WHERE uczest_kurs.id_uczest = index;
$$
LANGUAGE SQL;

--5--
CREATE OR REPLACE FUNCTION lista_obec(index int)
RETURNS TABLE (s_nazwisko varchar, s_imie varchar, z1 bigint, z2 bigint, z3 bigint, z4 bigint, z5 bigint, z6 bigint, z7 bigint, z8 bigint, z9 bigint, z10 bigint, sum bigint) AS
$$  
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
    WHERE id_kurs = index AND id_grupa = index
    GROUP BY id_uczest
)
SELECT uczestnik.nazwisko, uczestnik.imie, cte.z1, cte.z2, cte.z3, cte.z4, cte.z5, cte.z6, cte.z7, cte.z8, cte.z9, cte.z10, cte.sum
FROM uczestnik 
JOIN cte ON (uczestnik.id_uczestnik = cte.id_uczest)
ORDER BY uczestnik.nazwisko, uczestnik.imie;
$$
LANGUAGE SQL;