	/**
	 * Flex offline
	 * Lexical Analyzer
	 * 
	 * $ make
	 * $ ./a.out <input_file>
	 * 
	 * Rafid Bin Mostofa
	 * June 01 2019 0129
	**/

%option noyywrap yylineno

%{
	#include <bits/stdc++.h>
	#include "SymbolTable.h"
	#include "1605109.tab.h"
	using namespace std;
	
	/* total errors */
	int tot_err = 0;
	
	/* log and token file */
	// ofstream lex_tokens("lexer_tokens.txt");
	// ofstream lex_log("lexer_log.txt");
	extern ofstream f_err;
	
	/* Current string, yytext */
	string cur_str = "", cur_yytext = "";
	int start_line = yylineno;

	/* Gets the backslash character */
	char get_backslash_const(string ts) {
		if(ts.size() < 2 or ts[0] != '\\') return 0;
		
		char ch = ts[1];
		if(ch == 'n') return '\n';
		if(ch == 't') return '\t';
		if(ch == '\\') return '\\';
		if(ch == '\'') return '\'';
		if(ch == '\"') return '\"';
		if(ch == 'a') return '\a';
		if(ch == 'f') return '\f';
		if(ch == 'r') return '\r';
		if(ch == 'b') return '\b';
		if(ch == 'v') return '\v';
		if(ch == '0') return '\0';
	}
	
	/* Converts a string to upper case */
	string str_uppper(string ts) {
		for(char &c : ts) c = toupper(c);
		return ts;
	}
	
	/* Does the printing */
	void prnt(string c_token, string log_yytext=yytext, string c_yytext=yytext, bool c_keyword=false, bool multi_line = false) {
		// lex_tokens << "<" << c_token;
		// if(!c_keyword) lex_tokens << ", " << c_yytext;
		// lex_tokens << "> ";
		// lex_log << "Line No. " << (multi_line ? start_line : yylineno) << ": Token <" << c_token;
		// lex_log << "> Lexeme " << log_yytext << " found\n\n";
	}
	
	/* Prints error */
	void prnt_err(string err_msg, string c_yytext=yytext, bool multi_line=false) {
		f_err << "Error at line " << (multi_line ? start_line : yylineno) << ": " << err_msg << " " << c_yytext << "\n\n"; 
		++tot_err;
	}
	
	/* take care of punctuations */
	void prnt_punct(string c_token) {
		prnt(c_token);
	}
%}

 /* Little thingies */

DIGIT 	[0-9]
SMALL [a-z]
CAPITAL [A-Z]
ALPHA ({SMALL}|{CAPITAL})
ALPHANUMERIC ({ALPHA}|{DIGIT})
BACKSLASH_CONST \\[nt\'"afrbv0]

EXP ((E|e)("+"|"-")?{DIGIT}+)
DECIMAL ((({DIGIT}*\.{DIGIT}+)|({DIGIT}+\.{DIGIT}*))|{DIGIT}+)
TOO_MANY_DECIMAL ({DIGIT}*\.{DIGIT}*\.({DIGIT}|\.)*)

CHAR (\'([^'"\\\n\t]|{BACKSLASH_CONST})\')

 /* TOKENS */
%x STRING
%x COMMENT
%x SL_COMMENT

%%

 /* ignore whitespaces */
[ \t\n] { }

print2342384 	{ yylval.info = new SymbolInfo(yytext, "PRINTLN"); return PRINTLN; }

 /* START: KEYWORDS */

if 			{ yylval.info = new SymbolInfo(yytext, "IF"); return IF;}
for 		{ yylval.info = new SymbolInfo(yytext, "FOR"); return FOR; }
do 			{ yylval.info = new SymbolInfo(yytext, "DO"); return DO; }
int 		{ yylval.info = new SymbolInfo(yytext, "INT"); return INT; }
float 		{ yylval.info = new SymbolInfo(yytext, "FLOAT"); return FLOAT; }
void 		{ yylval.info = new SymbolInfo(yytext, "VOID"); return VOID; }
switch 		{ yylval.info = new SymbolInfo(yytext, "SWITCH"); return SWITCH; }
default 	{ yylval.info = new SymbolInfo(yytext, "DEFAULT"); return DEFAULT; }
else 		{ yylval.info = new SymbolInfo(yytext, "ELSE"); return ELSE; }
while 		{ yylval.info = new SymbolInfo(yytext, "WHILE"); return WHILE; }
break 		{ yylval.info = new SymbolInfo(yytext, "BREAK"); return BREAK; }
char 		{ yylval.info = new SymbolInfo(yytext, "CHAR"); return CHAR; }
double 		{ yylval.info = new SymbolInfo(yytext, "DOUBLE"); return DOUBLE; }
return 		{ yylval.info = new SymbolInfo(yytext, "RETURN"); return RETURN; }
case 		{ yylval.info = new SymbolInfo(yytext, "CASE"); return CASE; }
continue 	{ yylval.info = new SymbolInfo(yytext, "CONTINUE"); return CONTINUE; }

 /* END: KEYWORDS */
 
 /* START: CONSTANTS; as per offline definitions */

{DIGIT}+ 	{
		string c_token = "CONST_INT";
		prnt(c_token);
		yylval.info = new SymbolInfo(yytext, c_token);
		return CONST_INT;
	}

 /* Floating numbers */
 
{DECIMAL}{EXP}? 	{
		string c_token = "CONST_FLOAT";
		prnt(c_token);
		yylval.info = new SymbolInfo(yytext, c_token);
		return CONST_FLOAT;
	}
	
 /* Character thingies */
 
\'[^'"\\\n\t]\' 	{
		string c_token = "CONST_CHAR";
		string c_yytext = yytext;
		c_yytext = c_yytext.substr(1, 1);
		
		prnt(c_token, yytext, c_yytext);
		yylval.info = new SymbolInfo(c_yytext, c_token);
		return CONST_CHAR;
	}
\'{BACKSLASH_CONST}\' {
		string c_token = "CONST_CHAR";
		string c_yytext = yytext;
		char ch = get_backslash_const(c_yytext.substr(1, c_yytext.size()-2));
		c_yytext = "";
		c_yytext += ch;
		
		prnt(c_token, yytext, c_yytext);
		yylval.info = new SymbolInfo(c_yytext, c_token);
		return CONST_CHAR;
	}
