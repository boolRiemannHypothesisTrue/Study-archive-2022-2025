  program $2117
    integer, parameter:: nmax=100
    integer i,n
    real a(nmax),b
    
    integer:: inf=15,outf=16,ios
    open(inf,file='input3.txt',iostat=ios)
    if(ios /=0) stop 'File Error'
    read(inf,*,iostat=ios) n
    if( ios /= 0 .or. n>nmax) stop 'File Error'
    read(inf,*) (a(i),i=1,n)
    close(inf)
     open(outf,file='output3.txt')
     write(outf,'("n=",i2)') n
     write(outf,'("A ="$)') 
     do i=1,n
       
         write(outf,'(X,F5.2$)') a(i)
     end do
     write(outf,*)
     write(outf,*) ' min b = '
     b=a(2)**2 - a(1)**2
    do i=2,n,1
          if( (a(i)**2 - a(i-1)**2)<b) then
              b=a(i)**2 - a(i-1)**2
          end if
    end do 
    write(outf,'(F6.2)') b
     end program $2117


