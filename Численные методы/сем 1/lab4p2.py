import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from scipy.interpolate import CubicSpline
def f(x):
    return x**2 * np.cos(4*x)
def l(x,xft,i):
    P = 1
    for j in range (len(xft)):
        if i != j :
            P*=(x-xft[j])/(xft[i]-xft[j])
    return P
def L(x , xft, yft):
    s = 0
    for i in range (len(xft)):
        s += yft[i]*l(x,xft,i)
    return s
n = 10
xft = np.linspace(0,5,n)
yft = f(xft)
#print(L(3,xft,yft))
x1=np.linspace(0,5,1000)
#plt.plot(x1,f(x1))
# plt.plot(x1,L(x1,xft,yft))
# plt.show()


spline = CubicSpline(xft,yft)
#plt.plot(x1,spline(x1))
#plt.plot(x1,f(x1))
#plt.show()


#plt.plot(x1,abs(f(x1)-L(x1,xft,yft)))
#plt.show()   

plt.plot(x1,abs(f(x1)-spline(x1)))
plt.show()