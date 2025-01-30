load a.txt;
load b.txt;

 %n=input( 'Determine n:' );
 %A=rand(1,n); % без load
 %B=rand(1,n);
disp('Array A')
disp(a');
disp('Array B')
disp(b');
n=length(a);

 Asort=sortARR(a,n);    %sortARR- моя функция,не sort() из matlab
 Bsort=sortARR(b,n);

  isAsorted=func(a,Asort);
 isBsorted=func(b,Bsort);

 
 disp('Array A is sorted?')
 f(isAsorted);
 disp('Array B is sorted?')
 f(isBsorted);
 
 
 function h=sortARR(arr,dim)    
for i=1:dim
   for j=1:dim-i-1
    if (arr(j)>arr(j+1)) 
        [arr(j+1),arr(j)]=deal(arr(j),arr(j+1)) ;%  а-ля swap(a,b)
    end
   end
end
h=arr;
end
%Asort=sort(A);   
%Bsort=sort(B);
 
 
 
 
function tf=func(X,Y)
   if(X==Y) 
       tf=true;    %tf=isequal(X,Y);
   else
       tf=false;
   end
end



function  f(r) %void function
if (r==1)
    disp('Indeed sorted')
else
    disp('Not sorted')
end

end

 