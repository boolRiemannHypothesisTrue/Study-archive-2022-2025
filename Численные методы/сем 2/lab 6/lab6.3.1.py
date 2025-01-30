import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

def f(t, y, p, beta):
    gamma = p * beta
    return y * (1 - y) - p * y

beta = 0.9
y0 = 0.3
gamma_min = 0.2
gamma_max = 1.2
t_span = (0, 50)
eps = 1e-4

doubling_times = {}
stabilization_times = {}

for gamma in [gamma_min, gamma_max]:
    p = gamma / beta
    sol = solve_ivp(lambda t, y: f(t, y, p, beta), t_span, [y0], method='RK45', atol=eps, rtol=eps)
    
    doubling_time = None
    stabilization_time = None
    
    for i in range(len(sol.t)):
        if doubling_time is None and sol.y[0][i] >= 2 * y0:
            doubling_time = sol.t[i]
        if stabilization_time is None and doubling_time is not None and abs(sol.y[0][i] - sol.y[0][i - 1]) < 0.1:
            stabilization_time = sol.t[i]
            break
    
    doubling_times[gamma] = doubling_time
    stabilization_times[gamma] = stabilization_time

    plt.plot(sol.t, sol.y[0], label=f'gamma = {gamma}')

plt.xlabel('Время')
plt.ylabel('Численность популяции')
plt.title('Динамика численности популяции')
plt.legend()
plt.grid(True)
plt.show()

print("Момент времени удвоения численности популяции:")
for gamma, time in doubling_times.items():
    print(f"При gamma = {gamma}: {time}")
print("Момент времени стабилизации численности популяции:")
for gamma, time in stabilization_times.items():
    print(f"При gamma = {gamma}: {time}")
