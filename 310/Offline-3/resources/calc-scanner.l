%option noyywrap yylineno

%{
	// #include <bits/stdc++.h>
	#include "1605109_SymbolTable.h"
	#include "parser.tab.h"
	using namespace std;
%}

%%

"+" 	{ yylval.info = new SymbolInfo("+", "ADDOP"); return ADD; }
[0-9]+	{ yylval.info = new SymbolInfo(string(yytext), "NUMBER"); return NUMBER; }
\n 	{ return EOL; }
[ \t] 	{ }
. 	{ std::cout << "Mystery char: " << *yytext << "\n"; }

%%