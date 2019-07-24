%{
	#include <bits/stdc++.h>
	#include "1605109_SymbolTable.h"
	using namespace std;

	int yyparse();
	int yylex();
	void yyerror(char *msg);
	
	extern int yylineno;
	extern FILE* yyin;
%}

%union {
	SymbolInfo* info;
}

%token <info> NUMBER
%token <info> ADD
%token EOL

%type <info> exp factor term

%%

calc: 
	| calc exp EOL {
		cout << " = " << $2->get_name() << " at line " << yylineno << "\n";
	}
	;

exp:
	factor {
		$$ = new SymbolInfo(*$1);
	}
	| exp ADD factor { 
		$$ = new SymbolInfo(to_string(stoi($1->get_name()) + stoi($3->get_name())), "Expression");
		cout << "Expression matched: " << $1->get_name() << " + " << $3->get_name() << " at line " << yylineno << "\n";
	}
	;

factor:
	term {
		$$ = new SymbolInfo(*$1);
	}
	;

term:
	NUMBER {
		$$ = new SymbolInfo(*$1);
	}
	;

%%

int main(int argc, char **argv) {
	if(argc > 1) {
		if(!(yyin = fopen(argv[1], "r"))) {
			cerr << "Cannot open file \"" << argv[1] << "\"\n";
			return 1;
		}
	}
	
	yylineno = 1;
	yyparse();
}

void yyerror(char *s) {
	cerr << "Error: " << s << "\n";
}