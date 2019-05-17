# part of the makefile
xen:	calculation-scanner.l calculator.y
	bison -d calculator.y
	flex calculation-scanner.l
	cc -o $@ calculator.tab.c lex.yy.c -lfl
