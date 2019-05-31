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
	#include "1605109_SymbolTable.h"
	using namespace std;

	/* SymbolTable of 7 blocks */
	SymbolTable st(7);
	
	/* total errors */
	int tot_err = 0;
	
	/* log and token file */
	ofstream f_token("1605109_tokens.txt");
	ofstream f_logs("1605109_log.txt");
	
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
		f_token << "<" << c_token;
		if(!c_keyword) f_token << ", " << c_yytext;
		f_token << "> ";
		f_logs << "Line No. " << (multi_line ? start_line : yylineno) << ": Token <" << c_token;
		f_logs << "> Lexeme " << log_yytext << " found\n\n";
	}
	
	/* Prints error */
	void prnt_err(string err_msg, string c_yytext=yytext, bool multi_line=false) {
		f_logs << "Error at line " << (multi_line ? start_line : yylineno) << ": " << err_msg << " " << c_yytext << "\n\n"; 
		++tot_err;
	}
	
	/* take care of punctuations */
	void prnt_punct(string c_token) {
		prnt(c_token);
		if(st.insert(SymbolInfo(yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
	}
%}	

 /* Little thingies */

DIGIT 	[0-9]
SMALL [a-z]
CAPITAL [A-Z]
ALPHA ({SMALL}|{CAPITAL})
ALPHANUMERIC ({ALPHA}|{DIGIT})
BACKSLASH_CONST \\[nt\'"afrbv0]

EXP (E|e){DIGIT}+
EXP_ERR ((E|e)|(E|e){DIGIT}*\.({DIGIT}|\.)*)
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


 /* START: KEYWORDS */

if |
for |
do |
int |
float |
void |
switch |
default |
else |
while |
break |
char |
double |
return |
case |
continue 	{
		string c_token = str_uppper(yytext);
		prnt(c_token, yytext, yytext, true);
	}

 /* END: KEYWORDS */
 
 /* START: CONSTANTS; as per offline definitions */

{DIGIT}+ 	{
		string c_token = "CONST_INT";
		prnt(c_token);
		if(st.insert(SymbolInfo(yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
	}

 /* Floating numbers */
 
{DECIMAL}{EXP}? 	{
		string c_token = "CONST_FLOAT";
		prnt(c_token);
		if(st.insert(SymbolInfo(yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
	}
({DECIMAL}|{TOO_MANY_DECIMAL})?{EXP_ERR} {
		prnt_err("Ill formed number");
	}
{TOO_MANY_DECIMAL}{EXP}? {
		prnt_err("Too many decimal points");
	}
	
 /* Character thingies */
 
\'[^'"\\\n\t]\' 	{
		string c_token = "CONST_CHAR";
		string c_yytext = yytext;
		c_yytext = c_yytext.substr(1, 1);
		
		prnt(c_token, yytext, c_yytext);
		if(st.insert(SymbolInfo(c_yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
	}
\'{BACKSLASH_CONST}\' {
		string c_token = "CONST_CHAR";
		string c_yytext = yytext;
		char ch = get_backslash_const(c_yytext.substr(1, c_yytext.size()-2));
		c_yytext = "";
		c_yytext += ch;
		
		prnt(c_token, yytext, c_yytext);
		if(st.insert(SymbolInfo(c_yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
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

"+"|"-" 	{ prnt_punct("ADDOP"); }
"*"|"/"|"%" 	{ prnt_punct("MULOP"); }
"++"|"--" 	{ prnt_punct("INCOP"); }
"<"|"<="|">"|">="|"=="|"!=" 	{ prnt_punct("RELOP"); }
"=" 	{ prnt_punct("ASSIGNOP"); }
"&&"|"||" 	{ prnt_punct("LOGICOP"); }
"&"|"|"|"^"|"<<"|">>" 	{ prnt_punct("BITOP"); }
"!" 	{ prnt_punct("NOT"); }
"(" 	{ prnt_punct("LPAREN"); }
")" 	{ prnt_punct("RPAREN"); }
"{" 	{ prnt_punct("LCURL"); }
"}" 	{ prnt_punct("RCURL"); }
"[" 	{ prnt_punct("LTHIRD"); }
"]" 	{ prnt_punct("RTHIRD"); }
"," 	{ prnt_punct("COMMA"); }
";" 	{ prnt_punct("SEMICOLON"); }

 /* END: Operator and Punctuations */
 
 /* START: Idenitifiers */

({ALPHA}|"_")+({ALPHANUMERIC}|"_")* 	{
		string c_token = "ID";
		prnt(c_token);
		if(st.insert(SymbolInfo(yytext, c_token))) {
			st.print_current_scope(f_logs);
		}
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
		f_logs << "Line No. " << start_line << ": Token <" << "COMMENT";
		f_logs << "> Lexeme " << cur_yytext << " found\n\n";

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
		f_logs << "Line No. " << start_line << ": Token <" << "COMMENT";
		f_logs << "> Lexeme " << cur_yytext << " found\n\n";
		
		BEGIN(INITIAL);
		cur_yytext = "";
	}

 /* END: Single Line COMMENT definitions */

. 	{
		prnt_err("Unrecognized character");
	}

%%

int main(int argc, char **argv) {
	if(argc > 1) {
		if(!(yyin = fopen(argv[1], "r"))) {
			cout << "Error! Can't open file \"argv[1]\"\n";
			return 1;
		}
	}

	cur_str = "";
	yylineno = 1;
	yylex();
	
	f_token << "\n";
	f_logs << "Total Lines: " << yylineno-1 << "\n";
	f_logs << "Total Errors: " << tot_err << "\n";
	
	f_token.close();
	f_logs.close();

	return 0;
}
