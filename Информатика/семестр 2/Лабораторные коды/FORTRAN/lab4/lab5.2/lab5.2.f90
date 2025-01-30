 program $4
     implicit none
     integer, parameter:: nmax=3
     integer i,j,n
     integer a(nmax,nmax),c(nmax)
     logical, parameter:: r=0  !mode
     logical, parameter:: m=1 !mode
     integer:: inf=15,inf2=16,ios
  
    open(inf,file='input6.txt',iostat=ios)
    if(ios /=0) stop 'File 1 Error'
     open(inf2,file='input7.txt',iostat=ios)
    if(ios /=0) stop 'File 2 Error'
 call arrayIN(inf,inf2,a,c,n,r)!matrix in
 call arrayIN(inf,inf2,a,c,n,m)!array in
 call arrayOUT(a,c,n,r) !matrix out
 call convert(a,c,n)
 call arrayOUT(a,c,n,m)  !array out
 
    
    
    contains 
   
    
    
    subroutine arrayIN(f,g,x,y,dim,mode)
    logical, intent(in)::mode
    integer, intent(in)::f
    integer, intent(in)::g
    integer, intent(out):: dim
    integer, intent(out) :: x(nmax,nmax) 
    integer, intent(out) :: y(nmax)
    integer i,j
    if (mode/=1) then
         read(f,*) dim
    do i=1,dim
        do j=1,dim
            read(f,*) x(i,j)     
        end do
    end do 
    else 
         read(g,*) dim
        do i=1,dim
        read(g,*) y(i)    
    end do
    end if
    
    end subroutine arrayIN
    
   
    
     subroutine arrayOUT(x,y,dim,mode)
    logical, intent(in)::mode
    integer, intent(in):: dim
    integer,intent(in) :: x(nmax,nmax) 
    integer,intent(in) :: y(nmax)
    integer i,j
if (mode/=1) then
    write(*,'("matrix A:")')
        write(*,*)
        do, i=1,dim
                write(*,*) ( x(i,j), j=1,dim )    !write(*,'(F5.2)') ( x(i,j), j=1,dim ) вывод ломается
        end do        
               write(*,*)
    else 
    write(*,'("array C:")')
        write(*,*)
        do i=1,dim
                   write(*,*) y(i)
        end do
 end if
    
    end subroutine arrayOUT
    
    
    
    
    
    subroutine convert(x,y,dim)
    integer, intent(in):: dim
    integer,intent(in) :: x(nmax,nmax)  
    integer,intent(out) :: y(nmax) 
    integer i,j,k
    k=0
    do i=1,dim
        if(y(i)<=x(i,i)) k=k+1 
      
    end do
     write(*,'("Number of convertions in array C=",i1)') k 
     write(*,*)
  
    
    if(k==0) then
        write(*,'("Printing converted array C")')    
        write(*,*)
        do i=1,dim
            y(i)=minx(x(i,:),1)
        end do
    else
            write(*,'("Printing original array C")')   
            write(*,*)
    end if
    
    end subroutine convert
    
    function minx(a,dim)
    implicit none
    integer minx
    integer, parameter ::nmax=3
     integer, intent(in):: dim  
    integer,intent(in) :: a(nmax)  
      
      integer i,min
      
     min=a(1)
     do i=1,dim
         if(min<a(i)) min=a(i)
     end do
    minx= min
     
  
   
    end function minx
     
    
    end program
    