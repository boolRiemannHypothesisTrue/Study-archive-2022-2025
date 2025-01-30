power=input('Enter eps power:');
N=input('Declare N:');
x=input('Declare x:');
x_t=input('Declare x_t:');
dx = (x_t - x) / (N - 1);
xi = 1;
eps=10.^power;
while (x <= x_t)
        
        i = 1;
        a = x/6;
        S = a;
        
         while (abs(a) > eps) 
           
           
            R = (-1).*x.^2 /((2*i+2)*(2*i+3));
            i=i+1;
            a = a .* R;
            S = S + a;
         end 
        
        y = (x-sin(x))/x.^2;
 fprintf('%d.    %f    %f    %f \n', xi,x,S,y);
 x = x + dx;
 xi = xi + 1;
end