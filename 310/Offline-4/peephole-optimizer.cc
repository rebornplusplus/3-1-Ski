#include <bits/stdc++.h>
using namespace std;

vector<string> split(string &line) {
	stringstream ss(line);
	vector<string> inter;
	string s;
	while(ss >> s) {
		inter.push_back(s);
	}
	
	vector<string> ret;
	for(auto &qq : inter) {
		stringstream ss(qq);
		while(getline(ss, s, ',')) {
			if(!s.empty()) ret.push_back(s);
		}
	}
	return ret;
}

string toupper(string s) {
	string ret = s;
	for(auto &c : ret) c = toupper(c);
	return ret;
}

void optimize(string filename) {
	ifstream in(filename);
	vector<string> toflush;
	
	string prevline;
	getline(in, prevline);
	toflush.push_back(prevline);
	
	string line;
	while(getline(in, line)) {
		auto v_pre = split(prevline);
		auto v_cur = split(line);
		for(auto &s : v_pre) s = toupper(s);
		for(auto &s : v_cur) s = toupper(s);
		
		if(!line.empty() and !prevline.empty() and v_pre.front() == "MOV" and v_cur.front() == "MOV") {
			assert(v_pre.size() == v_cur.size());
			if(v_pre == v_cur) continue;
			if(v_pre[1] == v_cur[2] and v_pre[2] == v_cur[1]) continue;
		}
		
		toflush.push_back(line);
		if(!line.empty()) prevline = line;
	}
	
	in.close();
	
	ofstream out(filename);
	for(auto &s : toflush) out << s << "\n";
	out.close();
}
