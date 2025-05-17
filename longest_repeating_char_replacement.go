package main

func characterReplacement(s string, k int) int {
	maxCnt := 0
	charSet := make(map[byte]struct{})
	for i := 0; i < len(s); i++ {
		charSet[s[i]] = struct{}{}
	}
	for char := range charSet {
		var count, l int
		for r := 0; r < len(s); r++ {
			if s[r] == char {
				count++
			}

			for r - l + 1 - count > k {
				if s[l] == char {
					count--
				}
				l++
			}

			if r - l + 1 > maxCnt {
				maxCnt = r - l + 1
			}
		}
	}

	return maxCnt
}

func main() {
}
