/* simplest version of calculator */

%{

#include <stdio.h>

%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP	/* Parenthesis */ 
%token EOL

%%

calclist: /* nothing */
	| EOL { } // do nothing
	| calclist exp EOL { printf("= %d\n", $2); }
	;

exp: factor	/* default $$ = $1 */ 
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }
	;

factor: term /* default $$ = $1 */
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	;

term: NUMBER /* default $$ = $1 */
	| SUB term { $$ = -$2; }
	| ADD term { $$ = $2; }
	| ABS exp ABS { $$ = $2 >= 0 ? $2 : -$2; }
	| OP exp CP { $$ = $2; }
	;

%% 

int main(int argc, char **argv) {
	yyparse();
}

void yyerror(char *s) {
	fprintf(stderr, "error: %s\n", s);
}
