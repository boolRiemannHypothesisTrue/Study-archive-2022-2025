import numpy as np
import matplotlib
import matplotlib.pyplot as plt
x=np.array([-0.7, -0.41, -0.2, 0.17, 0.46, 0.75, 1.04, 1.33, 1.62, 1.91, 2.2])
y=np.array([-12.917,3.619,9.586,7.949,1.543,-8.057,-16.150,-20.562,-17.720,-6.200,18.115])
def genumsys(m,x, y): 
    C=np.zeros((m+1, m+1))
    b=np.zeros(m+1)
    for k in range (m+1): 
        b[k]=np.sum(y*x**k)
        for j in range (m +1):
            C[k,j] = np.sum(x**(k+j))
    return C, b
def P(x , a):
    r = 0
    for i in range (len(a)):
        r+=a[i]*x**i
    return r
def sigma(x , y, a):
    s = 0
    for i in range(len(x)):
        s+=(P(x[i], a) - y[i])**2
    s/=len(x)
    s =np.sqrt(s)
    return s


a = []
s = []
for i in range (0,6):
    C , b = genumsys(i,x,y)
    a.append(np.linalg.solve(C,b))
    s.append(sigma(x,y,a[i]))
print( a)
print(s)

plt.scatter(x, y, 10)
x1 = np.linspace(-0.7,3.2,1000)
for i in range (0,5):
   plt.plot(x1,P(x1,a[i]))
#plt.show()