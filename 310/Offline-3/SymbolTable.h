/**
 * Compiler Offline 1
 * CSE 310, 2018-19
 *
 * Rafid Bin Mostofa ( 1605109 )
 * Apr 06 2019 0217
**/

#include <bits/stdc++.h>
#include "ParameterList.h"
using namespace std;

class SymbolInfo {
    string name, type;

    public:

    SymbolInfo* next;
	ParameterList *parameters;

    SymbolInfo(string _name="", string _type="") : name(_name), type(_type), next(nullptr) { }

    SymbolInfo(const SymbolInfo &p) {
        name = p.name;
        type = p.type;
        next = nullptr;
		parameters = nullptr;
    }

    string get_name() const { return name; }
    string get_type() const { return type; }

    bool operator == (const SymbolInfo &p) const {
        return name == p.name;
    }

    void print(ofstream &out) const {
        out << "< " << name << " : " << type << " >";
    }
};

class ScopeTable {
    #define PRIME_1 857LL
    #define PRIME_2 627LL

    typedef SymbolInfo* ptr;

    int len;
    ptr *root;

    int hash(const string &s) {
        long long ret = 0, mul = 1;
        for(int i=0; i<(int) s.size(); ++i) {
            ret = (ret + (long long) s[i] * mul) % len;
            mul = (mul * PRIME_1 * 26) % len;
        }
        return ret;
    }

    public:

    ScopeTable *prev;
    int id;

    ScopeTable(int n = 10, int _id = 0) {
        id = _id;
        len = n;
        root = new ptr[len];
        prev = nullptr;
        for(int i=0; i<len; ++i) root[i] = nullptr;
    }

    ptr search(const string &name) {
        int pos = hash(name), col = 0;

        ptr it = root[pos];
        while(it != nullptr) {
            if(it->get_name() == name) {
                // cout << " Found in ScopeTable # " << id << " at position " << pos << ", " << col << "\n\n";
                return it;
            }
            it = it->next;
            ++col;
        }
        return nullptr;
    }

    bool insert(const SymbolInfo &ob) {
        string name = ob.get_name();
        if(search(name)) return false;

        ptr p = new SymbolInfo(ob);
        int pos = hash(name), col = 0;

        if(root[pos]) {
            ptr cur = root[pos];
            while(cur->next) {
                cur = cur->next;
                ++col;
            }
            cur->next = p;
            ++col;
        }
        else {
            root[pos] = p;
        }

        // cout << " Inserted in ScopeTable # " << id << " at position " << pos << ", " << col << "\n\n";

        return true;
    }

    bool erase(const string &name) {
        int pos = hash(name);
        if(root[pos] == nullptr) return false;

        int col = 0;
        ptr cur = root[pos], prev = nullptr;
        while(cur) {
            if(cur->get_name() == name) {
                if(prev) {
                    prev->next = cur->next;
                }
                else {
                    root[pos] = cur->next;
                }
                delete cur;

                // cout << " Deleted entry at " << pos << ", " << col << " from current ScopeTable\n\n";
                return true;
            }
            prev = cur;
            cur = cur->next;
            ++col;
        }
        return false;
    }

    void print(ofstream &out) {
        out << " ScopeTable # " << id << "\n";
        for(int i=0; i<len; ++i) {
            if(!root[i]) continue;
            out << " " << i << " --> ";
            ptr cur = root[i];
            while(cur) {
                cur->print(out);
                if(cur->next) out << " ";
                cur = cur->next;
            }
            out << "\n";
        }
        out << "\n";
    }

    ~ScopeTable() {
        if(root) delete[] root;
        prev = nullptr;
    }
};

class SymbolTable {
    typedef ScopeTable* ptr;
    ptr tail;
    int buckets;
	int count_scopes;

    public:

    SymbolTable(int bucket_size=10) {
		count_scopes = 0;
        buckets = bucket_size;
        tail = new ScopeTable(buckets);
    }

    void enter_scope() {
        ptr cur = new ScopeTable(buckets, count_scopes++);
        cur->prev = tail;
        tail = cur;
        // cout << " New ScopeTable with id " << cur->id << " created\n\n";
    }

    void exit_scope() {
        if(tail == nullptr) return ;

        // cout << " ScopeTable with id " << tail->id << " removed\n\n";
        ptr temp = tail;
        tail = tail->prev;
        delete temp;
		--count_scopes;
    }

    bool insert(SymbolInfo ob) {
        return tail->insert(ob);
    }

    bool erase(string name) {
        return tail->erase(name);
    }

    SymbolInfo* search(string name) {
        ptr cur = tail;
        while(cur) {
            SymbolInfo *ret = cur->search(name);
            if(ret) return ret;
            cur = cur->prev;
        }
        return nullptr;
    }

    void print_current_scope(ofstream &out) {
        if(tail == nullptr) return ;
        tail->print(out);
    }

    void print_all_scopes(ofstream &out) {
        ptr cur = tail;
        while(cur) {
            cur->print(out);
            cur = cur->prev;
        }
    }

    ~SymbolTable() {
        if(tail) delete tail;
    }
};

/*
int main() {

    // freopen("in.txt", "r", stdin);
    // freopen("mine.txt", "w", stdout);

    int n;
    cin >> n;
    SymbolTable st(n);

    string op, name, type;
    while(cin >> op) {
        if(op == "I") {
            cin >> name >> type;
            cout << op << " " << name << " " << type << "\n\n";
            bool ok = st.insert(SymbolInfo(name, type));
            if(!ok) cout << " ( " << name << ", " << type << " ) already exist in current ScopeTable\n\n";
        }

        else if(op == "L") {
            cin >> name;
            cout << op << " " << name << "\n\n";
            bool ok = st.search(name);
            if(!ok) cout << " Not found\n\n";
        }

        else if(op == "D") {
            cin >> name;
            cout << op << " " << name << "\n\n";
            bool ok = st.erase(name);
            if(!ok) cout << " " << name << " Not Found\n\n";
        }

        else if(op == "P") {
            string which;
            cin >> which;
            cout << op << " " << which << "\n\n";
            if(which == "C") st.print_current_scope();
            else st.print_all_scopes();
        }

        else if(op == "S") {
            cout << op << "\n\n";
            st.enter_scope();
        }

        else if(op == "E") {
            cout << op << "\n\n";
            st.exit_scope();
        }
    }

    return 0;
}
*/
