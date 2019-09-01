int square(int x) {
	int ret;
	ret = x * x;
	return ret;
}

int sum(int a, int b) {
	int ret;
	ret = a + b;
	return ret;
}

int fibo(int n) {
	if(n == 0) {
		return 0;
	}
	
	if(n == 1) {
		return 1;
	}
	
	int ret;
	ret = fibo(n-1) + fibo(n-2);
	return ret;
}

int factorial(int n) {
	if(n == 0) {
		return 1;
	}
	
	int ret;
	ret = factorial(n-1);
	ret = ret * n;
	ret = ret;
	
	return ret;
}

int main() {
	int a, b;
	// a = 10;
	// b = 3;
	
	int sumval;
	// sumval = sum(a, b);
	 
	int sqval;
	// sqval = square(b);
	
	int total;
	// total = sumval * sqval;
	
	int n;
	n = 5;
	int fn;
	fn = fibo(n);
	println(fn);
	
	int fact;
	fact = factorial(n);
	println(fact);
	
	int series_sum;
	series_sum = 0;
	int i;
	for(i=0; i<n; i++) {
		series_sum = series_sum + i;
	}
	println(series_sum);
	
	int p, q, r;
	p = 10;
	q = 5;
	r = 9;
	
	if(p > q) {
		if(p > r) {
			println(p);
			return 0;
		}
		else {
			println(r);
			return 0;
		}
	}
	else {
		if(q > r) {
			println(q);
			return 0;
		}
		else {
			println(r);
			return 0;
		}
	}
	
	return 0;
}
