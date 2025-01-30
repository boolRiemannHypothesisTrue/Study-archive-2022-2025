import numpy as np
import matplotlib.pyplot as plt

def analytical_solution(x, ua, ub, q):
    # Вычисление коэффициентов C1 и C2
    C1 = (ub * np.exp(np.sqrt(q) * a) - ua * np.exp(np.sqrt(q) * b)) / (np.exp(np.sqrt(q) * a) - np.exp(np.sqrt(q) * b))
    C2 = (ua - C1) * np.exp(-np.sqrt(q) * a)
    return C1 * np.exp(np.sqrt(q) * x) + C2 * np.exp(-np.sqrt(q) * x)

def finite_difference_scheme(N, a, b, ua, ub, q):
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
    A[N, N] = 1
    b[N] = ub
    
    return x, A, b

# Данные
a = 0
b = 3
q = 1.69
ua = 6
ub = 2
N = 10

# Формирование разностной схемы
x, A, b = finite_difference_scheme(N, a, b, ua, ub, q)

# Решение системы линейных уравнений
y = np.linalg.solve(A, b)

# Построение графиков
plt.figure(figsize=(10, 6))
plt.plot(x, y, label='Численное решение', marker='o')
plt.plot(x, analytical_solution(x, ua, ub, q), label='Аналитическое решение', linestyle='--')
plt.xlabel('x')
plt.ylabel('u(x)')
plt.title('Аналитическое и численное решения')
plt.legend()
plt.grid(True)
plt.show()

# Вычисление погрешности
error = np.max(np.abs(analytical_solution(x, ua, ub, q) - y))
print("Величина погрешности:", error)
