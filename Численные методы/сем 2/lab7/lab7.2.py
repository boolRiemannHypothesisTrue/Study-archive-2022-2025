import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import simps

 
#  правая часть уравнения теплопроводности
def source_term(x, c, W):
    return W * np.exp(-(x - c)**2)

# решение уравнения теплопроводности методом конечных разностей
def finite_difference_heat(N, a, b, ua, ub, q, c, W):
    h = (b - a) / N
    x = np.linspace(a, b, N+1)
    A = np.zeros((N+1, N+1))
    b = np.zeros(N+1)
    
    A[0, 0] = 1
    b[0] = ua
    
    for i in range(1, N):
        A[i, i-1] = 1
        A[i, i] = -2 - h**2 * q
        A[i, i+1] = 1
        b[i] = -h**2 * source_term(x[i], c, W)
    
    A[N, N] = 1
    b[N] = ub
    
    y = np.linalg.solve(A, b)
    return x, y


a, b = 0, 3
ua, ub = 6, 2
q = 1.69
N = 100  
c = 2.2  

# 1. Решение уравнения теплопроводности при отсутствии источника тепла
W_no_heat_source = 0
x_no_heat_source, y_no_heat_source = finite_difference_heat(N, a, b, ua, ub, q, c, W_no_heat_source)

# 2. Решение уравнения теплопроводности при источнике тепла с первоначальной мощностью
W_original_heat_source = 18
x_original_heat_source, y_original_heat_source = finite_difference_heat(N, a, b, ua, ub, q, c, W_original_heat_source)

# 3. Подбор мощности источника тепла для увеличения температуры в точке c втрое
def temperature_difference(W):
    x, y = finite_difference_heat(N, a, b, ua, ub, q, c, W)
    u_c = np.interp(c, x, y)
    return u_c - ua * 3

def bisection_method_for_W(func, a, b, tol=1e-6, max_iter=1000):
    if func(a) * func(b) >= 0:
        raise ValueError("Функция должна иметь разные знаки на концах интервала.")
    
    iter = 0
    while (b - a) / 2 > tol and iter < max_iter:
        c = (a + b) / 2
        if func(c) == 0:
            return c
        elif func(c) * func(a) < 0:
            b = c
        else:
            a = c
        iter += 1
    
    return (a + b) / 2

W_lower = 0
W_upper = 100
W_adjusted = bisection_method_for_W(temperature_difference, W_lower, W_upper)
x_adjusted, y_adjusted = finite_difference_heat(N, a, b, ua, ub, q, c, W_adjusted)

# 4. Построение графиков
plt.figure(figsize=(10, 6))

# График при отсутствии источника тепла
plt.plot(x_no_heat_source, y_no_heat_source, label='Отсутствие источника тепла')

# График при первоначальной мощности источника тепла
plt.plot(x_original_heat_source, y_original_heat_source, label=f'Источник тепла (W={W_original_heat_source})')

# График при скорректированной мощности источника тепла
plt.plot(x_adjusted, y_adjusted, label=f'Скорректированная мощность (W={W_adjusted})')

# Отметим точку c на графиках при оригинальной и скорректированной мощностях
u_c_original = np.interp(c, x_original_heat_source, y_original_heat_source)
u_c_adjusted = np.interp(c, x_adjusted, y_adjusted)
plt.scatter(c, u_c_original, color='red', label=f'Точка c (W={W_original_heat_source})')
plt.scatter(c, u_c_adjusted, color='blue', label=f'Точка c (W={W_adjusted})')

plt.xlabel('x')
plt.ylabel('Температура')
plt.title('Распределение температуры в стержне')

plt.legend(loc='upper left')

plt.grid(True)
plt.show()
# 5. Вычисление тепловой энергии стержня через интеграл
def thermal_energy(x, y):
    return simps(y**2, x)

# Тепловая энергия для случая без источника тепла
energy_no_heat_source = thermal_energy(x_no_heat_source, y_no_heat_source)
print(f"Тепловая энергия без источника тепла: {energy_no_heat_source}")

# Тепловая энергия для случая с первоначальной мощностью источника тепла
energy_original_heat_source = thermal_energy(x_original_heat_source, y_original_heat_source)
print(f"Тепловая энергия с первоначальной мощностью источника тепла: {energy_original_heat_source}")

# Тепловая энергия для случая с корректированной мощностью источника тепла
energy_adjusted_heat_source = thermal_energy(x_adjusted, y_adjusted)
print(f"Тепловая энергия с корректированной мощностью источника тепла: {energy_adjusted_heat_source}")
