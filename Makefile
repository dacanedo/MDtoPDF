main:
	flex conversor.l
	bison -yd conversor.y
	gcc lex.yy.c y.tab.c -o conversor -lfl -ly -lhpdf
	
clean:
	rm -rf log.txt salida.pdf lex.yy.c y.tab.c y.tab.h