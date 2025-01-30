
    program $2117
    integer, parameter:: nmax=100
    integer i,n
    real a(nmax),c(nmax-1)
    
    integer:: inf=15,outf=16,ios
    open(inf,file='input.txt',iostat=ios)
    if(ios /=0) stop 'File Error'
    read(inf,*,iostat=ios) n
    if( ios /= 0 .or. n>nmax) stop 'File Error'
    read(inf,*) (a(i),i=1,n)
    close(inf)
     open(outf,file='output.txt')
     write(outf,'("n=",i2)') n
     write(outf,'("A ="$)') 
     do i=1,n
        ! write(outf,'(X,I2$)') a(i)
         write(outf,'(X,F5.2$)') a(i)
     end do
     write(outf,*)
     write(outf,'("C ="$)') 
     do i=1,n
         c(i)=a(i)*i
         ! write(outf,'(X,I2$)') c(i)
         write(outf,'(X,F5.2$)') c(i)
     
     end do
    
    
     end program $2117

