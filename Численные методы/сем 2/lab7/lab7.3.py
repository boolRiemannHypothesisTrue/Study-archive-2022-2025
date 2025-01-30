import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve


Z0 = np.array([10.4, 5.2, 8.4, 5.2])
B = np.array([[-59.993, -19.683, -22.495, 138.156],
              [110.216, -50.679, -55.251, -57.296],
              [-79.09, 34.35, -268.27, 26.665],
              [39.72, -130.06, -67.731, -187.06]])

h = 0.001
steps = 1000

def implicit_euler_Z(B, Z0, h, steps):
    Z_values = [Z0]
    for _ in range(steps):
        Z_next = fsolve(lambda Z: Z - Z_values[-1] - h * np.dot(B, Z), Z_values[-1])
        Z_values.append(Z_next)
    return np.array(Z_values)

Z_implicit = implicit_euler_Z(B, Z0, h, steps)

plt.figure(figsize=(12, 10))
for i in range(4):
    plt.subplot(2, 2, i+1)
    plt.plot(Z_implicit[:, i])
    plt.title('Неявный метод Эйлера для Z{}'.format(i+1))

plt.tight_layout()
plt.show()
