# /lab 5 var 20 
import math as m
import numpy as np
import scipy.integrate as integrate

def function(x):
    return np.log(x**2 - x)



def rect_sum_right(f, left_border, right_border, step):   # // правые прямоугольники
    seg_num= int((right_border - left_border)/step)
    y = [0 for i in range(seg_num)]
    for i in range(seg_num): y[i] = f(left_border + step * i)
    rect_sum = 0
    for i in range(seg_num - 1): rect_sum += y[i+1] * step
    return rect_sum

eps=np.ndarray(15)
for i in range(15): eps[i]=10**(-(i+1))
#print(eps)
step_arrT=np.ndarray(15)
for i in range(15): step_arrT[i]=eps[i]/1.5
n=np.ndarray(15)
for i in range(15):
    n[i]=int(3/eps[i])+1
step_arrR=np.ndarray(15)
for i in range(15):
    step_arrR[i]=2/n[i]
#print(step_arrR)
R=np.ndarray(15)
p=1

''''
for i in range(15):
    Ih=rect_sum_right(lambda x: np.log(x**2 -x),2,4,step_arr[i])
    Ih2=rect_sum_right(lambda x: np.log(x**2 -x),2,4,step_arr[i]/2)
    R[i]=abs((Ih-Ih2)/(2**p -1))
    if(R[i]<eps): 
        step_arr[i+1]=step_arr[i]/2
        break
    print(R[i],eps,step_arr[i+1])

'''
#I = integrate.quad(lambda x: np.log(x**2 -x), 2, 4)   
I=3.4547199493640006
Ih=np.ndarray(15)
for i in range(15):
    Ih[i]=rect_sum_right(lambda x: np.log(x**2 -x),2,4,step_arrR[i])
    print('%.16f    %.16f   %.16f   %d' % (float(I), float(Ih[i]), (abs(I - Ih[i])), i))
    


#opt_step=0.5*10**(-8)



#print(I[0])        # эталонное значение интеграла
