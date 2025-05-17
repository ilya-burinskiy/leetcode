package main

<<<<<<< HEAD
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
=======
import "fmt"

/*
maxCount = 1
h = {'A': 1}
k = 2
A B A B B
i     j

maxChar = 'A'
h = {'A': 1, 'B': 1}
k = 1
A B A B B
i j

maxChar = 'A'
h = {'A': 2, 'B': 1}
k = 1
A B A B B
i   j

maxChar = 'A'
h = {'A': 2, 'B': 2}
k = 0
A B A B B
i     j

maxChar = 'A'
h = {'A': 2, 'B': 2}
k = 0

maxChar = 'A'
h = {'A': 1, 'B': 3}
k = 0
h[s[i]]--
i++
j++
h[s[j]]++
if h[maxChar] < h[s[j]] {
	maxChar = s[j]
}

A B A B B
i     j
*/

func characterReplacement(s string, k int) int {
	// A B A B B
	// i     j
	// tmpK := k
	i := 0
	j := 0
	h := make(map[rune]int, 26)
	runes := []rune(s)
	maxCount := 1
	h[runes[0]]++

	for k > 0 && j < len(runes) {
		j++
		if runes[j] != runes[0] {
			k--
			h[runes[j]]++
		}
		maxCount++
	}

	fmt.Printf("window: %v;\nh: %v\nmaxCount: %v", string(runes[i:j+1]), h, maxCount)
	// for _d := 0; _d < len(runes)-j+i; _d++ {
	// 	h[runes[i]]--
	// 	i++
	// 	j++
	// 	if j < len(runes) {
	// 		h[runes[j]]++
	// 		if h[maxChar] < h[runes[j]] {
	// 			maxChar = runes[j]
	// 		}
	// 	}
	// }

	return maxCount
}

func main() {
	fmt.Println(characterReplacement("ABABB", 2))
>>>>>>> a04b5c6 (wip: longest repeating character replacement)
}
