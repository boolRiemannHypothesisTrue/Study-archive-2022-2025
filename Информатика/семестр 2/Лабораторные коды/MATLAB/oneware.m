load a.txt; load b.txt
ca = func(a);
cb = func(b);
if ca > cb
    disp(a);
else
if cb > ca
    disp(b);
else
    disp(func(a))
end
end



function counter = func(x)
n = length(x);
counter = 0;
 
for i = 1:n    
if x(i) < 0
        counter=counter+1;       
end
end
end