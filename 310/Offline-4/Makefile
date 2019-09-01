# bison parser makefile
1605109:	1605109.l 1605109.y SymbolTable.h peephole-optimizer.cc 
		bison -d 1605109.y
		flex 1605109.l 
		g++ -std=c++14 -o $@ 1605109.tab.c lex.yy.c peephole-optimizer.cc
