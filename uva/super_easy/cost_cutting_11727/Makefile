# Ricardo Nieto Fuentes
# nifr91@gmail.com
# Make File para probar problemas de UVA online judge.

name=    main.cpp
exename= main.exe
output=  output.txt
cflags=  -lm -lcrypt -O2 -std=c++11 -pipe -DONLINE_JUDG

compile-and-run:
	@echo "Compilando"
	g++ $(name) -o $(exename) $(cflags)
	@echo
	@echo "Esperando input en stdout"
	@./$(exename)  > $(output)
	@echo
	@echo "Eliminando ejecutable"
	@echo
	@rm -f $(exename)
	@echo
	@echo "El resultado es:"
	@echo
	@cat $(output)

clean:
	rm -f *.exe *.txt
