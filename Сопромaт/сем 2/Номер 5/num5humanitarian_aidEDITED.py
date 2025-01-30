import numpy as np
import matplotlib.pyplot as plt

a = 0.05
R = 0.90
p0 = 0.6 * 10**6
q = 0.2 * 10**6
m=q*a
E = 200 * 10**9
sigma = 240 * 10**6
Nx = 0
mu = 0.3

h = 10 * p0 * R / sigma  # оптимизированное значение толщины
print('Value of h =', h, 'm')

D = E * h**3 / (12 * (1 - mu**2))
print('Cylindrical stiffness D =', D)

k = (E * h / (4 * D * R**2))**(1 / 4)
print('Wave number k =', k, 'm^-1')

lambda_val = np.pi / k
print('Edge effect length λ =', lambda_val, 'm')
C=np.array([[0,1],
           [1,1]])
b=np.array([ m / (2 * D * k**2),0])

consts = np.linalg.solve(C, b)
C1 = consts[0]
C2 = consts[1]
print('Coefficients C:')
print('C1 =', C1)
print('C2 =', C2)

x = np.linspace(0, 2 * lambda_val, 100)

# Функции для вычисления величин
W = lambda x: C1 * np.exp(-k * x) * np.cos(k * x) + C2 * np.exp(-k * x) * np.sin(k * x) + p0 * R**2 / (E * h)
phi = lambda x: -k * np.exp(-k * x) * ((C1 - C2) * np.cos(k * x) + (C1 + C2) * np.sin(k * x))
Mx = lambda x: 2 * k**2 * np.exp(-k * x) * D * (C1 * np.sin(k * x) - C2 * np.cos(k * x))
My = lambda x: mu * Mx(x)
Ny = lambda x: mu * Nx + E * h / R * W(x)
Q = lambda x: 2 * k**3 * D * np.exp(-k * x) * ((C1 + C2) * np.cos(k * x) - (C1 - C2) * np.sin(k * x))
sigma_x_inner = lambda x: Nx / h + 6 * Mx(x) / h**2
sigma_x_outer = lambda x: Nx / h - 6 * Mx(x) / h**2
sigma_y_inner = lambda x: Ny(x) / h + 6 * My(x) / h**2
sigma_y_outer = lambda x: Ny(x) / h - 6 * My(x) / h**2
sigma_eqv_inner = lambda x: np.sqrt(sigma_x_inner(x)**2 + sigma_y_inner(x)**2 - sigma_x_inner(x) * sigma_y_inner(x))
sigma_eqv_outer = lambda x: np.sqrt(sigma_x_outer(x)**2 + sigma_y_outer(x)**2 - sigma_x_outer(x) * sigma_y_outer(x))

# Графики
fig, axs = plt.subplots(2, 2, figsize=(10, 8))
fig.suptitle('Moment, Reinforcement, and Force', fontsize=16)
plot_functions = [Mx, My, Ny, Q]
plot_ylabels = ['$M_x(x)$, kN/m', '$M_y(x)$, kN/m', '$N_y(x)$, MN/m', '$Q(x)$, kN']
for i, ax in enumerate(axs.flat):
    ax.plot(x, plot_functions[i](x) / 1e3, 'k')
    ax.fill_between(x, 0, plot_functions[i](x) / 1e3, color='lightgrey', hatch='||', edgecolor='black')
    ax.set_xlabel('$x$, m', fontsize=12)
    ax.set_ylabel(plot_ylabels[i], fontsize=12)
    ax.set_title(plot_ylabels[i].split(',')[0], fontsize=12)
    ax.grid(True)
    ax.grid(which='minor', linestyle='-', linewidth='0.5', color='k', alpha=0.2)
    ax.grid(which='major', linestyle='-', linewidth='0.5', color='k', alpha=0.8)
plt.tight_layout()

# Графики эквивалентных напряжений и прочности
fig, axs = plt.subplots(2, 2, figsize=(10, 8))
fig.suptitle('Equivalent Stresses, Deflection, and Angular Displacement', fontsize=16)
plot_functions = [sigma_eqv_outer, sigma_eqv_inner, W, phi]
plot_ylabels = ['$\sigma_{eqv}$, MPa', '$\sigma_{eqv} $, MPa', '$W(x)$, m', '$\phi(x)$, rad']
for i, ax in enumerate(axs.flat):
    ax.plot(x, plot_functions[i](x) / 1e6, 'k')
    ax.fill_between(x, 0, plot_functions[i](x) / 1e6, color='lightgrey', hatch='||', edgecolor='black')
    ax.set_xlabel('$x$, m', fontsize=12)
    ax.set_ylabel(plot_ylabels[i], fontsize=12)
    ax.set_title(plot_ylabels[i].split(',')[0], fontsize=12)
    ax.grid(True)
    ax.grid(which='minor', linestyle='-', linewidth='0.5', color='k', alpha=0.2)
    ax.grid(which='major', linestyle='-', linewidth='0.5', color='k', alpha=0.8)
plt.tight_layout()

# Расчет коэффициента запаса прочности
sigma_eqv_inner_max = np.max(np.abs(sigma_eqv_inner(x)))
sigma_eqv_outer_max = np.max(np.abs(sigma_eqv_outer(x)))
print('Maximum equivalent stress for inner surface σ_eqv_inner_max =', sigma_eqv_inner_max / 1e6, 'MPa')
print('Maximum equivalent stress for outer surface σ_eqv_outer_max =', sigma_eqv_outer_max / 1e6, 'MPa')
if sigma_eqv_inner_max > sigma_eqv_outer_max:
    n = sigma / sigma_eqv_inner_max
else:
    n = sigma / sigma_eqv_outer_max
print('Safety factor n =', n)
plt.show()
