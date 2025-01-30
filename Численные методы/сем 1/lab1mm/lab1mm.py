import math as m
b0=-40*m.pi
q=-0.999999
k=-m.log(abs(b0))/m.log(abs(q))
k=int(k)+1
print (k)   #first b<1
print (b0*q**(k-1), b0*q**k)   
z=b0/(1-q)
print (z)      #sum

 