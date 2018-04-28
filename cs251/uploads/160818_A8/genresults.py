import os
import numpy as np
with open("params.txt") as f:
	param = [word for line in f for word in line.split()]
with open("threads.txt") as f:
	thread = [word for line in f for word in line.split()]
outfile3  = open("results3.out","w");
outfile4  = open("results4.out","w");
outfile2  = open("results2.out","w");
t1_avg={};
out4 = {}
out3 = {}
out2 = {}
for paramno in param:
	out4[paramno] = {}
	out3[paramno] = {}
	out2[paramno] = {}
for threadno in thread:
	outfile1  = open(threadno+"results1.out","w");
	infile = "thread"+threadno+".txt";
	with open(infile) as f:
		tim = [word for line in f for word in line.split()]
	i =3
	cntr = len(tim)/(5*len(param))
	for paramno in param:
		time_taken=[]
		tot=0.0
		for j in range(cntr):
			tot+=int(tim[i])
			time_taken.append(int(tim[i]));
			outfile1.write(paramno+" "+str(tim[i])+"\n")
			i+=5;
		avg = tot/cntr
		if(threadno=="1"):
			t1_avg[paramno] = avg;
		out2[paramno][threadno] = avg;
		speedup = np.zeros(cntr)
		for j in range(cntr):
			speedup[j] = float(t1_avg[paramno])/float(time_taken[j])
		out4[paramno][threadno] = np.var(speedup);
		out3[paramno][threadno] = t1_avg[paramno]/avg;
for paramno in param:
	l4 = paramno;
	l3 = paramno;
	l2 = paramno;
	for threadno in thread:
		l2+=" "+str(out2[paramno][threadno]);
		l3+=" "+str(out3[paramno][threadno]);
		l4+=" "+str(out3[paramno][threadno])+" "+str(out4[paramno][threadno]);
	l4+="\n";
	l3+="\n";
	l2+="\n";
	outfile3.write(l3)
	outfile4.write(l4)
	outfile2.write(l2)

		
