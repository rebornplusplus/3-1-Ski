#include <vector>
#include <string>
using namespace std;

class ParameterList {
	vector<string> parameter_types;

	public:

	ParameterList() { parameter_types.clear(); }

	void add_parameter(string parameter_type) {
		parameter_types.push_back(parameter_type);
	}

	vector<string> get_types() {
		return parameter_types;
	}

	bool operator == (const ParameterList &p) const {
		return parameter_types == p.parameter_types;
	}

	void clear() {
		parameter_types.clear();
	}
};