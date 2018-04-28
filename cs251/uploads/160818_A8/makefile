all: App runtest analyse plot report

CC=gcc
CFLAGS= -g -I. -DDBG

SOURCES = $(wildcard *.c)

OBJS = $(patsubst %.c, %.o, $(SOURCES))
App:$(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -pthread -lm
runtest:App params.txt threads.txt runApp.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt
thread2.txt:runApp.py params.txt threads.txt
	python2 runApp.py
thread4.txt:runApp.py params.txt threads.txt
	python2 runApp.py
thread8.txt:runApp.py params.txt threads.txt
	python2 runApp.py
thread16.txt:runApp.py params.txt threads.txt
	python2 runApp.py
thread1.txt:runApp.py params.txt threads.txt
	python2 runApp.py
analyse:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out results2.out results3.out results4.out
2results1.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt  	
	python2 genresults.py
4results1.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt 	
	python2 genresults.py
8results1.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt  	
	python2 genresults.py
16results1.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt 	
	python2 genresults.py
1results1.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt  	
	python2 genresults.py
results2.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt 	
	python2 genresults.py
results3.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt  	
	python2 genresults.py
results4.out:genresults.py thread1.txt thread2.txt thread4.txt thread8.txt thread16.txt 	
	python2 genresults.py
plot:1a 2a 4a 8a 16a 2 speedup speedup_errorbar 
1a:1a.eps scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
1a.eps:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
	gnuplot scatter.p
2a:2a.eps scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
2a.eps:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
	gnuplot scatter.p
4a:4a.eps scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
4a.eps:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
	gnuplot scatter.p
8a:8a.eps scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
8a.eps:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
	gnuplot scatter.p
16a:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out 16a.eps
16a.eps:scatter.p 1results1.out 2results1.out 4results1.out 8results1.out 16results1.out	
	gnuplot scatter.p
2:results2.out 2.eps
2.eps:results2.out
	gnuplot lineplot.p
speedup:results3.out barplot.p speedup.eps
speedup.eps:results3.out barplot.p
	gnuplot barplot.p
speedup_errorbar:results4.out errorbar.p speedup_errorbar.eps
speedup_errorbar.eps:results4.out errorbar.p
	gnuplot errorbar.p
report:1a.eps 2a.eps 4a.eps 8a.eps 16a.eps 2.eps speedup.eps speedup_errorbar.eps report.pdf
report.pdf:1a.eps 2a.eps 4a.eps 8a.eps 16a.eps 2.eps speedup.eps speedup_errorbar.eps
	pdflatex report.tex
$(OBJS) : common.h
%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@


clean:
	rm -f *.o App *.eps *.pdf *.out thread[0-9]*.txt *.aux *.log 
	
