set term jpeg

set out 'TrapezXT.jpg'
set xlabel 'x(t)'
set ylabel 't'
plot 'w1.dat' u 2:1 w l t '',\
'w5.dat' u 2:1 w l t '',

set out 'TrapezVT.jpg'
set xlabel 'v(t)'
set ylabel 't'
plot 'w2.dat' u 2:1 w l t '',\
'w6.dat' u 2:1 w l t '',

set out 'TrapezDTT.jpg'
set xlabel 'dt(t)'
set ylabel 't'
plot 'w3.dat' u 2:1 w l t '',\
'w7.dat' u 2:1 w l t '',

set out 'TrapezVX.jpg'
set xlabel 'v(x)'
set ylabel 'x'
plot 'w4.dat' u 2:1 w l t '',\
'w8.dat' u 2:1 w l t '',

set out 'RKXT.jpg'
set xlabel 'x(t)'
set ylabel 't'
plot 'w9.dat' u 2:1 w l t '',\
'w13.dat' u 2:1 w l t '',

set out 'RKVT.jpg'
set xlabel 'v(t)'
set ylabel 't'
plot 'w10.dat' u 2:1 w l t '',\
'w14.dat' u 2:1 w l t '',

set out 'RKDTT.jpg'
set xlabel 'dt(t)'
set ylabel 't'
plot 'w11.dat' u 2:1 w l t '',\
'w15.dat' u 2:1 w l t '',

set out 'RKVX.jpg'
set xlabel 'v(x)'
set ylabel 'x'
plot 'w12.dat' u 2:1 w l t '',\
'w16.dat' u 2:1 w l t '',



