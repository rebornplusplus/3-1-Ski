/**
 * Bison Parser for C subset
 * Offline 3
 * 
 * Rafid Bin Mostofa
 * Jul 26 2019 1726
**/

%{
	#include <bits/stdc++.h>
	#include "SymbolTable.h"
	using namespace std;

	int yyparse();
	int yylex();
	void yyerror(char *msg);
	
	extern int yylineno;
	extern FILE* yyin;
	
	#include "AdditionalFunctions.h"
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
		append($1, nullptr);

		$$ = $1;

		prnt("start: program", $$);
	}
	;

program:
	program unit {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("program: program unit", $$);
	}
	| unit {
		append($1, nullptr);

		$$ = $1;

		prnt("program: unit", $$);
	}
	;
	
unit:
	var_declaration {
		append($1, nullptr);

		$$ = $1;

		prnt("unit: var_declaration", $$);
	}
	| func_declaration {
		append($1, nullptr);

		$$ = $1;

		prnt("unit: func_declaration", $$);
	}
	| func_definition {
		append($1, nullptr);

		$$ = $1;

		prnt("unit: func_definition", $$);
	}
	;
     
func_declaration:
	type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {
		add_new_func_declaration($1, $2);

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, $6);
		append($6, nullptr);

		$$ = $1;

		prnt("func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", $$);

		// function needed to be inserted in symbol table
		// also the parameters
	}
	| type_specifier ID LPAREN RPAREN SEMICOLON {
		add_new_func_declaration($1, $2);

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, nullptr);

		$$ = $1;

		prnt("func_declaration: type_specifier ID LPAREN RPAREN SEMICOLON", $$);

		// function needed to be inserted in symbol table
		// also the parameters
	}
	;
		 
func_definition:
	type_specifier ID LPAREN parameter_list RPAREN { add_new_func_definition($1, $2); } compound_statement {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, $7);
		append($7, nullptr);

		$$ = $1;

		prnt("func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$);
	}
	| type_specifier ID LPAREN RPAREN { add_new_func_definition($1, $2); } compound_statement {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $6);
		append($6, nullptr);

		$$ = $1;

		prnt("func_definition: type_specifier ID LPAREN RPAREN compound_statement", $$);
	}
	;

parameter_list:
	parameter_list COMMA type_specifier ID {
		parameter_identifers = $1;
		temp_parameter_list.add_parameter($3->get_type());

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, nullptr);

		$$ = $1;

		prnt("parameter_list: parameter_list COMMA type_specifier ID", $$);
	}
	| parameter_list COMMA type_specifier {
		parameter_identifers = $1;
		temp_parameter_list.add_parameter($3->get_type());

		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("parameter_list: parameter_list COMMA type_specifier", $$);
	}
	| type_specifier ID {
		parameter_identifers = $1;
		temp_parameter_list.clear();
		temp_parameter_list.add_parameter($1->get_type());

		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("parameter_list: type_specifier ID", $$);
	}
	| type_specifier {
		parameter_identifers = $1;
		temp_parameter_list.clear();
		temp_parameter_list.add_parameter($1->get_type());

		append($1, nullptr);

		$$ = $1;

		prnt("parameter_list: type_specifier", $$);
	}
	;


compound_statement:
	LCURL { add_scope(); add_parameter_identifiers(); } statements RCURL {
		remove_scope();

		append($1, $3);
		append($3, $4);
		append($4, nullptr);
		
		$$ = $1;

		prnt("compound_statement: LCURL statements RCURL", $$);
	}
	| LCURL RCURL {
		append($1, $2);
		append($2, nullptr);
		
		$$ = $1;

		prnt("compound_statement: LCURL RCURL", $$);
	}
	;
 		    
var_declaration:
	type_specifier declaration_list SEMICOLON {
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("var_declaration: type_specifier declaration_list SEMICOLON", $$);
	}
	;
 		 
type_specifier:
	INT {
		cur_type_specifier = "INT";

		append($1, nullptr);

		$$ = $1;
		
		prnt("type_specifier: INT", $$);
	}
	| FLOAT {
		cur_type_specifier = "FLOAT";

		append($1, nullptr);

		$$ = $1;

		prnt("type_specifier: FLOAT", $$);
	}
	| VOID {
		cur_type_specifier = "VOID";

		append($1, nullptr);

		$$ = $1;

		prnt("type_specifier: VOID", $$);
	}
	;
 		
