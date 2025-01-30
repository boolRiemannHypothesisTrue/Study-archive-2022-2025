import numpy as np
import matplotlib.pyplot as plt

R1 = 0.18
R2 = 0.21  # meter
p1 = 7 * 10**6  # Pa
p2 = 2 * 10**6
T1 = 170  # Celsius
T2 = 130
deltaT = T1 - T2
E = 200 * 10**9  # Pa
alpha = 1.25 * 10**(-5)  # inv Celsius
PoissonCoeff = 0.3
sigmaflow = 280 * 10**6

r = np.linspace(R1, R2, 250)

## сначала строишь блок из 3-х sigma_p ;потом 3-х sigma_T ;потом уже из 4-х ( 3 суммарных p+T и + график который покажет опасную точку) 
# в функции plot просто меняешь второй аргумент
sigma_r_p = (p1 * R1**2 - p2 * R2**2) / (R2**2 - R1**2) - (p1 - p2) * ((R1 * R2)**2) / ((R2**2 - R1**2) * r**2)
sigma_theta_p = (p1 * R1**2 - p2 * R2**2) / (R2**2 - R1**2) + (p1 - p2) * ((R1 * R2)**2) / ((R2**2 - R1**2) * r**2)
sigma_z_p = (p1 * R1**2 - p2 * R2**2) / (R2**2 - R1**2) + 0 * r  # Necessary 

K = E * alpha * deltaT / (2 * (1 - PoissonCoeff) * np.log(R2 / R1))
sigma_r_t = -K * (np.log(R2 / r) + (R1**2) * (1 - (R2**2) / (r**2)) * np.log(R2 / R1) / (R2**2 - R1**2))
sigma_theta_t = K * (1 - np.log(R2 / r) - (R1**2) * (1 + (R2**2) / (r**2)) * np.log(R2 / R1) / (R2**2 - R1**2))
sigma_z_t = K * (1 - 2 * np.log(R2 / r) - 2 * (R1**2) * np.log(R2 / R1) / (R2**2 - R1**2))

plt.figure(figsize=(10, 8))

plt.subplot(2, 2, 1)
plt.plot(r, sigma_r_p + sigma_r_t)
plt.grid(True, which='both', linestyle='-', linewidth=0.5)
plt.title('Sigma_r')

plt.subplot(2, 2, 2)
plt.plot(r, sigma_theta_p + sigma_theta_t)
plt.grid(True, which='both', linestyle='-', linewidth=0.5)
plt.title('Sigma_theta')

plt.subplot(2, 2, 3)
plt.plot(r, sigma_z_p + sigma_z_t)
plt.grid(True, which='both', linestyle='-', linewidth=0.5)
plt.title('Sigma_z')

sigma_sum = np.abs(sigma_z_p + sigma_z_t) + np.abs(sigma_theta_p + sigma_theta_t) + np.abs(sigma_r_p + sigma_r_t)
plt.subplot(2, 2, 4)
plt.plot(r, sigma_sum)
plt.grid(True, which='both', linestyle='-', linewidth=0.5)
plt.title('Sigma_sum')

# Strength calculation according to Saint-Venant: sigma_eqv = sigma1 - sigma3; sigma1 = sigma theta, sigma3 = sigma r
sigma_eqv = (sigma_theta_p[-1] + sigma_theta_t[-1]) - (sigma_r_p[-1] - sigma_r_t[-1])
n = sigmaflow / sigma_eqv
print(n)

plt.show()
