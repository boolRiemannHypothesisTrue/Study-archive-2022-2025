
    program $2117
    integer, parameter:: nmax=100
    integer:: i,n,k=0
    real a(nmax),b(nmax),c(nmax),r,d,mid
   
    integer:: inf=15,outf=16,infY=19,ios
    open(inf,file='input2.txt',iostat=ios)
    !if(ios /=0) stop 'File Error'
    read(inf,*,iostat=ios) n
    !if( ios /= 0 .or. n>nmax) stop 'File Error'
    read(inf,*) (a(i),i=1,n)
    close(inf)
    open(infY,file='input2Y.txt')
     read(infY,*) (b(i),i=1,n)
    close(infY)
    print *,'define R'
    read *, R
    d=0
     open(outf,file='output2.txt')
     write(outf,'("n=",i2)') n
     write(outf,'("X ="$)') 
     do i=1,n
       
         write(outf,'(X,F5.2$)') a(i)
     end do
    write(outf,*)
    write(outf,'("Y ="$)') 
    do i=1,n,1
        write(outf,'(X,F5.2$)') b(i)
    end do
    write(outf,*)

     do i=1,n
         if(( a(i)**2 + b(i)**2 )<=R**2) then
        k=k+1
        end if
        d=d+sqrt( (a(i)**2 + b(i)**2 ))
         
         end do
     
     
        
         midD=d/k
   write(outf,'(X,I2$,X,F7.2)') k,midD
    
     end program $2117

 