\'\' 	{
		prnt_err("Empty character constant error");
	}
\'(\\\'|[^'\n])* 	{
		prnt_err("Unterminated character");
	}
\'({BACKSLASH_CONST}|[^'\n])+\' 	{
		prnt_err("Multi character constant error");
	}

 /* END: CONSTANTS */
 
 /* START: Operator & Punctuations */

"+"|"-" 	{
		prnt_punct("ADDOP");
		yylval.info = new SymbolInfo(yytext, "ADDOP");
		return ADDOP;
	}
"*"|"/"|"%" 	{
		prnt_punct("MULOP");
		yylval.info = new SymbolInfo(yytext, "MULOP");
		return MULOP;
	}
"++" 	{
		prnt_punct("INCOP");
		yylval.info = new SymbolInfo(yytext, "INCOP");
		return INCOP;
	}
"--" 	{
		prnt_punct("DECOP");
		yylval.info = new SymbolInfo(yytext, "DECOP");
		return DECOP;
	}
"<"|"<="|">"|">="|"=="|"!=" 	{
		prnt_punct("RELOP");
		yylval.info = new SymbolInfo(yytext, "RELOP");
		return RELOP;
	}
"=" 	{
		prnt_punct("ASSIGNOP");
		yylval.info = new SymbolInfo(yytext, "ASSIGNOP");
		return ASSIGNOP;
	}
"&&"|"||" 	{
		prnt_punct("LOGICOP");
		yylval.info = new SymbolInfo(yytext, "LOGICOP");
		return LOGICOP;
	}
"&"|"|"|"^"|"<<"|">>" 	{
		prnt_punct("BITOP");
		yylval.info = new SymbolInfo(yytext, "BITOP");
		return BITOP;
	}
"!" 	{ prnt_punct("NOT"); yylval.info = new SymbolInfo(yytext, "NOT"); return NOT; }
"(" 	{ prnt_punct("LPAREN"); yylval.info = new SymbolInfo(yytext, "LPAREN"); return LPAREN; }
")" 	{ prnt_punct("RPAREN"); yylval.info = new SymbolInfo(yytext, "RPAREN"); return RPAREN; }
"{" 	{ prnt_punct("LCURL"); yylval.info = new SymbolInfo(yytext, "LCURL"); return LCURL; }
"}" 	{ prnt_punct("RCURL"); yylval.info = new SymbolInfo(yytext, "RCURL"); return RCURL; }
"[" 	{ prnt_punct("LTHIRD"); yylval.info = new SymbolInfo(yytext, "LTHIRD"); return LTHIRD; }
"]" 	{ prnt_punct("RTHIRD"); yylval.info = new SymbolInfo(yytext, "RTHIRD"); return RTHIRD; }
"," 	{ prnt_punct("COMMA"); yylval.info = new SymbolInfo(yytext, "COMMA"); return COMMA; }
";" 	{ prnt_punct("SEMICOLON"); yylval.info = new SymbolInfo(yytext, "SEMICOLON"); return SEMICOLON; }

 /* END: Operator and Punctuations */
 
 /* START: Idenitifiers */

