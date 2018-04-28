set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "NO of elements"
set ylabel "Application speedup"
set yrange[0:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
set key top left


set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup_errorbar.eps"
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram
set key top left
plot 'results4.out' u 2:3:xticlabels(1) title "1 Thread",\
'' u 4:5 title "2 Threads" fillstyle pattern 7,\
'' u 6:7 title "4 Threads" fillstyle pattern 12,\
'' u 8:9 title "8 Threads" fillstyle pattern 14,\
'' u 10:11 title "16 Threads" fillstyle pattern 4
