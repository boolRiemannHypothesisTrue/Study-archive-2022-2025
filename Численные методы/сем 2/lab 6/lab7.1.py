import numpy as np
import matplotlib.pyplot as plt
a = 0
b = 3
q = 1.69
ua = 6
ub = 2
N = 10
x = np.linspace(a, b, N+1)

def analytical_solution(x):
    return np.exp(-1.3 * x) * (5.96196 + 0.038041 * np.exp(2.6 * x))


def num_solution(N, a, b, ua, ub, q):
    h = (b - a) / N
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
    
    y = np.linalg.solve(A, b)
    return y

y_numerical = num_solution(N, a, b, ua, ub, q)

plt.figure(figsize=(10, 6))
plt.plot(x, y_numerical, label='Численное решение', marker='o',linestyle='dashed')
plt.plot(x, analytical_solution(x), label='Аналитическое решение', linestyle='dotted')
plt.xlabel('x')
plt.ylabel('u(x)')
plt.title('Аналитическое и численное решения')
plt.legend()
plt.grid(True)
plt.show()

err = np.abs(analytical_solution(x) - y_numerical)
max_err = np.max(err)
print("Максимальная величина погрешности:", max_err)