({ALPHA}|"_")+({ALPHANUMERIC}|"_")* 	{
		string c_token = "ID";
		prnt(c_token);
		yylval.info = new SymbolInfo(yytext, "ID");
		return ID;
	}
{DIGIT}+({ALPHANUMERIC}|"_")+ 	{
		prnt_err("Invalid prefix on ID or invalid suffix on Number");
	}

 /* END: Idenitifiers */

 /* START: STRING definitions */
 
\"	{
		BEGIN(STRING);
		cur_str = "";
		cur_yytext = yytext;
		start_line = yylineno;
	}

<STRING><<EOF>> 	{
		prnt_err("Unterminated string", cur_yytext, true);
		BEGIN(INITIAL);
		cur_str = "";
		cur_yytext = "";
	}

<STRING>\\\n 	{
		cur_yytext += yytext;
	}

<STRING>[^"\n] 	{
		cur_str += yytext;
		cur_yytext += yytext;
	}

<STRING>{BACKSLASH_CONST} {
		cur_str += get_backslash_const(yytext);
		cur_yytext += yytext;
	}

<STRING>\n 	{
		prnt_err("Unterminated string", cur_yytext, true);
		BEGIN(INITIAL);
		cur_str = "";
		cur_yytext = "";
	}

<STRING>\" 	{
		cur_yytext += yytext;
		prnt("STRING", cur_yytext, cur_str, false, true);
		BEGIN(INITIAL);
		cur_str = "";
		cur_yytext = "";
	}

 /* END: STRING definitions */
 
 /* START: C-COMMENT definitions */

\/\* 	{
		BEGIN(COMMENT);
		cur_yytext = yytext;
		start_line = yylineno;
	}

<COMMENT><<EOF>> 	{
		prnt_err("Unterminated comment", cur_yytext, true);
		BEGIN(INITIAL);
		cur_yytext = "";
	}

<COMMENT>[^*]+ 	{
		cur_yytext += yytext;
	}

<COMMENT>(\*\/) 	{
		cur_yytext += yytext;
		// lex_log << "Line No. " << start_line << ": Token <" << "COMMENT";
		// lex_log << "> Lexeme " << cur_yytext << " found\n\n";

		BEGIN(INITIAL);
		cur_yytext = "";
	}

<COMMENT>(\*) 	{
		cur_yytext += yytext;
	}

 /* END: C-COMMENT definitions */
 
 /* START: Single Line COMMENT definitions */

\/\/ 	{
		BEGIN(SL_COMMENT);
		cur_yytext = yytext;
		start_line = yylineno;
	}

<SL_COMMENT>(([^\n]+)(\\\n)?)+ 	{
		cur_yytext += yytext;
	}

<SL_COMMENT>\n 	{
		// lex_log << "Line No. " << start_line << ": Token <" << "COMMENT";
		// lex_log << "> Lexeme " << cur_yytext << " found\n\n";
		
		BEGIN(INITIAL);
		cur_yytext = "";
	}
	
<SL_COMMENT><<EOF>> 	{
		// lex_log << "Line No. " << start_line << ": Token <" << "COMMENT";
		// lex_log << "> Lexeme " << cur_yytext << " found\n\n";
		
		BEGIN(INITIAL);
		cur_yytext = "";
	}

 /* END: Single Line COMMENT definitions */

. 	{
		prnt_err("Unrecognized character");
	}

%%

// int main(int argc, char **argv) {
// 	if(argc > 1) {
// 		if(!(yyin = fopen(argv[1], "r"))) {
// 			cout << "Error! Can't open file \"argv[1]\"\n";
// 			return 1;
// 		}
// 	}

// 	cur_str = "";
// 	yylineno = 1;
// 	yylex();
	
// 	lex_tokens << "\n";
// 	lex_log << "Total Lines: " << yylineno-1 << "\n";
// 	lex_log << "Total Errors: " << tot_err << "\n";
	
// 	lex_tokens.close();
// 	lex_log.close();

// 	return 0;
// }
