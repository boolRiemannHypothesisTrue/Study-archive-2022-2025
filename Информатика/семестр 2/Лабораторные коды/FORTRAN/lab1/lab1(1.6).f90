program lab116

    !implicit none// С ним код выдает ошибку и ссылается на sqrt
    integer i,n
    real x,y,dx,A   
    write (*,*) 'Determine n value'
    read (*,*) n
     write (*,*) 'Determine A value'
     read (*,*) A
     call sleep(5)   !pause for () sec
     
     x=-2*A     dx=A/5
     do i=1,n,1
         if(x<0) then
             y=  A*(3**(1.0/3.0))*(1-sqrt(-x**3))  
         else 
             y= sqrt(sqrt(16*(A**4) + 4*(A**2)*(x**2) )-x**2 - A**2)  
         end if
!4 continue         
    write(*, '(I3,X,F6.2,X,F6.2)') i,x,y
    x=x+dx
     end do
   
    end program lab116

