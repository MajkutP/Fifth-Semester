--dla wybranego przystanku -> znaleźć linie zatrzymujące się na tym przystanku--
SELECT DISTINCT linia.nr_linii FROM linia
JOIN kierunek ON kierunek.nr_linii = linia.nr_linii 
JOIN rozklad ON kierunek.id_przystanku = rozklad.id_przystanku
JOIN przystanek ON przystanek.id_przystanku = rozklad.id_przystanku
WHERE przystanek.nazwa = 'Owczary';

--dla wybranego przystanku i linii -> znaleźć czasy odjazdu--
SELECT odjazd FROM rozklad
JOIN dzien_kursu ON rozklad.id_dzien = dzien_kursu.id_dzien
JOIN kierunek ON kierunek.nr_linii = rozklad.nr_linii AND kierunek.id_przystanku = rozklad.id_przystanku
JOIN przystanek ON kierunek.id_przystanku = przystanek.id_przystanku
JOIN linia ON kierunek.nr_linii = linia.nr_linii
WHERE linia.nr_linii = 277 AND przystanek.nazwa = 'Bibice' AND dzien_kursu.opis = 'sobota'; 

--dla wybranej linii -> znaleźć przystanki i czasy odjazdy z przystanków--
SELECT przystanek.nazwa, rozklad.odjazd FROM rozklad
JOIN dzien_kursu ON rozklad.id_dzien = dzien_kursu.id_dzien
JOIN kierunek ON kierunek.nr_linii = rozklad.nr_linii AND kierunek.id_przystanku = rozklad.id_przystanku
JOIN przystanek ON kierunek.id_przystanku = przystanek.id_przystanku
JOIN linia ON kierunek.nr_linii = linia.nr_linii
WHERE linia.nr_linii = 280 AND dzien_kursu.opis = 'swieta';
