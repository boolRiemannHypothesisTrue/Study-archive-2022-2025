# Libs
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import scipy as sp
import math as m
# DIAFRAGMA
d=0.0044
D=0.0079
F0=0.25*m.pi*(d*d)

DM = np.array([0.466, 0.465, 0.489, 0.466, 0.474, 0.481])


TAU = np.array([11.92, 12.39, 13.74, 17.87,21.88, 40.01])# Time to spill
H1 = np.array([1.200, 1.05, 0.9, 0.75, 0.6, 0.455])# Height of first pipe
H2 = np.array([0.46, 0.45, 0.445, 0.435, 0.42, 0.405])# Height of second pipe
DH=np.zeros(len(H1))
for i in range(0, len(H1)):
    DH[i]=H1[i]-H2[i] #Counting DH
FREQ = np.array([2.6, 2.3,2, 1.6, 1.15, 0.4])# Turbine frequency
AIR_DENSITY=1.161
WATER_DENSITY=998.520 #Mean
DP=np.zeros(len(H1))
for i in range(0, len(DH)):
    DP[i]=9.805*DH[i]*(WATER_DENSITY-AIR_DENSITY) #Counting Pressure Diff
GEXP=np.zeros(len(DP))
for i in range(0, len(DP)):
    GEXP[i]=DM[i]/TAU[i] #Counting GEXP
ALPHA=np.zeros(len(DP))
for i in range(0, len(DP)):
    ALPHA[i]=GEXP[i]/(F0*m.sqrt(2*WATER_DENSITY*DP[i])) #Counting ALPHA
RE = np.zeros(len(GEXP))
for i in range(0, len(DP)):
    RE[i] = (4*GEXP[i]) / (m.pi *D* 0.001056)  # Counting RE, Const is the DynViscosityCoeff
S_result_dict = {
    'М, кг': DM,
    'T, с': TAU,
    'DH, м': DH,
    'FREQ, Гц': FREQ,
    'G, кг/с': GEXP,
    'DP, Па': DP,
    'Альфа': ALPHA,
    'Рейнольдс': RE
}
S_result = pd.DataFrame(S_result_dict, index=np.arange(1, 7))
print(S_result)
a = np.polyfit(RE, ALPHA, 3) #АППРОКС. КУБ. МНОГОЧЛЕНОМ
def ALPHAFIT(x):
    return np.polyval(a,x)
x = np.linspace(RE[0], RE[5],100)
plt.figure(figsize=(7, 7))
plt.xlabel('Re', fontsize=12)
plt.ylabel('Alpha', fontsize=12)
plt.plot(RE, ALPHA, 'o', label='EXPERIMENT', markersize=5)
plt.plot(x, ALPHAFIT(x), label='POLYFIT')
plt.grid(True)
plt.legend()
plt.show()
deltarand=0
GEXPMEAN=0
for i in range(0, len(GEXP)):
    GEXPMEAN += GEXP[i]
GEXPMEAN=GEXPMEAN/6
for i in range(0, len(GEXP)):
    deltarand+=(GEXP[i]-GEXPMEAN)**2
deltarand=2.57058183661*deltarand/30
deltagexp=m.sqrt((0.001+0.01)**2+deltarand**2)
print(deltagexp)#ПОГРЕШНОСТЬ РАСХОДА

# ROTAMETER

DMROT=np.array([0.484, 0.484, 0.482, 0.487, 0.484, 0.469])
TAUROT = np.array([40, 30.32, 13.46, 10.56, 8, 6.39])# Time to spill
GEXPROT=np.zeros(len(DMROT))
for i in range(0, len(DP)):
    GEXPROT[i]=3600000*DMROT[i]/(TAUROT[i]*WATER_DENSITY) #Counting GEXP
FREQROT = np.array([0,1.2, 2.2, 2.9, 3.9, 4.8])# FREQ
SCALE= np.array([0, 20, 40, 60, 80, 100])# SCALE

B = np.polyfit(SCALE, GEXPROT, 1) #АППРОКС. КУБ. МНОГОЧЛЕНОМ
ALPHA_FIT = np.polyval(B, range(SCALE[0], SCALE[5],1))
plt.figure(figsize=(7, 7))
plt.xlabel('scale', fontsize=12)
plt.ylabel('V, л/ч', fontsize=12)
plt.plot(SCALE, GEXPROT, 'o', label='EXPERIMENT', markersize=5)
plt.plot(range(SCALE[0], SCALE[5],1), ALPHA_FIT, label='POLYFIT')
plt.grid(True)
plt.legend()
plt.show()
S_result_dict = {
    'М, кг': DMROT,
    'T, с': TAUROT,
    'FREQ, Гц': FREQROT,
    'V, л/ч': GEXPROT
}
S_result = pd.DataFrame(S_result_dict, index=np.arange(1, 7))
print(S_result)
deltagexp=0
for i in range (0,5):
    if ((GEXPROT[i]-np.polyval(B,SCALE[i]))>deltagexp):
        deltagexp=GEXPROT[i]-np.polyval(B,SCALE[i])
print('ROTAMETER -- ',deltagexp)#ПОГРЕШНОСТЬ ЛИНЕЙНАЯ РАСХОДА
SPRAVKA = np.array([20, 46, 76, 107, 140, 171])# SCALE
deltagexp=0
for i in range (0,5):
    if ((GEXPROT[i]-SPRAVKA[i])>deltagexp):
        deltagexp=GEXPROT[i]-SPRAVKA[i]
print('ROTAMETERSPRAVKA -- ',deltagexp)#ПОГРЕШНОСТЬ РАСХОДА по справочным данным