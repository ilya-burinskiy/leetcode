#include<stdint.h>
#include<stdio.h>

int hamming_weight(int n);
int hamming_weight_helper(int n, uint8_t k);

int main(int argc, char** argv) {
	printf("res = %d\n", hamming_weight(45));
}


int hamming_weight(int n) {
	uint8_t int_size = sizeof(int);
	return hamming_weight_helper(n, (8 * int_size) / 2);
}

int hamming_weight_helper(int n, uint8_t k) {
	if (k == 0) {
		return n;
	}
	
	unsigned int mask = (1 << k) - 1;
	unsigned int left_bits = (n >> k) & mask;
	unsigned int right_bits = n & mask;
	int left_set_bits_cnt = hamming_weight_helper(left_bits, k / 2);
	int right_set_bits_cnt = hamming_weight_helper(right_bits, k / 2);

	return left_set_bits_cnt + right_set_bits_cnt;
}
