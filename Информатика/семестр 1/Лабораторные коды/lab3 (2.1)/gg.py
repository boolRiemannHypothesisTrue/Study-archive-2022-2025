import numpy as np
import math
import scipy.special as s
from matplotlib import pyplot as plt
X = [6.914438399
    ,7.060946468
    ,7.447292458
    ,7.447292458
    ,7.648207254
    ,8.11842443
    ,8.244773789
    ,8.318681529
    ,8.470373738
    ,8.509128461
    ,8.509128461
    ,8.509128461
    ,8.509128461
    ,8.509323088
    ,8.515165873
    ,8.607517515
    ,8.667603273
    ,8.831825814
    ,8.958948796
    ,9.246730705
    ,9.480376311
    ,9.750713062
    ,9.827003415
    ,10.08970039
    ,10.14384679
    ,10.33777718
    ,10.59767652
    ,10.99565475
    ,10.99597174
    ,10.99882547]
N=30
mean=8.942053502
def Sneed(xi,sigma):
    seed=0
    for i in range(1,31):
        seed+=1/(1+np.exp(math.pi*(X[i-1]-xi)/(sigma*np.sqrt(3))))
    seed=(seed/N)-0.5
    return seed
def Chuck(a):
    sig=0
    for i in range (0,30):
        sig+=math.log(X[i])
    sig=((1/N)*sig)-math.log(mean)+math.log(a)-s.digamma(a)
    return sig
rhoarr = [0]*(3*N)
a=mean+1.435
startc=Chuck(a)
a=a+0.05
for i in range (0, (3*N)):
    print('итого Альфа: ', a, s.digamma(a))
    rhoarr[i] = a
    start = Chuck(a)
    a=mean-((startc*(a-mean))/(start-startc))
plt.plot(np.linspace(1,3*N,3*N), rhoarr, 'o', label='Альфа')
plt.show()
print('итого Альфа: ', a)