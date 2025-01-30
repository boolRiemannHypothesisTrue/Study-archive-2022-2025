a=input('Determine a:');
b=input('Determine b:');
  eps = 10.0 .^(-4);
                        % Fa= sqrt( log(7.9) +exp(-a) - (a.^2.0)/11.0 ) -a;
                             %Fb= sqrt( log(7.9) +exp(-b) - (b.^2.0)/11.0 ) -b;
   if (a>b)
       error('Error,invalid a,b values')
      
  end
      x=root(a,b,eps,@func);
    
      fprintf('y=%f   x=%f       \n', x ,  func(x) );
function y=func(x)
y=sqrt( log(7.9) +exp(-x) - (x.^2.0)/11.0 ) -x;
end



function x=root(a,b,eps,f)
while( abs(a-b)>eps)
        x = (a+b)/2;
                                                %Fc= sqrt( log(7.9)+exp(-c) - (c.^2.0)/11.0 )-c;

      if((f(a)*f(x))>0) 
          a=x;
                                                      %  Fa=Fc;
      else
          b=x;
                                                    %Fb=Fc;
      end 
end
     end 