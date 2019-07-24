# bison parser makefile
xen:	scanner.l parser.y
		bison -d parser.y
		flex scanner.l 
		g++ -std=c++14 -o $@ parser.tab.c lex.yy.c