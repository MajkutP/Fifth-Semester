set term jpeg

set out 'Zadanie_1_SOM.jpg'
set xlabel 'x(t)'
set ylabel 't'
plot '1SOM1.dat' u 2:1 w l t '',\
'1SOM2.dat' u 2:1 w l t '',

set out 'Zadanie_2_SOM.jpg'
set xlabel 'x(t)'
set ylabel 't'
plot '2SOM1.dat' u 2:1 w l t '',\
'2SOM2.dat' u 2:1 w l t '',\
'2SOM3.dat' u 2:1 w l t '',\
'2SOM4.dat' u 2:1 w l t '',\