declaration_list:
	declaration_list COMMA ID {
		bool flag = symbol_table.insert(*($3));
		if(!flag) prnt_err("Multiple declaration of " + $3->get_name());
		else identifer_types.insert(SymbolInfo($3->get_name(), cur_type_specifier));
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);
		
		$$ = $1;

		prnt("declaration_list: declaration_list COMMA ID", $$);
	}
	| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD {
		bool flag = symbol_table.insert(*($3));
		if(!flag) prnt_err("Multiple declaration of " + $3->get_name());
		else identifer_types.insert(SymbolInfo($3->get_name(), cur_type_specifier + "*"));

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, $6);
		append($6, nullptr);

		$$ = $1;

		prnt("declaration_list: declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", $$);
	}
	| ID {
		bool flag = symbol_table.insert(*($1));
		if(!flag) prnt_err("Multiple declaration of " + $1->get_name());
		else identifer_types.insert(SymbolInfo($1->get_name(), cur_type_specifier));

		append($1, nullptr);
		
		$$ = $1;

		prnt("declaration_list: ID", $$);
	}
	| ID LTHIRD CONST_INT RTHIRD {
		bool flag = symbol_table.insert(*($1));
		if(!flag) prnt_err("Multiple declaration of " + $1->get_name());
		else identifer_types.insert(SymbolInfo($1->get_name(), cur_type_specifier+"*"));

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, nullptr);

		$$ = $1;

		prnt("declaration_list: ID LTHIRD CONST_INT RTHIRD", $$);
	}
	;
 		  
statements:
	statement {
		append($1, nullptr);

		$$ = $1;

		prnt("statements: statement", $$);
	}
	| statements statement {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("statements: statements statement", $$);
	}
	;
	   
statement:
	var_declaration {
		append($1, nullptr);

		$$ = $1;

		prnt("statement: var_declaration", $$);
	}
	| expression_statement {
		append($1, nullptr);

		$$ = $1;

		prnt("statement: expression_statement", $$);
	}
	| compound_statement {
		append($1, nullptr);

		$$ = $1;

		prnt("statement: compound_statement", $$);
	}
	| FOR LPAREN expression_statement expression_statement expression RPAREN statement {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, $6);
		append($6, $7);
		append($7, nullptr);

		$$ = $1;

		prnt("statement: FOR LPAREN expression_statement expression_statement expression RPAREN statement", $$);
	}
	| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, nullptr);

		$$ = $1;

		prnt("statement: IF LPAREN expression RPAREN statement", $$);
	}
	| IF LPAREN expression RPAREN statement ELSE statement {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, $6);
		append($6, $7);
		append($7, nullptr);

		$$ = $1;

		prnt("statement: IF LPAREN expression RPAREN statement ELSE statement", $$);
	}
	| WHILE LPAREN expression RPAREN statement {
		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, nullptr);

		$$ = $1;

		prnt("statement: WHILE LPAREN expression RPAREN statement", $$);
	}
	| PRINTLN LPAREN ID RPAREN SEMICOLON {
		pointer_type ret = symbol_table.search($3->get_name());
		if(ret == nullptr) prnt_err("Identifier " + $3->get_name() + " not declared");

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, nullptr);

		$$ = $1;

		prnt("statement: PRINTLN LPAREN ID RPAREN SEMICOLON", $$);
	}
	| RETURN expression SEMICOLON {
		if($2->expression_type == "VOID")
			prnt_err("void types found in expression");
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("statement: RETURN expression SEMICOLON", $$);
	}
	;
	  
expression_statement:
	SEMICOLON {
		append($1, nullptr);

		$$ = $1;

		prnt("expression_statement: SEMICOLON", $$);
	}
	| expression SEMICOLON {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("expression_statement: expression SEMICOLON", $$);
	}
	;
	  
variable:
	ID {
		pointer_type ret = symbol_table.search($1->get_name());
		if(ret == nullptr) prnt_err("Identifier " + $1->get_name() + " not declared");
		else if(ret->is_func) prnt_err("Identifier " + $1->get_name() + " is a function. Missing arguments");
		else {
			pointer_type ptr = identifer_types.search($1->get_name());
			assert(ptr);
			$1->expression_type = ptr->get_type();
		}

		append($1, nullptr);

		$$ = $1;

		prnt("variable: ID", $$);
	}
	| ID LTHIRD expression RTHIRD {
		pointer_type ret = symbol_table.search($1->get_name());
		if(ret == nullptr) prnt_err("Identifier " + $1->get_name() + " not declared");
		else if(ret->is_func) prnt_err("Identifier " + $1->get_name() + " is a function. Missing arguments");
		else {
			pointer_type ptr = identifer_types.search($1->get_name());
			assert(ptr);
			$1->expression_type = ptr->get_type();
			if($1->expression_type.back() != '*') prnt_err("Idenitifer " + $1->get_name() + "[] not declared");
			else $1->expression_type.pop_back();	// for array*
		}

		// array index here
		if($3->expression_type != "INT") prnt_err("Non-integer array index");

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, nullptr);

		$$ = $1;

		prnt("variable: ID LTHIRD expression RTHIRD", $$);
	}
	;
	 
expression:
	logic_expression {
		append($1, nullptr);

		$$ = $1;

		prnt("expression: logic_expression", $$);
	}
	| variable ASSIGNOP logic_expression {
		if($1->expression_type == "VOID" or $3->expression_type == "VOID") 
			prnt_err("void types found in assignment");
		else if($1->expression_type != "ERROR" and $3->expression_type != "ERROR" and $1->expression_type != $3->expression_type)
			prnt_err("Type conversion");
		// check variable type here

		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("expression: variable ASSIGNOP logic_expression", $$);
	}
	;
			
