# trapezoid
import numpy as np


def trapezoid(f, a, b, h):
 
  n = int((b - a) / h)
  s = 0.5 * (f(a) + f(b))
  for i in range(1, n):
    s += f(a + i * h)
  return s * h

step_arr=np.ndarray(15)   # //массив шагов для 15 итераций вычисления интеграла
for i in range(15):
    step_arr[i]=10**(-(i+1))




N = 19
coeff = [N, 0.1 * N, -0.5 * N, -N, 0.5 * N]
p = np.poly1d(coeff[::-1])

p_integ = np.polyint(p)
I = p_integ(N+1) - p_integ(N)

for i in range(15):
    I_trap=trapezoid(p,N,N+1,step_arr[i])
    print('%.16f    %.16f   %.16f   %d' % (I, I_trap ,(abs(I - I_trap)), i))
