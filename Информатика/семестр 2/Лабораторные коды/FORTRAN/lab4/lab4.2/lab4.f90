 program $4
    implicit none
    integer, parameter:: nmax=3
    integer i,j,n,c
    integer a(nmax,nmax),b(nmax)
    
    integer:: inf=15,ios
    open(inf,file='input5.txt',iostat=ios)
    if(ios /=0) stop 'File Error'
 call matrixIN(inf,a,n)

   
   
  call matrixOUT(a,n)
  call sleep(1)
  call convert(a,b,n)   ! Вычетание из i элементa диагонали минимума i строки
    write(*,'("array :")')
    do i=1,n
        write(*,*) b(i)   
    end do
    
    
    
    contains 
   
    
    
    subroutine matrixIN(f,x,dim)
    integer, intent(in)::f
    integer, intent(out):: dim
    integer,intent(out) :: x(nmax,nmax) 
    integer i,j
    
    read(f,*) dim
    do i=1,dim
        do j=1,dim
            read(f,*) x(i,j)     
        end do
    end do 
    end subroutine matrixIN
    
   
    
    
    
    subroutine matrixOUT(x,dim)
  
    integer, intent(in):: dim
    integer,intent(in) :: x(nmax,nmax)  
    integer i,j
    write(*,'("matrix:")')
        do, i=1,dim
                write(*,*) ( x(i,j), j=1,dim )    !write(*,'(F5.2)') ( x(i,j), j=1,dim )
        end do        
   
    end subroutine matrixOUT
        
   
    
    
    
    subroutine convert(x,y,dim)
   
    integer, intent(in):: dim
    integer,intent(in) :: x(nmax,nmax)  
       integer,intent(out) :: y(nmax) 
    
    integer i,j,min
    do i=1,dim
        
        
        
 
      
      
      
        y(i)=abs((x(i,i)- minx(a(i,:),dim )))!minval(x(i,:),1)))
    end do
    end subroutine
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
    
    end
    