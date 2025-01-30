#Practica
import math as m
import numpy as np
import matplotlib.pyplot as plt

def function(x):
    return x**2

def rect_sum_left(f, left_border, right_border, seg_num):
    step = (right_border - left_border)/seg_num
    y = [0 for i in range(seg_num)]
    print(y)
    for i in range(seg_num): y[i] = f(left_border + step * i)
    rect_sum = 0
    for i in range(seg_num - 1): rect_sum += y[i] * step
    return rect_sum


def rect_sum_right(f, left_border, right_border, seg_num):
    step = (right_border - left_border)/seg_num
    y = [0 for i in range(seg_num)]
    for i in range(seg_num): y[i] = f(left_border + step * i)
    rect_sum = 0
    for i in range(seg_num - 1): rect_sum += y[i+1] * step
    return rect_sum


def central_div(f, left_border, right_border, seg_num):
    step = (right_border - left_border)/seg_num
    df = (f(left_border + step) - f(left_border - step)) / (2 * step)
    return df
 


N = 12
coeff = [N, 0.1 * N, -0.5 * N, -N, 0.5 * N]
p = np.poly1d(coeff[::-1])
p_der = np.polyder(p)
p_integ = np.polyint(p)
I = p_integ(13) - p_integ(12)
f_der = p_der(12)
#print(I)


delta = [0 for i in range(15)]
for i in range(15):

    #Sk = rect_sum_left(p, 12, 13, 5)
    dk = central_div(p, 12, 13, 10**i)
    delta[i] = abs(f_der - dk)
    #print('%.16f    %.16f   %.16f   %d' % (I, Sk, (abs(I - Sk)), i))
    print('%.16f    %.16f   %.16f   %d' % (f_der, dk, (abs(f_der - dk)), i))


plt.rcParams["figure.figsize"] = [4, 3]
plt.grid(True)
plt.rcParams["figure.autolayout"] = True

plt.xlim(-2, 3)  # Новые пределы для оси X
plt.ylim(-10, 50)


x = np.linspace(0, 15, 1)
y = delta



plt.plot(x, delta, color='red')
plt.savefig('plot.png', dpi = 300)



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