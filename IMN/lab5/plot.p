set term jpeg

set out 'Sk.jpg'
plot 'Sk1.dat' u 1:2 w l t'k=16',\
'Sk2.dat' u 1:2 w l t'k=8',\
'Sk4.dat' u 1:2 w l t'k=4',\
'Sk8.dat' u 1:2 w l t'k=2',\
'Sk16.dat' u 1:2 w l t'k=1'

reset 
set term png
set out 'V16.png'
set xlabel 'x'
set ylabel 'y'
set pm3d map
set palette defined (-1 "blue", 0 "white", 1 "red")
set size ratio -1
splot [0:25.6][0:25.6][-1:1] "Vk16.dat" i 0 u 1:2:3

set out 'V8.png'
splot [0:25.6][0:25.6][-1:1] 'Vk8.dat' i 0 u 1:2:3

set out 'V4.png'
splot [0:25.6][0:25.6][-1:1] 'Vk4.dat' i 0 u 1:2:3

set out 'V2.png'
splot [0:25.6][0:25.6][-1:1] 'Vk2.dat' i 0 u 1:2:3

set out 'V1.png'
splot [0:25.6][0:25.6][-1:1] 'Vk1.dat' i 0 u 1:2:3
