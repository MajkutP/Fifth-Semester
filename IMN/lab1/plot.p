set term jpeg

set out 'rys1_1.jpg'
set xlabel 't'
set ylabel 'y(t)'
plot 'zad1_1.dat' u 1:2 w p t '',\
'zad1_2.dat' u 1:2 w p t '',\
'zad1_3.dat' u 1:2 w p t '',

set out 'rys1_2.jpg'
set xlabel 't'
set ylabel 'ynum(t) - ydok(t)'
plot 'zad1_4.dat' u 1:2 w p t '',\
'zad1_5.dat' u 1:2 w p t '',\
'zad1_6.dat' u 1:2 w p t '',

set out 'rys2_1.jpg'
set xlabel 't'
set ylabel 'y(t)'
plot 'zad2_1.dat' u 1:2 w p t '',\
'zad2_2.dat' u 1:2 w p t '',\
'zad2_3.dat' u 1:2 w p t '',

set out 'rys2_2.jpg'
set xlabel 't'
set ylabel 'ynum(t) - ydok(t)'
plot 'zad2_4.dat' u 1:2 w p t '',\
'zad2_5.dat' u 1:2 w p t '',\
'zad2_6.dat' u 1:2 w p t '',

set out 'rys3_1.jpg'
set xlabel 't'
set ylabel 'y(t)'
plot 'zad3_1.dat' u 1:2 w p t '',\
'zad3_2.dat' u 1:2 w p t '',\
'zad3_3.dat' u 1:2 w p t '',

set out 'rys3_2.jpg'
set xlabel 't'
set ylabel 'ynum(t) - ydok(t)'
plot 'zad3_4.dat' u 1:2 w p t '',\
'zad3_5.dat' u 1:2 w p t '',\
'zad3_6.dat' u 1:2 w p t '',