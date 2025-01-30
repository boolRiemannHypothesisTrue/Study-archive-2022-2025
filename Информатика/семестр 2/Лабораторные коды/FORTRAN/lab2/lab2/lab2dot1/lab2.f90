

program lab2dot1
   !1.10 var17

    integer power, N, xi, i,j
    character(20) fmt, fmt_head
    real eps, a, S, x, x_t, dx, y,R
    
    print '("Enter eps power = "$)'
    read '(I1)', power	

    

  
   write (fmt, '("F", I1, ".", I1)') power+3, power
    write (fmt_head, '("A",I1)') power+3
    eps = 10.0 ** (-power)			
    print '("eps = 10 ** (- power) = ",' // fmt // ')', eps	
    
 
    print '("Enter N, a, b")'
    read *, N, x, x_t	
 
    

    
    dx = (x_t - x) / (N - 1)	
    xi = 1
    do while (x <= x_t)
        
        i = 1
        a = x/6
        S = a
        
        do while (abs(a) > eps) 
           
           
            R = (-1)*x**2 /((2*i+2)*(2*i+3))
            i = i + 1
            a = a * R 
            S = S + a
        end do
        
        y = (x-sin(x))/x**2
  !  print '(I3, 3(2X, ' // fmt // '))', xi, x, S, y
       write(*,                                                               '(I3,X,F7.2,X,F7.5,X,F7.5)') xi,x,S,y
       call sleep(1) 
        x = x + dx
        xi = xi + 1
    end do 
    contains none
    
end 

 