# /lab 5 var 20 5.2
import math as m
import numpy as np

def rect_sum_left(f, left_border, step):  # // левые прямоугольники от меня
   sum=0
   seg=int(1/step)  # сег это число разбиений отрезка интегрирования 
   for i in range(seg-1):sum+=step*f(left_border+i*step)
   return sum
 


   
N = 20
coeff = [N, 0.1 * N, -0.5 * N, -N, 0.5 * N]
p = np.poly1d(coeff[::-1])

p_integ = np.polyint(p)
I = p_integ(N+1) - p_integ(N)
#print(I)
'''
eps=10**(-8)
p_der = np.polyder(p)
f_der = p_der(N+1)
#print(f_der)
h0=2*eps/f_der
print(h0)
'''
Ih=rect_sum_left(p,N,10**(-14))
print(Ih)