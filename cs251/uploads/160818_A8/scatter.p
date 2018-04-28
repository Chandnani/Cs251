set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

#set format x "10^{%L}"
#set format y "10^{%L}"
set logscale xy
set xlabel "No of Elements"
set ylabel "Time Taken in Microsecs"
set yrange[1:1200000]
set xrange[1:12000000]
set ytic auto
set xtic auto

set output "1a.eps"
plot '1results1.out' using 1:2 notitle with points pt 1 ps 1.5
set output "2a.eps"
plot '2results1.out' using 1:2 notitle with points pt 1 ps 1.5
set output "4a.eps"
plot '4results1.out' using 1:2 notitle with points pt 1 ps 1.5
set output "8a.eps"
plot '8results1.out' using 1:2 notitle with points pt 1 ps 1.5
set output "16a.eps"
plot '16results1.out' using 1:2 notitle with points pt 1 ps 1.5


