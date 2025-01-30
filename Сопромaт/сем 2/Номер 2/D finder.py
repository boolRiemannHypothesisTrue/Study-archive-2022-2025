import numpy as np



ksigma=2.04586



kd=[0.880000000000000,	0.878990384615385,	0.860000000000000	,0.831009615384615	,0.800000000000000	,0.773461538461539	,0.751923076923077,	0.734423076923077,	0.720000000000000,	0.707692307692308,	0.696538461538461,	0.685576923076923,	0.673846153846154,	0.660384615384615,	0.644230769230769	,0.624423076923077	,0.600000000000000]
kf=0.9
d=np.ndarray(17)
taumax=np.ndarray(17)
for i in range(17):
    d[i]=20+5*i
taunorm=150
ntau=np.ndarray(17)
nsigma=np.ndarray(17)
nFIN=np.ndarray(17)
W=np.ndarray(17)
for i in range(17):
    W[i]=1/32 * 3.14*(d[i])**3
    taumax[i]=0.334*10**3 /(2*W[i])
    ntau[i]=taunorm/taumax[i]
    nsigma[i] = 220* 10**3 *W[i]/(2.04586/(0.9*kd[i]) * 657.42)
    nFIN[i] = nsigma[i] * ntau[i]   / np.sqrt( nsigma[i]**2 + ntau[i]**2 )
    if(nFIN[i]/10000 >= 1.4 and nFIN[i]/10000 <= 1.7):
        #print(nFIN[i]/10000,d[i],kd[i])
        print(nsigma[i]/10000,ntau[i]/10000)
        break 
    
    
    