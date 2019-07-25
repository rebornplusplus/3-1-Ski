%{
	#include <bits/stdc++.h>
	#include "SymbolTable.h"
	using namespace std;

	int yyparse();
	int yylex();
	void yyerror(char *msg);
	
	extern int yylineno;
	extern FILE* yyin;
	
	typedef SymbolInfo* pointer_type;

	SymbolTable symbol_table(7);
	SymbolTable identifer_types(7);

	void add_scope() { symbol_table.enter_scope(); identifer_types.enter_scope(); }
	void remove_scope() { symbol_table.exit_scope(); identifer_types.exit_scope(); }
	
	ParameterList temp_parameter_list;
	pointer_type parameter_identifers = nullptr;
	string cur_type_specifier = "INT";

	ofstream f_log("log.txt");
	ofstream f_err("error.txt");

	void prnt(string rule, SymbolInfo* ptr) {
		static int space_prefix = 0;

		f_log << "At line no: " << yylineno << " \t" << rule << "\n";
		f_log << "\n";
		bool is_new_line = true;
		while(ptr) {
			if(ptr->get_type() == "RCURL") space_prefix -= 2;
			
			if(is_new_line) f_log << string(space_prefix, ' ');
			f_log << ptr->get_name() << ' ';
			
			if(ptr->get_type() == "LCURL") space_prefix += 2;

			if(ptr->get_type() == "SEMICOLON" or ptr->get_type() == "LCURL" or ptr->get_type() == "RCURL") {
				f_log << "\n";
				is_new_line = true;
			}
			else is_new_line = false;
			
			ptr = ptr->next;
		}
		f_log << "\n\n";
	}

	extern int tot_err;
	void prnt_err(string msg) {
		f_err << "Error at line " << yylineno << ": " << msg << "\n";
		++tot_err;
	}

	void append(pointer_type a, pointer_type b) {
		pointer_type cur = a, prev = nullptr;
		while(cur) {
			prev = cur;
			cur = cur->next;
		}
		prev->next = b;
	}

	void add_parameter_identifiers() {
		pointer_type cur = parameter_identifers, prev = nullptr;
		while(cur) {
			if(cur->get_type() == "ID") {
				f_log << "INSERT IDENTIFIER: " << prev->get_type() << " " << cur->get_name() << "\n";
				assert(prev != nullptr);
				bool flag = symbol_table.insert(*cur);
				if(!flag) prnt_err("Multiple declaration of " + cur->get_name());
				else identifer_types.insert(SymbolInfo(cur->get_name(), prev->get_type()));
			}
			prev = cur;
			cur = cur->next;
		}
		parameter_identifers = nullptr;
	}

	void add_new_func_declaration(pointer_type type, pointer_type id) {
		SymbolInfo ob = *id;
		ob.parameters = temp_parameter_list;

		bool flag = symbol_table.insert(ob);
		if(!flag) prnt_err("Multiple declaration of " + id->get_name());
		else {
			ob.set_type(type->get_type());
			identifer_types.insert(ob);
		}
	}

	void add_new_func_definition(pointer_type type, pointer_type id) {
		SymbolInfo ob = *id;
		ob.parameters = temp_parameter_list;

		bool flag = symbol_table.insert(ob);
		if(!flag) {
			pointer_type ret = identifer_types.search(ob.get_name());
			assert(ret != nullptr);	// this must hold!
			if(ret->get_type() != type->get_type() or !(ret->parameters == ob.parameters)) {
				prnt_err("Multiple declaration of " + ob.get_name());
			}
		}
		else {
			ob.set_type(type->get_type());
			identifer_types.insert(ob);
		}

		temp_parameter_list.clear();
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
	LCURL { f_log << "compound_statement begins!\n"; add_scope(); add_parameter_identifiers(); } statements RCURL {
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
		else identifer_types.insert(SymbolInfo($3->get_name(), cur_type_specifier));

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
		else identifer_types.insert(SymbolInfo($1->get_name(), cur_type_specifier));

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
		if(ret == nullptr) prnt_err("Identifier " + $3->get_name() + " declaration not found");

		append($1, $2);
		append($2, $3);
		append($3, $4);
		append($4, $5);
		append($5, nullptr);

		$$ = $1;

		prnt("statement: PRINTLN LPAREN ID RPAREN SEMICOLON", $$);
	}
	| RETURN expression SEMICOLON {
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
		if(ret == nullptr) prnt_err("Identifier " + $1->get_name() + " declaration not found");

		append($1, nullptr);

		$$ = $1;

		prnt("variable: ID", $$);
	}
	| ID LTHIRD expression RTHIRD {
		pointer_type ret = symbol_table.search($1->get_name());
		if(ret == nullptr) prnt_err("Identifier " + $1->get_name() + " declaration not found");

		// array index here

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
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

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
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

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
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

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
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("term: term MULOP unary_expression", $$);
	}
	;

unary_expression:
	ADDOP unary_expression {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

		prnt("unary_expression: ADDOP unary_expression", $$);
	}
	| NOT unary_expression {
		append($1, $2);
		append($2, nullptr);

		$$ = $1;

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
		if(ret == nullptr) prnt_err("Identifier " + $1->get_name() + " declaration not found");

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

		prnt("factor: LPAREN expression RPAREN", $$);
	}
	| CONST_INT {
		append($1, nullptr);

		$$ = $1;

		prnt("factor: CONST_INT", $$);
	}
	| CONST_FLOAT {
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
		append($1, $2);
		append($2, $3);
		append($3, nullptr);

		$$ = $1;

		prnt("arguments: arguments COMMA logic_expression", $$);
	}
	| logic_expression {
		append($1, nullptr);

		$$ = $1;

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
}

void yyerror(char *s) {
	cerr << "Error: " << s << "\n";
}