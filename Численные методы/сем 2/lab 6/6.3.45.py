import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

def f(t, y, p, beta):
    gamma = p * beta
    return y * (1 - y) - p * y

def compute_integral_simpson(sol, gamma, beta):
    T = beta * sol.t[-1]
    y = sol.y[0]
    h = sol.t[1] - sol.t[0]
    
    integral = gamma * (y[0] + y[-1]) / 2
    for i in range(1, len(y) - 1):
        if i % 2 == 0:
            integral += gamma * y[i]
        else:
            integral += 2 * gamma * y[i]
    
    integral *= h / 3
    return integral

beta = 0.9
y0 = 0.3
gamma_values = np.arange(0.2, 1.3, 0.1)
t_span = (0, 50)

integrals = {}
solutions={}
for gamma in gamma_values:
    p = gamma / beta
    sol = solve_ivp(lambda t, y: f(t, y, p, beta), t_span, [y0], method='RK45')
    solutions[gamma] = sol
    integrals[gamma] = compute_integral_simpson(sol, gamma, beta)

optimal_gamma = max(integrals, key=integrals.get)

plt.figure(figsize=(10, 6))
for gamma, sol in solutions.items():
    plt.plot(sol.t, sol.y[0], label=f'gamma = {gamma}')

plt.xlabel('Время')
plt.ylabel('Численность популяции')
plt.title('Динамика численности популяции при разных значениях параметра gamma')
plt.legend(loc='upper right')
plt.grid(True)
plt.show()

print("Значение параметра gamma, соответствующее максимальному интегралу:", optimal_gamma)
