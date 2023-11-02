program main
  implicit none
  real*8 :: c(6,1),v0(1),vnn(1),dv(6,1)
  real*8 :: rco(9),cc(3,9)
  integer :: i,j,k,imin(1)

  real*8 :: a(3),b(3)
  data a/4.7463322314000056d0,-2.7402961914621891d0, 0.0000000000000000d0/
  data b/0.0000000000000000d0, 5.4805923829243808d0, 0.0000000000000000d0/
  a=a/2.d0
  b=b/2.d0

  do while(.true.)

    read(*,*,end=99) c(1:6,1) !,v0(1)
    call co_ru_pes(c,vnn,1,dv)

    rco=0.d0; rco(5)=dsqrt(dot_product(c(1:3,1)-c(4:6,1),c(1:3,1)-c(4:6,1)))
    if(rco(5).gt.1.45d0) then
      ! too long bond length of CO detected.
      ! move C to the neighbouring cells
      ! find the closest C' to O

      k=0
      do i=-1,1
      do j=-1,1
        k=k+1
        cc(1:3,k)=c(1:3,1)+(i*1.d0)*a+(j*1.d0)*b
        rco(k)=dsqrt(dot_product(cc(1:3,k)-c(4:6,1),cc(1:3,k)-c(4:6,1)))
      enddo
      enddo

      imin=minloc(rco)
      c(1:3,1)=cc(1:3,imin(1))
      call co_ru_pes(c,vnn,1,dv)

    endif

    write(*,'(6es13.5,5f14.8)') c(1:6,1),vnn
  enddo
  99 continue
  stop

! write(*,*) " potential energy : VASP vs NN"
! write(*,*) v0,vnn
! write(*,*) " derivatives"
! write(*,*) dv

end program
