  load sampleMatrix.txt                                          %n=input( 'Determine n:' );
                                                         %A=randi([0,9],n,n);
                                                           %B=randi([0 9],n,1); % объявление
disp('Matrix A')                     
disp(sampleMatrix)

dim= length(sampleMatrix);
D=FindDiag(sampleMatrix,dim);                                 %D=diag(A);    
disp('main diag of  A')
disp(D)


C=minRows(sampleMatrix,dim);
disp('array of min in rows of A')
disp(C)

 
    B=abs(C-D); 
 
disp('Array B')
disp(B)





function f=FindDiag(X,dim)
 for i=1:dim
     f(i)=X(i,i);
 end
 
end





function t=minRows(X,dim)
for i=1:dim
    min=X(i,1);
    for j=1:dim
        if (X(i,j)<min)
            min=X(i,j);
        end
        t(i)=min;
    end
end

end