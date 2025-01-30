import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

def analytical_solution(t, y0):
    return y0 * np.exp(-0.5 * np.log(2*t+1))

def euler_method(f, y0, t, h):
    y = np.zeros(len(t))
    y[0] = y0
    for i in range(1, len(t)):
        y[i] = y[i-1] + h * f(t[i-1], y[i-1])
    return y

def solve_ivp_method(f, t_span, y0, max_step):
    solution = solve_ivp(f, t_span, y0, max_step=max_step)
    return solution.y[0]

# Определение функции правой части произвольной задачи Коши
def f(t, y):
    return y * (-1 / (2 * t + 1))

# Начальные условия и параметры
t0 = 0
T = 2
N = 10
y0 = 1.414
h = (T - t0) / N
t_values = np.linspace(t0, T, N)
t_span = (t0, T)

# Вычисление численных решений
y_exact = analytical_solution(t_values, y0)
y_euler = euler_method(f, y0, t_values, h)
y_solve_ivp = solve_ivp_method(f, t_span, [y0], h)[:N]

# Вывод результатов
print("Аналитическое решение:", y_exact)
print("Численное решение методом Эйлера:", y_euler)
print("Численное решение с использованием solve_ivp:", y_solve_ivp)

# Вычисление погрешностей
error_euler = np.max(np.abs(y_exact - y_euler))
error_solve_ivp = np.max(np.abs(y_exact - y_solve_ivp))

print("Погрешность метода Эйлера:", error_euler)
print("Погрешность solve_ivp:", error_solve_ivp)

# Построение графиков
plt.plot(t_values, y_exact, label='Аналитическое решение', color='blue')
plt.plot(t_values, y_euler, label='Метод Эйлера', color='red', marker='o')
plt.plot(t_values, y_solve_ivp, label='solve_ivp', color='green', marker='s')
plt.xlabel('t')
plt.ylabel('y(t)')
plt.legend()
plt.grid(True)
plt.show()
