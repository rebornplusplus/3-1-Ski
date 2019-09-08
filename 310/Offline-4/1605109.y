%{
	#include <bits/stdc++.h>
	#include "SymbolTable.h"
	using namespace std;

	int yyparse();
	int yylex();
	void yyerror(char *msg);
	
	extern int yylineno;
	extern FILE* yyin;
	extern void optimize(string filename);
	
	ofstream f_err("error.txt");
	ofstream f_out("code.asm");
	
	SymbolTable st;
	
	static int labels = 0;
	static int tempos = 0;
	vector<string> variables;
	vector< pair<string, int> > arrays;
	vector< pair<string, SymbolInfo*> > to_be_inserted;
	// vector< vector<string> > temp_variables(1);
	string cur_ret = "retmain";
	string cur_fun = "";
	
	string newTemp(string id="", bool array = false, int arraysize = 0) {
		string ret = "";
		ret += id + "_" + to_string(tempos);
		++tempos;
		
		if(id == "") {
			ret = "T_" + ret;
			variables.push_back(ret);
		}
		else if(array) {
			ret = "A_" + ret;
			arrays.push_back(make_pair(ret, arraysize));
		}
		else {
			ret = "V_" + ret;
			variables.push_back(ret);
		}
		
		// temp_variables.back().push_back(ret);
		if(cur_fun != "") {
			SymbolInfo *fun_ptr = st.search(cur_fun);
			fun_ptr->variables.push_back(ret);
		}
			
		return ret;
	}
	
	string newLabel() {
		string ret = "LABEL_" + to_string(labels);
		++labels;
		return ret;
	}
%}

%union {
	SymbolInfo* info;
}

%token <info> PRINTLN
%token <info> IF FOR DO INT FLOAT VOID SWITCH DEFAULT WHILE BREAK CHAR DOUBLE RETURN CASE CONTINUE
%nonassoc LOWER_THAN_ELSE
%nonassoc <info> ELSE
%token <info> CONST_INT CONST_FLOAT CONST_CHAR
%token <info> ADDOP MULOP INCOP DECOP RELOP ASSIGNOP LOGICOP BITOP
%token <info> NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON
%token <info> ID

%type <info> start program unit func_declaration func_definition parameter_list
%type <info> compound_statement var_declaration type_specifier declaration_list
%type <info> statements statement expression_statement variable
%type <info> expression logic_expression rel_expression simple_expression term
%type <info> unary_expression factor argument_list arguments

%%

start:
	program {

		$$ = $1;
		
		f_out << ".MODEL SMALL\n";
		f_out << ".STACK 100H\n\n";
		f_out << ".DATA\n";
		for(auto &qq : arrays) f_out << qq.first << " DW " << qq.second << " DUP(?)\n";
		for(auto &qq : variables) f_out << qq << " DW ?\n";
		f_out << "\n.CODE\n";
		string println_def = 
"PRINTLN PROC\n\
	PUSH AX\n\
	PUSH BX\n\
	PUSH CX\n\
	PUSH DX\n\
	OR AX, AX\n\
	JGE ENDIF1\n\
	PUSH AX\n\
	MOV DL, '-'\n\
	MOV AH, 2\n\
	INT 21H\n\
	POP AX\n\
	NEG AX\n\
	ENDIF1:\n\
	XOR CX, CX\n\
	MOV BX, 10D\n\
	REPEAT1:\n\
	XOR DX, DX\n\
	DIV BX\n\
	PUSH DX\n\
	INC CX\n\
	OR AX, AX\n\
	JNE REPEAT1\n\
	MOV AH, 2\n\
	PRINTLOOP:\n\
	POP DX\n\
	OR DL, 30H\n\
	INT 21H\n\
	LOOP PRINTLOOP\n\
	MOV AH,2\n\
	MOV DX,0AH\n\
	INT 21H\n\
	MOV DX,0DH\n\
	INT 21H\n\
	POP DX\n\
	POP CX\n\
	POP BX\n\
	POP AX\n\
	RET\n\
PRINTLN ENDP\n";
		f_out << println_def << "\n";
		f_out << $$->code;
		f_out << "END MAIN\n";

	}
	;

