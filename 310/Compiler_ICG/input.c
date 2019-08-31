// #include <stdio.h>

int main()
{
	int a, b, n, i, cnt, max;
	int tmp_a, tmp_b;
	a = 1;
	b = 10;

	tmp_a = a;
	tmp_b = b;
	if(a>b) {
		int temp;
		temp = a;
		a = b;
		b = a;
	}

	max = 0;
	while(a<=b) {
		n=a;
		a++;
		cnt=0;

		while(n != 1) {
			if(n % 2 != 0) {
				n = 3*n + 1;
				n = n / 2;
				cnt = cnt + 2;
			}
			else {
				n = n / 2;
				cnt++;
			}
		}
		cnt++;

		if(max < cnt) {
			max = cnt;
		}
	}

	// printf("%d %d %d\n", tmp_a, tmp_b, max);

	return 0;
}

