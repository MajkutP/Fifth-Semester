set term jpeg

set out 'Picard.jpg'
set xlabel 't'
set ylabel 'ludzie'
plot 'Picard_ut.dat' u 1:2 w p t '',\
'Picard_ut.dat' u 1:3 w p t '',

set out 'Newton.jpg'
set xlabel 't'
set ylabel 'ludzie'
plot 'Newton_ut.dat' u 1:2 w p t '',\
'Newton_ut.dat' u 1:3 w p t '',

set out 'RK.jpg'
set xlabel 't'
set ylabel 'ludzie'
plot 'RK_ut.dat' u 1:2 w p t '',\
'RK_ut.dat' u 1:3 w p t '',

