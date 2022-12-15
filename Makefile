main:
	flex conversor.l
	bison -yd -Wconflicts-sr conversor.y
	gcc lex.yy.c y.tab.c -o conversor -lfl -ly
clean:
	rm -rf lex.yy.c y.tab.c y.tab.h