program:
	program unit {

		$$ = $1;
		$$->code += $2->code;
		delete $2;

	}
	| unit {

		$$ = $1;

	}
	;
	
unit:
	var_declaration {

		$$ = $1;

	}
	| func_declaration {

		$$ = $1;

	}
	| func_definition {

		$$ = $1;

	}
	;
     
func_declaration:
	type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {
		// Oh, I want you, I want you, I want you
		// On a chair with a dead magazine
		// In the cave at the tip of the lilly
		// In some hallway where love's never been
		// On a bed where the moon has been sweating
		// In a cry filled with footsteps and sand
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {
		// Aey, aey, aey, aey
	}
	;

// function thingies to be done later
func_definition:
	type_specifier ID LPAREN parameter_list RPAREN {
			cur_ret = newTemp(string("ret") + $2->symbol);
			cur_fun = $2->symbol;
			st.insert(cur_fun, new SymbolInfo());
			SymbolInfo* fun_ptr = st.search(cur_fun);
			fun_ptr->symbol = cur_ret;
			fun_ptr->function_id = $2->symbol;
			fun_ptr->variables.clear();
			for(auto &qq : $4->parameters) fun_ptr->variables.push_back(qq);
			fun_ptr->parameters = $4->parameters;
			// cerr << "Cometh here -- inside\n";
		} compound_statement {
		
		$$ = st.search(cur_fun);
		// $$->symbol = cur_ret;	// this would be return value
		// $$->function_id = $2->symbol;
		// $$->variables.clear();
		// for(auto &qq : $4->parameters) $$->variables.push_back(qq);
		// for(auto &qq : $7->variables) $$->variables.push_back(qq);
		// $$->parameters = $4->parameters;
		
		$$->code = $$->function_id + " PROC\n";
		if($$->function_id == "main") {
			$$->code += "MOV AX, @DATA\n";
			$$->code += "MOV DS, AX\n\n";
		}
		$$->code += $7->code;
		// if($$->function_id	== "main") {
		// 	$$->code += "\nMOV AH, 4CH\n";
		//	$$->code += "INT 21H\n";
		// }
		$$->code += $$->function_id + " ENDP\n\n";
		
		// st.insert($2->symbol, $$);
		$$ = new SymbolInfo($$);
		cur_fun = "";
		
		// cerr << "FOR FUNCTION " << $$->function_id << ":\n";
		// cerr << "function local vars: \n";
		// for(auto qq : $$->variables) cerr << qq << " --|\n";
		// cerr << "function parameters: \n";
		// for(auto qq : $$->parameters) cerr << qq << " --|\n";
		
	}
	| type_specifier ID LPAREN RPAREN {
			cur_ret = newTemp(string("ret") + $2->symbol);
			cur_fun = $2->symbol;
			st.insert(cur_fun, new SymbolInfo());
			SymbolInfo* fun_ptr = st.search(cur_fun);
			fun_ptr->symbol = cur_ret;
			fun_ptr->function_id = $2->symbol;
			fun_ptr->variables.clear();
			fun_ptr->parameters.clear();
			// cerr << "Cometh here -- inside\n";
		} compound_statement {
		
		$$ = st.search(cur_fun);
		// $$->symbol = cur_ret;	// this would be return value
		// $$->function_id = $2->symbol;
		// $$->variables.clear();
		// for(auto &qq : $6->variables) $$->variables.push_back(qq);
		// $$->parameters.clear();
		
		$$->code = $$->function_id + " PROC\n";
		if($$->function_id == "main") {
			$$->code += "MOV AX, @DATA\n";
			$$->code += "MOV DS, AX\n\n";
		}
		$$->code += $6->code;
		// if($$->function_id	== "main") {
		//	$$->code += "\nMOV AH, 4CH\n";
		//	$$->code += "INT 21H\n";
		// }
		$$->code += $$->function_id + " ENDP\n\n";
		
		// st.insert($2->symbol, $$);
		$$ = new SymbolInfo($$);
		cur_fun = "";
		
	}
	;

// function thingies to be done later
parameter_list:
	parameter_list COMMA type_specifier ID {
		
		string id = $4->symbol;
		$4->symbol = newTemp(id);
		// st.insert(id, $4);
		to_be_inserted.push_back(make_pair(id, $4));
		
		$$ = $1;
		$$->parameters.push_back($4->symbol);
		
	}
	| parameter_list COMMA type_specifier {
		
		$$ = $1;
		
	}
	| type_specifier ID {
		
		string id = $2->symbol;
		$2->symbol = newTemp(id);
		// st.insert(id, $2);
		to_be_inserted.clear();
		to_be_inserted.push_back(make_pair(id, $2));
		
		$$ = new SymbolInfo();
		$$->parameters.push_back($2->symbol);
		
	}
	| type_specifier {
		
		$$ = $1;
		
	}
	;


compound_statement:
	LCURL { st.add_scope(); st.insert(to_be_inserted); /* temp_variables.emplace_back(); */ } statements RCURL {

		$$ = $3;
		// $$->variables = temp_variables.back();
		
		// cerr << "Compound tvars:\n";
		// for(auto qq : $$->variables) cerr << qq << " -- \n";
		
		st.remove_scope();
		// temp_variables.pop_back();
		
	}
	| LCURL RCURL {
		
		$$ = $1;
		
	}
	;
 		    
var_declaration:
	type_specifier declaration_list SEMICOLON {
		
		$$ = $1;
		
	}
	;
 		 
type_specifier:
	INT {
	
		$$ = $1;
		
	}
	| FLOAT {
		
		$$ = $1;
		
	}
	| VOID {
		
		$$ = $1;
		
	}
	;
 		
declaration_list:
	declaration_list COMMA ID {
		
		string id = $3->symbol;
		$3->symbol = newTemp(id);
		st.insert(id, $3);
		
		$$ = new SymbolInfo();
		
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
		
		string id = $3->symbol;
		$3->symbol = newTemp(id, true, stoi($5->symbol));
		$3->type = "array";
		st.insert(id, $3);
		
		$$ = new SymbolInfo();
		
	}
	| ID {
		
		string id = $1->symbol;
		$1->symbol = newTemp(id);
		st.insert(id, $1);
		
		$$ = new SymbolInfo();
		
	}
	| ID LTHIRD CONST_INT RTHIRD {
		
		string id = $1->symbol;
		$1->symbol = newTemp(id, true, stoi($3->symbol));
		$1->type = "array";
		st.insert(id, $1);
		
		$$ = new SymbolInfo();
		
	}
	;
 		  
statements:
	statement {
		
		$$ = $1;
		
	}
	| statements statement {
		
		$$ = $1;
		$$->code += $2->code;
		
		delete $2;
		
	}
	;
	   
statement:
	var_declaration {
		
		$$ = $1;
		
	}
	| expression_statement {
		
		$$ = $1;
		
	}
	| compound_statement {
		
		$$ = $1;
		
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		
		$$ = new SymbolInfo();
		
		string startLabel = newLabel();
		string endLabel = newLabel();
		
		$$->code = $3->code;
		$$->code += startLabel + ":\n";
		$$->code += $4->code;
		$$->code += "MOV AX, " + $4->symbol + "\n";
		$$->code += "CMP AX, 0\n";
		$$->code += "JE " + endLabel + "\n";
		$$->code += $7->code;
		$$->code += $5->code;
		$$->code += "JMP " + startLabel + "\n";
		$$->code += endLabel + ":\n";
		
		$$->symbol = "for";
		
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		
		$$ = $3;
		
		string label = newLabel();
		$$->code += "MOV AX, " + $3->symbol + "\n";
		$$->code += "CMP AX, 0\n";
		$$->code += "JE " + label + "\n";
		$$->code += $5->code;
		$$->code += label + ":\n";
		
		$$->symbol = "if";
		
		delete $5;
		
	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		
		$$ = $3;
		
		string endLabel = newLabel();
		string elseLabel = newLabel();
		
		$$->code += "MOV AX, " + $3->symbol + "\n";
		$$->code += "CMP AX, 0\n";
		$$->code += "JE " + elseLabel + "\n";
		$$->code += $5->code;
		$$->code += "JMP " + endLabel + "\n";
		$$->code += elseLabel + ":\n";
		$$->code += $7->code;
		$$->code += endLabel + ":\n";
		
		$$->symbol = "if_else";
		
		delete $5;
		delete $7;
		
	}
	| WHILE LPAREN expression RPAREN statement {
		
		$$ = new SymbolInfo();
		
		string startLabel = newLabel();
		string endLabel = newLabel();
		
		$$->code = startLabel + ":\n";
		$$->code += $3->code;
		$$->code += "MOV AX, " + $3->symbol + "\n";
		$$->code += "CMP AX, 0\n";
		$$->code += "JE " + endLabel + "\n";
		$$->code += $5->code;
		$$->code += "JMP " + startLabel + "\n";
		$$->code += endLabel + ":\n";
		
		$$->symbol = "while";
		
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		
		$$ = new SymbolInfo();
		$$->symbol = newTemp();
		
		SymbolInfo *ptr = st.search($3->symbol);
		$$->code = "MOV AX, " + ptr->symbol + "\n";
		$$->code += "CALL PRINTLN\n";
		
	}
	| RETURN expression SEMICOLON {
		
		$$ = new SymbolInfo();
		
		$$->code = $2->code;
		if(cur_fun == "main") {
			$$->code += "MOV AH, 4CH\n";
			$$->code += "INT 21H\n";
		}
		else {
			$$->code += "MOV AX, " + $2->symbol + "\n";
			$$->code += "MOV " + cur_ret + ", AX\n";
			$$->code += "RET\n";
		}
		
	}
	;
	  
expression_statement:
	SEMICOLON {
		
		$$ = $1;
		
	}
	| expression SEMICOLON {
		
		$$ = $1;
		
	}
	;
	  
variable:
	ID {
		
		SymbolInfo *ptr = st.search($1->symbol);
		assert(ptr != nullptr);
		$$ = new SymbolInfo(ptr);
		
	}
	| ID LTHIRD expression RTHIRD {
		
		SymbolInfo *ptr = st.search($1->symbol);
		assert(ptr != nullptr);
		$$ = new SymbolInfo(ptr);
		// cerr << "Symbol wtf: " << ptr->symbol << "\n";
		
		$$->type = "array";
		$$->code += $3->code;
		$$->code += "MOV BX, " + $3->symbol + "\n";
		$$->code += "ADD BX, BX\n";
		
		// cerr << "variable codes:\n";
		// cerr << $3->code << "--------\n";
		// cerr << $$->code << "\n";
		// cerr << "-------end var\n";
		
		delete $3;
	}
	;
	 
expression:
	logic_expression {
		
		$$ = $1;
		
	}
	| variable ASSIGNOP logic_expression {
		
		$$ = $1;
		$$->code = $3->code + $1->code;
		$$->code += "MOV AX, " + $3->symbol + "\n";
		
		if($$->type == "array") {
			$$->code += "MOV " + $$->symbol + "[BX], AX\n";
		}
		else {
			$$->code += "MOV " + $$->symbol + ", AX\n";
		}
		
		delete $3;
	}
	;

logic_expression:
	rel_expression {
		
		$$ = $1;
				
	}
	| rel_expression LOGICOP rel_expression {
		
		$$ = new SymbolInfo();
		$$->symbol = newTemp();
		
		string set1Label = newLabel();
		string set0Label = newLabel();
		string endLabel = newLabel();
		
		$$->code = $1->code + $3->code;
		if($2->symbol == "&&") {
			$$->code += "MOV AX, " + $1->symbol + "\n";
			$$->code += "ADD AX, " + $3->symbol	+ "\n";
			$$->code += "CMP AX, 2\n";
			$$->code += "JNE " + set0Label + "\n";
		}
		else {
			$$->code += "MOV AX, " + $1->symbol + "\n";
			$$->code += "ADD AX, " + $3->symbol + "\n";
			$$->code += "CMP AX, 1\n";
			$$->code += "JNE " + set0Label + "\n";
		}
		$$->code += set1Label + ":\n";
		$$->code += "MOV " + $$->symbol + ", 1\n";
		$$->code += "JMP " + endLabel + "\n";
		$$->code += set0Label + ":\n";
		$$->code += "MOV " + $$->symbol + ", 0\n";
		$$->code += endLabel + ":\n";
		
		delete $1;
		delete $3;
		
	}
	;
			
rel_expression:
	simple_expression {
		
		$$ = $1;
		
	}
	| simple_expression RELOP simple_expression {
		
		$$ = new SymbolInfo();
		$$->symbol = newTemp();
		
		string set1Label = newLabel();
		string set0Label = newLabel();
		string endLabel = newLabel();
		
		$$->code = $1->code + $3->code;
		$$->code += "MOV AX, " + $1->symbol + "\n";
		$$->code += "CMP AX, " + $3->symbol + "\n";
		
		if($2->symbol == "<") {
			$$->code += "JL " + set1Label + "\n";
		}
		else if($2->symbol == "<=") {
			$$->code += "JLE " + set1Label + "\n";
		}
		else if($2->symbol == ">") {
			$$->code += "JG " + set1Label + "\n";
		}
		else if($2->symbol == ">=") {
			$$->code += "JGE " + set1Label + "\n";
		}
		else if($2->symbol == "==") {
			$$->code += "JE " + set1Label + "\n";
		}
		else {
			$$->code += "JNE " + set1Label + "\n";
		}
		
		$$->code += "MOV " + $$->symbol + ", 0\n";
		$$->code += "JMP " + endLabel + "\n";
		$$->code += set1Label + ":\n";
		$$->code += "MOV " + $$->symbol + ", 1\n";
		$$->code += endLabel + ":\n";
		
		delete $1;
		delete $3;
		
	}
	;
			
simple_expression:
	term {
		
		$$ = $1;
		
	}
	| simple_expression ADDOP term {
		
		$$ = new SymbolInfo($1);
		$$->symbol = newTemp();
		$$->code += $3->code;
		$$->code += "MOV AX, " + $1->symbol + "\n";
		
		if($2->symbol == "+") {
			$$->code += "ADD AX, " + $3->symbol + "\n";
		}
		else {
			$$->code += "SUB AX, " + $3->symbol + "\n";
		}
		
		$$->code += "MOV " + $$->symbol + ", AX\n";
		delete $3;
		
	}
	;
					
term:
	unary_expression {
		
		$$ = $1;
		
	}
	| term MULOP unary_expression {
		
		$$ = new SymbolInfo($1);
		$$->symbol = newTemp();
		
		$$->code += $3->code;
		$$->code += "MOV AX, " + $1->symbol + "\n";
		$$->code += "MOV BX, " + $3->symbol + "\n";
		
		if($2->symbol == "*") {
			$$->code += "MUL BX\n";
			$$->code += "MOV " + $$->symbol + ", AX\n";
		}
		else if($2->symbol == "/") {
			$$->code += "MOV DX, 0\n";
			$$->code += "DIV BX\n";
			$$->code += "MOV " + $$->symbol + ", AX\n";
		}
		else {
			$$->code += "MOV DX, 0\n";
			$$->code += "DIV BX\n";
			$$->code += "MOV " + $$->symbol + ", DX\n";
		}
		
		delete $3;
		
	}
	;

unary_expression:
	ADDOP unary_expression {
		
		$$ = new SymbolInfo($2);
		$$->symbol = newTemp();
		if($1->symbol == "-") {
			$$->code += "MOV AX, 0\n";
			$$->code += "SUB AX, " + $2->symbol + "\n";
			$$->code += "MOV " + $$->symbol + ", AX\n";
		}
		
	}
	| NOT unary_expression {
		
		$$ = new SymbolInfo($2);
		$$->symbol = newTemp();
		$$->code += "MOV AX, " + $2->symbol + "\n";
		$$->code += "NOT AX\n";
		$$->code += "MOV " + $$->symbol + ", AX\n";
		
	}
	| factor {
		
		$$ = $1;
		
	}
	;
	
factor:
	variable {
		
		$$ = new SymbolInfo($1);
		
		if($$->type == "array") {
			$$->symbol = newTemp();
			$$->code += "MOV AX, " + $1->symbol + "[BX]\n";
			$$->code += "MOV " + $$->symbol + ", AX\n";
		}
		
	}
	// function thingies to be done later
	| ID LPAREN argument_list RPAREN {
		
		$$ = new SymbolInfo();
		$$->symbol = newTemp();
		
		SymbolInfo* fun_ptr = st.search($1->symbol);
		auto tvars = fun_ptr->variables;
		auto tpara = fun_ptr->parameters;
		
		// cerr << "function local vars: \n";
		// for(auto qq : tvars) cerr << qq << "\n";
		// cerr << "function parameters: \n";
		// for(auto qq : tpara) cerr << qq << "\n";
		// cerr << "argument_list:\n";
		// for(auto qq : $3->parameters) cerr << qq << "\n";
		
		$$->code += $3->code;
		$$->code += "PUSHA\n";
		for(string qq : tvars) $$->code += "PUSH " + qq + "\n";
		for(int i=0; i<(int) $3->parameters.size(); i++) {
			$$->code += "MOV AX, " + $3->parameters[i] + "\n";
			$$->code += "MOV " + tpara[i] + ", AX\n";
		}
		
		$$->code += "CALL " + fun_ptr->function_id + "\n";
		
		reverse(tvars.begin(), tvars.end());
		for(string qq : tvars) $$->code += "POP " + qq + "\n";
		$$->code += "POPA\n";
		
		$$->code += "MOV AX, " + fun_ptr->symbol + "\n";
		$$->code += "MOV " + $$->symbol + ", AX\n";
		
	}
	| LPAREN expression RPAREN {
		
		$$ = $2;
		
	}
	| CONST_INT {
		
		$$ = $1;
		
	}
	| CONST_FLOAT {
		
		$$ = $1;
		
	}
	| variable INCOP {
		
		$$ = new SymbolInfo($1);
		$$->symbol = newTemp();
		
		if($1->type == "array") {
			$$->code += "MOV AX, " + $1->symbol + "[BX]\n";
		}
		else {
			$$->code += "MOV AX, " + $1->symbol + "\n";
		}
		$$->code += "INC AX\n";
		$$->code += "MOV " + $1->symbol + ", AX\n";
		
	}
	| variable DECOP {
		
		$$ = new SymbolInfo($1);
		$$->symbol = newTemp();
		
		if($1->type == "array") {
			$$->code += "MOV AX, " + $1->symbol + "[BX]\n";
		}
		else {
			$$->code += "MOV AX, " + $1->symbol + "\n";
		}
		$$->code += "DEC AX\n";
		$$->code += "MOV " + $1->symbol + ", AX\n";
		
	}
	;

// function thingies to be done later
argument_list:
	arguments {
		
		$$ = $1;
		
	}
	| {
		
		$$ = new SymbolInfo();
		
	}
	;

// function thingies to be done later	
arguments:
	arguments COMMA logic_expression {
		
		$$ = $1;
		$$->code += $3->code;
		$$->parameters.push_back($3->symbol);
		
	}
	| logic_expression {
		
		$$ = $1;
		$$->parameters.clear();
		$$->parameters.push_back($1->symbol);
		
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
	
	f_out.close();
	f_err.close();
	
	optimize("code.asm");

	return 0;
}

void yyerror(char *s) {
	cerr << "Error: " << s << "\n";
}
