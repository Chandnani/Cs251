import os
with open("params.txt") as f:
	param = [word for line in f for word in line.split()]
with open("threads.txt") as f:
	thread = [word for line in f for word in line.split()]
for threadno in thread:
	os.system("rm -f thread"+threadno+".txt")
	for paramno in param:
		call ="./App "+paramno+" "+threadno+" >> thread"+threadno+".txt"  
		for i in range(100):
			os.system(call);
