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
	using namespace std;
	
	/**
	 *	takes a hexadecimal number in string s
	 *	prints the decimal number
	**/
	void prnt_dec(string s) {
		s = s.substr(2);
		
		int pos = s.find('p');
		if(pos == string::npos) pos = s.size();
		
		double res = 0;
		string hex_number = s.substr(0, pos);
		int dot_pos = hex_number.find('.');
		if(dot_pos == string::npos) dot_pos = hex_number.size();
		
		double mul = 1;
		for(int i=dot_pos-1, j=0; i>=0; --i, ++j) {
			double val = 0;
			if(isalpha(hex_number[i])) {
				val = toupper(hex_number[i])-'A' + 10;
			}
			else val = hex_number[i] - '0';
			val *= mul;
			res += val;
			mul *= 16.0;
		}
		mul = 1.0;
		for(int i=dot_pos+1, j=0; i<(int) hex_number.size(); ++i, ++j) {
			double val = 0;
			if(isalpha(hex_number[i])) {
				val = toupper(hex_number[i])-'A' + 10;
			}
			else val = hex_number[i] - '0';
			mul /= 16.0;
			val *= mul;
			res += val;
		}
		
		if(pos < (int) s.size()) {
			string pwr = s.substr(pos+1);
			int ip = stoi(pwr);
			long long pmul = (1LL << ip);
			res *= pmul;
		}
		
		if(res - (long long) res > 0) cout << scientific << fixed << setprecision(6) << res << "\n";
		else cout << (long long) res << "\n";
	}
%}	

DIGIT 	[0-9]
LETTER 	[a-fA-F]
HEXDIG 	({DIGIT}|{LETTER})

%%

[ \n\t] 	{ }
"0"("x"|"X"){HEXDIG}+("."{HEXDIG}+)?("p"{DIGIT}+)? 	{
	// cout << "Yayy: " << yytext << "\n";
	prnt_dec(yytext);
}
. 	{ }

%%

int main() {
	// cout << "Hello!\n";
	
	yylineno = 1;
	yylex();
	
	return 0;
}
