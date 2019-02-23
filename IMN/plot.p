set terminal pngcairo size 800,600
set out 'zad1a.png'

set view map
#set xrange [1:127]
#set yrange [1:127]
set xlabel 'x'
set ylabel 'y'
set cntrparam levels 10
set contour
set palette defined(-55 'white', -50 'red')
unset key


set title 'strumien'
splot 'psi.dat' u 1:2:3 w pm3d

