typedef SymbolInfo* pointer_type;

ofstream f_log("log.txt");
ofstream f_err("error.txt");

SymbolTable symbol_table(7);
SymbolTable identifer_types(7);

void add_scope() { symbol_table.enter_scope(); identifer_types.enter_scope(); }
void remove_scope() { symbol_table.print_current_scope(f_log); symbol_table.exit_scope(); identifer_types.exit_scope(); }

ParameterList temp_parameter_list;
ParameterList temp_arg_list;
pointer_type parameter_identifers = nullptr;
string cur_type_specifier = "INT";

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
	f_err << "Error at line " << yylineno << ": " << msg << "\n\n";
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
	ob.is_func = true;

	bool flag = symbol_table.insert(ob);
	if(!flag) prnt_err("Multiple declaration of " + id->get_name());
	else {
		ob.set_type(type->get_type());
		identifer_types.insert(ob);
	}

	temp_parameter_list.clear();
	parameter_identifers = nullptr;
}

void add_new_func_definition(pointer_type type, pointer_type id) {
	SymbolInfo ob = *id;
	ob.parameters = temp_parameter_list;
	ob.is_func = true;
	ob.is_defined = true;

	bool flag = symbol_table.insert(ob);
	if(!flag) {
		pointer_type temp = symbol_table.search(ob.get_name());
		if(!(temp->is_func)) {
			prnt_err("Multiple declaration of " + ob.get_name());
		}
		else if(temp->is_defined) {
			prnt_err("Re-definition of " + ob.get_name());
		}
		else {
			pointer_type ret = identifer_types.search(ob.get_name());
			assert(ret != nullptr);	// this must hold!
			if(ret->get_type() != type->get_type() or !(ret->parameters == ob.parameters)) {
				prnt_err("Conflicting types for " + ob.get_name());
			}
			else {
				ret->is_defined = true;
				temp->is_defined = true;
			}
		}
	}
	else {
		ob.set_type(type->get_type());
		identifer_types.insert(ob);
	}

	temp_parameter_list.clear();
}

string combine_expressions(string _type1, string _type2) {
	if(_type1.back() == '*' or _type2.back() == '*') return "ERROR";
	if(_type1 == "ERROR" or _type2 == "ERROR") return "ERROR";
	if(_type1 == "FLOAT" or _type2 == "FLOAT") return "FLOAT";
	return "INT";
}