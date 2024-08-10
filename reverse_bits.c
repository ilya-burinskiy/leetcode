#include <stdio.h>
#include <stdint.h>

/*
0x7F = [0111 1111]

n = 7F; k = 4; mask = F; left_bits = 7; right_bits = F;
	n = 7; k = 2; mask = 3; left_bits = 1; right_bits = 3;
		n = 1; k = 1; mask = 1; left_bits = 0; right_bits = 1;
		n = 3; k = 1; mask = 1; left_bits = 1; right_bits = 1;

	n = F; k = 2; mask = 3; left_bits = 3; right_bits = 3;
		n = 3; k = 1; mask = 1; left_bits = 1; right_bits = 1;
		n = 3; k = 1; mask = 1; left_bits = 1; right_bits = 1;
res = FE
*/

uint32_t reverse_bits(uint32_t n, uint32_t);

uint32_t reverse_bits(uint32_t n, uint32_t k) {
	if (k == 0) {
		return n;
	}

	uint32_t mask = (1 << k) - 1;
	uint32_t left_bits = (n >> k) & mask;
	uint32_t right_bits = n & mask;
	uint32_t reversed_left_bits = reverse_bits(left_bits, k / 2);
	uint32_t reversed_right_bits = reverse_bits(right_bits, k / 2);

	return (reversed_right_bits << k) + reversed_left_bits;
}