logic_expression:
	rel_expression {
		append($1, nullptr);

		$$ = $1;

		prnt("logic_expression: rel_expression", $$);
	}
	| rel_expression LOGICOP rel_expression {
		if($1->expression_type == "VOID" or $3->expression_type == "VOID") 
			prnt_err("void types found in expression");
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;
		$$->expression_type = "INT";

		prnt("logic_expression: rel_expression LOGICOP rel_expression", $$);
	}
	;
			
rel_expression:
	simple_expression {
		append($1, nullptr);

		$$ = $1;

		prnt("rel_expression: simple_expression", $$);
	}
	| simple_expression RELOP simple_expression {
		if($1->expression_type == "VOID" or $3->expression_type == "VOID") 
			prnt_err("void types found in expression");
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;
		$$->expression_type = "INT";

		prnt("rel_expression: simple_expression", $$);
	}
	;
				
simple_expression:
	term {
		append($1, nullptr);

		$$ = $1;

		prnt("simple_expression: term", $$);
	}
	| simple_expression ADDOP term {
		if($1->expression_type == "VOID" or $3->expression_type == "VOID") 
			prnt_err("void types found in expression");
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;
		$$->expression_type = combine_expressions($1->expression_type, $3->expression_type);

		prnt("simple_expression: simple_expression ADDOP term", $$);
	}
	;
					
term:
	unary_expression {
		append($1, nullptr);

		$$ = $1;

		prnt("term: unary_expression", $$);
	}
	| term MULOP unary_expression {
		if($1->expression_type == "VOID" or $3->expression_type == "VOID") 
			prnt_err("void types found in expression");
		else if($2->get_name() == "%" and ($1->expression_type != "INT" or $3->expression_type != "INT")) {
			prnt_err("Non-integer operand on modulus operator");
			$1->expression_type = "ERROR";
		}

		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;
		$$->expression_type = combine_expressions($1->expression_type, $3->expression_type);

		prnt("term: term MULOP unary_expression", $$);
	}
	;

unary_expression:
	ADDOP unary_expression {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;
		$$->expression_type = $2->expression_type;

		prnt("unary_expression: ADDOP unary_expression", $$);
	}
	| NOT unary_expression {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;
		$$->expression_type = $2->expression_type;

		prnt("unary_expression: NOT unary_expression", $$);
	}
	| factor {
		append($1, nullptr);

		$$ = $1;

		prnt("unary_expression: factor", $$);
	}
	;
	
factor:
	variable {
		append($1, nullptr);

		$$ = $1;

		prnt("factor: variable", $$);
	}
	| ID LPAREN argument_list RPAREN {
		pointer_type ret = symbol_table.search($1->get_name());
		if(ret == nullptr) prnt_err("Function " + $1->get_name() + " not declared");
		else {
			pointer_type ptr = identifer_types.search($1->get_name());
			assert(ptr);
			$1->expression_type = ptr->get_type();

			if(ptr->is_func == false) prnt_err("Function " + $1->get_name() + " not declared");
			else {
				temp_arg_list = ($3 == nullptr) ? ParameterList() : $3->parameters;
				if(!(ptr->parameters == temp_arg_list)) prnt_err("Function arguments don't match with declared parameter types");
			}
		}

		// function type checking here

		append($1, $2);
		append($2, $3);
		if($3 == nullptr) append($2, $4);
		else append($3, $4);
		append($4, nullptr);

		$$ = $1;

		prnt("factor: ID LPAREN argument_list RPAREN", $$);
	}
	| LPAREN expression RPAREN {
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;
		$$->expression_type = $2->expression_type;

		prnt("factor: LPAREN expression RPAREN", $$);
	}
	| CONST_INT {
		$1->expression_type = "INT";

		append($1, nullptr);

		$$ = $1;

		prnt("factor: CONST_INT", $$);
	}
	| CONST_FLOAT {
		$1->expression_type = "FLOAT";

		append($1, nullptr);

		$$ = $1;

		prnt("factor: CONST_FLOAT", $$);
	}
	| variable INCOP {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("factor: variable INCOP", $$);
	}
	| variable DECOP {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("factor: variable INCOP", $$);
	}
	;
	
argument_list:
	arguments {
		append($1, nullptr);

		$$ = $1;

		prnt("argument_list: arguments", $$);
	}
	| {
		$$ = nullptr;

		prnt("argument_list: ", $$);
	}
	;
	
arguments:
	arguments COMMA logic_expression {
		$1->parameters.add_parameter($3->expression_type);
		
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("arguments: arguments COMMA logic_expression", $$);
	}
	| logic_expression {
		append($1, nullptr);

		$$ = $1;
		
		$$->parameters.clear();
		$$->parameters.add_parameter($1->expression_type);

		prnt("arguments: arguments COMMA logic_expression", $$);
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

	remove_scope();
	f_err << "Total errors: " << tot_err << "\n";

	f_log.close();
	f_err.close();

	return 0;
}

void yyerror(char *s) {
	cerr << "Error: " << s << "\n";
}
