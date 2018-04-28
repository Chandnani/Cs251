#!usr/bin/python

import sys
def invalid():
	print("Invalid Input")
	sys.exit(0)
def char_to_int( a):
	if(a>='A'and a<='Z'):
		return ord(a)-ord('A')+10;
	elif(a>='a'and a<='z'):
		return ord(a)-ord('a')+10;
	elif(a=="." or  a=='-'):
		return -1;
	elif(a>='0' and a<='9'):
		return ord(a)-ord('0');
	else:
		invalid();
def to_int( str ):
	ans = 0;
	for i in str:
		if(i<'0' or i>'9'):
			return invalid();
		temp = ord(i)-ord('0') ;
		ans*=10;
		ans+=temp;
	return ans;
def parse( str ):
	j=0;
	for i in str:
		if(i=='.'):
			return j;
		else:
			j=j+1;
	return -1;
if(len(sys.argv)!=3):
	invalid()
Nb = sys.argv[1]
b = to_int(sys.argv[2])
if(b>36 or b<2):
	invalid();
x = False;
ans=0;
z=1;
aa=False;
bb=False;
zz=False;
ng=1;
for i in Nb:
	if zz==False :
		zz=True;
		if i=='-' :
			ng=-1;
			continue;
	y = char_to_int(i)
	if i=='.' :
		if x==True :
			invalid();
		x = True;
	elif y>=b or y<0 :
		invalid();
	elif x == True :
		bb=True;
		z/=b;
		ans+=z*y
	else :
		aa=True;
		ans*=b;
		ans+=y
if (aa|bb)==False :
	invalid()
if x==True and bb==False :
	invalid()
print(ans*ng)
