import math as m
b0=-40*m.pi      
q=-0.999999   
z=b0/(1-q)

def  S(N):
    res=0
    for i in range(N+1):
        res+=b0*q**i
    return res

for i in range (1,9):
    partSum=S(10**i)
   # if i%2!=0:
    print ('{0:.15f} {1:.15f} {2:.15f}   {3:4d}'.format(partSum, z, abs(partSum-z),  i))
   # else:
        #print ('{0:.15f} {1:.15f} {2:.15f}   {3:4d}'.format(partSum, z, abs(partSum-z),  i))
         



#eps=1.0
#while 1.0+eps/2>1.0:
#    eps=eps/2
#print(eps)




#zero =1.0
#while zero/2>0:
#        zero=zero/2
#print (zero)




#inf =1.0
#while np.isfinite (2*inf):
#       inf*=2
#print (inf)


