
default: pes.x
	./pes.x < input_znchen

run:	b.exe
	head -n2 test-p1 | b.exe
	@echo -e "\n VASP position and force:"
	@tail -n4 test-p1 | head -n2

b.exe:	test2.o pes.o
	ifort $+ -o $@ -mkl

## pes.x for znchen, evaluation pes with script
## scp pes.x c0:/home/chenjun/CO-Ru/3-code/PES-CO-Ru/a.exe
pes.x:	test.o pes.o
	ifort $+ -o $@ -mkl

%.o:	%.f90
	ifort -c -o $@ $<

clean:
	rm -vf *.exe *.o
