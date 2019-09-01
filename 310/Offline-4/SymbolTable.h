#include <iostream>
#include <vector>
#include <string>

using namespace std;

struct SymbolInfo {
	string type;	// type of the thingy
	string symbol;	// assembly variable name
	string code;	// assembly codes
	vector<string> parameters;	// parameters if function/argument_list
	vector<string> variables;	// variables created in a compound_statement
	string function_id;	// proc name
	
	SymbolInfo(string symbol="", string type="") :
		symbol(symbol), type(type), code(""), parameters() { }
	
	SymbolInfo(const SymbolInfo *ptr) :
		symbol(ptr->symbol), type(ptr->type), code(ptr->code), parameters(ptr->parameters) { }
	
	void print(ostream &out=cout) {
		out << "type = " << type << "\n" 
			<< "symbol = " << symbol << "\n"
			<< "code = " << code << "\n"
			<< "parameters: ";
		for(auto para : parameters) out << para << " ";
		out << "\n";
	}
};

struct SymbolTable {
	typedef map< string, SymbolInfo* > scope;
	vector< scope > scopes;
	
	SymbolTable() {
		scopes.resize(1);
	}
	
	void insert(string key, SymbolInfo *ptr) {
		// cerr << "To insert " << key << ": " << ptr->symbol << "\n";
		assert(!scopes.empty());
		auto &tail = scopes.back();
		tail[key] = ptr;
	}
	
	void insert(vector< pair<string, SymbolInfo*> > &v) {
		for(auto &qq : v) {
			insert(qq.first, qq.second);
		}
		v.clear();
	}
	
	SymbolInfo* search(string key) {
		for(int i=(int) scopes.size()-1; i>=0; --i) {
			auto &cur = scopes[i];
			// cerr << "To search: " << key << ": " << i << "\n";
			auto it = cur.find(key);
			if(it != cur.end()) {
				// cerr << "Found " << key << "\n";
				return it->second;
			}
		}
		// cerr << "Not found " << key << "\n";
		return nullptr;
	}
	
	void add_scope() {
		scopes.push_back(scope());
	}
	
	void remove_scope() {
		assert(!scopes.empty());
		scopes.pop_back();
	}
	
	int current_scope() {
		return (int) scopes.size() - 1;
	}
};
