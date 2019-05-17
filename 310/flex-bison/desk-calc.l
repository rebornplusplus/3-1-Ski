/*
 recognize tokens for the calculator
 and print them out
*/

%{
%}

%%

"+" 	{ puts("PLUS"); }
"-" 	{ puts("MINUS"); }
"*" 	{ puts("TIMES"); }
"/" 	{ puts("DIVIDE"); }
"|" 	{ puts("ABS"); }
[0-9]+ 	{ printf("NUMBER %s\n", yytext); }
\n 		{ puts(" --- NEWLINE"); }
[ \t] 	{ }
. 		{ printf("Mystery char %s\n", yytext); }

%%
