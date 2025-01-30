!  lab2dot2.f90 
!
!  FUNCTIONS:
!  lab2dot2 - Entry point of console application.
!

!****************************************************************************
!
!  PROGRAM: lab2dot2
!
!  PURPOSE:  Entry point for the console application.
!
!****************************************************************************

    program lab2dot2
   !1.11 var17

   
 
    real a,b,t,eps,Fa,Fb,Ft
    
    
  !  print '("Enter eps power = "$)'
   ! read '(I1)', power	
    eps = 10.0 **(-4) !(-power)			
  ! print '("eps = 10 ** (- power) = " )', eps	

5 continue 
 
    print '("Determine a, b such as a<=b")'
    read (*,*)  a,b

    if(a>b) goto 5
   Fa= sqrt( log(7.9) +exponent(-a) - (a**2.0)/11.0 ) -a
   Fb= sqrt( log(7.9) +exponent(-b) - (b**2.0)/11.0 ) -b
   
    do while( abs(a-b)>eps)
        c=(a+b)/2 ! поиск медианы отрезка
        Fc= sqrt( log(7.9)+exponent(-c) - (c**2.0)/11.0 )-c

      if((Fc*Fa)>0) then
          a=c
          Fa=Fc
      else
          b=c
          Fb=Fc
     end if
    end do
    call sleep(1)
write(*,                                                               '(F7.5,X,F10.5,X)') c,Fc


   
    
    
    
    
    
    
    
    end program lab2dot2

