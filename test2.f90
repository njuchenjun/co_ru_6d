program main
  implicit none
  real*8 :: c(6,1),v0(1),vnn(1),dv(6,1)

  read(*,*) c(1:6,1),v0(1)
  call co_ru_pes(c,vnn,1,dv)

  write(*,*) " potential energy : VASP vs NN"
  write(*,*) v0,vnn
  write(*,*) " derivatives"
  write(*,*) dv

end program
