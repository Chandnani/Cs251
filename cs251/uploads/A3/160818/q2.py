#!/usr/bin/python
from numpy import genfromtxt
import sys
import numpy as np
import random as rnd
from numpy.linalg import inv
import matplotlib.pyplot as plt
data = genfromtxt(sys.argv[1],delimiter=',')
x = data[1:,0]
x_train = np.ones(x.shape,dtype=float)
x_train2 = np.concatenate((x_train[:,None],x[:,None]),axis=1)
w = np.random.rand(2,1)
y = data[1:,1]
plt.plot(x,y,'ro',x,x_train2.dot(w),'g-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('Prediction using random weight matrix')
plt.show()
w_direct =(inv((x_train2.T).dot(x_train2))).dot(x_train2.T.dot(y[:,None]))
ans=(w_direct.T).dot(x_train2.T)
plt.plot(x,y,'ro',x,ans.T,'b-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('Prediction using calculated weight matrix')
plt.show()
lr = 0.00000001
for nepoch in range(2):
	for j in range(x.shape[0]):
		w = w - (lr*(x_train2[j,:].dot(w)-y[j])*x_train2[j,:])[:,None]
		if(j%100==0):
			plt.plot(x,y,'ro',x,x_train2.dot(w),'g-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('Prediction using weight matrix obtained at various stages of regression')
plt.show()
plt.plot(x,y,'ro',x,x_train2.dot(w),'g-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('final prediction with regression')
plt.show()
data2 = genfromtxt(sys.argv[2],delimiter=',')
x2 = data2[1:,0]
y2 = data2[1:,1]
x_test = np.ones(x2.shape,dtype=float)
x_test2 = np.concatenate((x_test[:,None],x2[:,None]),axis=1)
y_pred = x_test2.dot(w)
y_pred2 = x_test2.dot(w_direct)
y2 = y2[:,None]
s1 = np.square(y_pred-y2)
s2 = np.square(y_pred2-y2)
rms1 = np.mean(s1)
rms2 = np.mean(s2)
rms1 = np.sqrt(rms1)
rms2 = np.sqrt(rms2)
print("Root mean square error for predicted labels using regression")
print(rms1)
print("Root mean square error for predicted labels using formula")
print(rms2)
plt.plot(x2,y2,'ro',x2,y_pred,'g-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('prediction of regression on test data')
plt.show()
plt.plot(x2,y2,'ro',x2,y_pred2,'g-',markersize=1)
plt.xlabel('xlabel')
plt.ylabel('ylabel')
plt.title('prediction using formulated weight matrix on test data')
plt.show()
print("Predicted weight matrix using regression")
print(w)
print("Predicted weight matrix using formula")
print(w_direct)
