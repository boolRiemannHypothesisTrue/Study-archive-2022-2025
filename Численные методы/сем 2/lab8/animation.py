import numpy as np
from matplotlib import pyplot as plt
from matplotlib.animation import FuncAnimation
from IPython.display import HTML
l=1
Ua = 3
Ub =-3
def f(x):
 return x**3 + 3
def F(x, t):
 return f(x) * (1 - np.exp(-t))
def phi(x):
 return Ua + x * (Ub - Ua)/l
N = 10
h = l / 10
tau = h**2 / 2
def U_a(x):
 return (60 - 89 * x - 30 * x**2 - x**5) / 20


def find_u(N, K):
 U = np.zeros([K+1, N+1])
 #первая кордината -- t
 #вторая координата -- х
 for j in range(K+1):
    U[j, 0] = Ua
    U[j, N] = Ub
 for i in range(N+1):
    U[0, i] = phi(i * h)

 g = tau / h**2

 for j in range(K):
    for i in range(1, N):
        U[j+1, i] = (g * U[j, i - 1] + (1 - 2 * g) * U[j, i] + g * U[j, i + 1]+ tau * F( i * h, j * tau))

 return U
K = 500
U = find_u(N, K)
fig, ax = plt.subplots(1, 1, figsize = (6, 5))
x_data = np.linspace(0, l, N+1, endpoint = True)
line1, = ax.plot(x_data, U[0])
line2, = ax.plot(x_data, U_a(x_data))
def update1(frame):
 if frame % 10 == 0:
    print(f"{100 * frame/K:.0f}%", end=" ")

 line2.set_ydata(U_a(x_data))
 line1.set_ydata(U[frame])
 ax.set_xlabel(f"t={frame * tau:.2f}")
 return line1, line2
animation1 = FuncAnimation(fig, update1, frames = range(K+1),
 interval = int(5000 / K), blit = False)
HTML(animation1.to_jshtml())