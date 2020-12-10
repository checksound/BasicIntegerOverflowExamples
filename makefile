all: ex1 width1 ex2 ex3 ex4

ex1: ex1.c
	gcc -o ex1 ex1.c

width1: width1.c
	gcc -o width1 width1.c

ex2: ex2.c
	gcc -o ex2 ex2.c

ex3: ex3.c
	gcc -o ex3 ex3.c

ex4: ex4.c
	gcc -o ex4 ex4.c

.PHONY: clean

clean:
	rm ex1 ex2 width1 ex3 ex4

	



