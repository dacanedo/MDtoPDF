main:
	flex conversor.l
	bison -yd conversor.y
	cc lex.yy.c y.tab.c -o conversor -lfl -ly
clean:
	rm -rf conversor lex.yy.c y.tab.c y.tab.h