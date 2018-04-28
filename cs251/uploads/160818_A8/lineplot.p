#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set logscale xy
set xlabel "No of Elements"
set ylabel "Time in microsecs"
set yrange[1:1200000]
set xrange[1:12000000]
set ytic auto
set xtic auto

set key bottom right

set output "2.eps"
plot 'results2.out' using 1:2 title "1 Thread" with linespoints, \
     '' using 1:3 title "2 Threads" with linespoints pt 5 lc 4, \
     '' using 1:4 title "4 Threads" with linespoints pt 5 lc 3,\
     '' using 1:5 title "8 Threads" with linespoints pt 5 lc 5,\
     '' using 1:6 title "16 Threads" with linespoints lc 2

