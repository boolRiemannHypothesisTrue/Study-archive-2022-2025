 # /lab 5 var 20 
import math as m
import numpy as np
import matplotlib.pyplot as plt

#def function(x):
 #   return x**2


''''  бред от трейера
def rect_sum_right(f, left_border, right_border, seg_num):   # // правые прямоугольники
    step = (right_border - left_border)/seg_num
    y = [0 for i in range(seg_num)]
    for i in range(seg_num): y[i] = f(left_border + step * i)
    rect_sum = 0
    for i in range(seg_num - 1): rect_sum += y[i+1] * step
    return rect_sum
'''

def central_div(f, left_border, right_border, step):  # // центральная разностная производная
   
    df = (f(left_border + step) - f(left_border - step)) / (2 * step)
    return df
 
step_arr=np.ndarray(15)   # //массив шагов
for i in range(15):
    step_arr[i]=10**(-(i+1))

def rect_sum_left(f, left_border, step):  # // левые прямоугольники от меня
   sum=0
   seg=int(1/step)  # сег это число разбиений отрезка интегрирования 
   for i in range(seg-1):sum+=step*f(left_border+i*step)
   return sum
 
   
N = 20
coeff = [N, 0.1 * N, -0.5 * N, -N, 0.5 * N]
p = np.poly1d(coeff[::-1])
p_der = np.polyder(p)
p_integ = np.polyint(p)
I = p_integ(N+1) - p_integ(N)
f_der = p_der(N)
#print(I)        # эталонное значение интеграла


delta=np.ndarray(15)
#for i in range(15):

    #Sk = rect_sum_left(p, N, step_arr[i])
   
    #dk = central_div(p, N, N+1, step_arr[i])
   # delta[i] = abs(f_der - dk)
    #print('%.16f    %.16f   %.16f   %d' % (I, Sk, (abs(I - Sk)), i))
    #print('%.16f    %.16f   %.16f   %d' % (f_der, dk, (abs(f_der - dk)), i))


plt.rcParams["figure.figsize"] = [4, 3]
plt.grid(True)
plt.rcParams["figure.autolayout"] = True

plt.xlim(1, 7)  # Новые пределы для оси X
plt.ylim(0,190000)


#x = np.linspace(1,7,1)
x=[1,2,3,4,5,6,7]
#y = [7.8000000021420419,0.0780000486411154,0.0007805200293660,0.0000064745545387,0.0000074952840805,0.0003184676170349   ,0.0298796046972275   ]
y=[188032.8214666675776243   ,19113.5993151387665421    ,1914.4854665216989815  ,    191.4798244403209537,36.7006465373560786 , 1.9148326232098043            ,0.1914832924958318         ]



plt.plot(x, y, color='red')
plt.show()
#plt.savefig('plot.png', dpi = 300)



"""
x = [0] * n
x[0] = 1.2

for i in range(1, n):
    x[i] = 1.2 + i * h
print(x)

def func(x):
    return m.sqrt(x) * m.exp(-1 * 2 * x * x)
for i in range(n):
    x[i] = func(x[i])

x = [1, 1.2, 1.24, 0.76, 0.6]
h = 0.1

sum_med = 0
for i in range(1, n, 2):
    sum_med += 2 * h * x[i]

print(sum_med)

sum_trac = 0
sum_half = 0
for i in range(1, n):
    sum_trac += ((x[i] + x[i-1])/2) * h
    if i%2 == 0:
        sum_half += ((x[i] + x[i-2])/2) * h * 2

print(sum_trac)
print(sum_half)


sum_simp = 0
for i in range(1, n):
    sum_simp += 4 * x[i]
    if i%2 == 0:
        sum_simp += 2 * x[i]

sum_simp += (x[0] - x[n-1]) * (2 * h / 6)
print(sum_simp)
"""