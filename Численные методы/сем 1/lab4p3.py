import numpy as np
x=[1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,11.5]
y=[0.99458,0.86240,0.75598,0.68569,0.63724,0.60212,0.57560,0.55489,0.53830,0.52472,0.51339]
for i in range(len(y)):
    y[i]=np.arcsin(y[i])
for i in range(len(x)):
    x[i]=1/x[i]
invsum=0
for i in range(len(x)):
    invsum+=pow(x[i],-1)
A=([len(x),sum(x)],[sum(x),invsum])
sum2=0
for i in range(len(y)):
    sum2+=x[i]*y[i]
B=([sum(y),sum2])
print(np.linalg.solve(A,B))