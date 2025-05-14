package main

import (
	"fmt"
)

func strStr(haystack string, needle string) int {
	// haystack and needle consist of only lowercase English characters
	if len(needle) > len(haystack) {
		return -1
	}

	for d := 0; d < len(haystack) - len(needle) + 1; d++ {
		var i int
		for i < len(needle) && haystack[d + i] == needle[i] {
			i++
		}
		if i == len(needle) {
			return d
		}
	}
	
	return -1
}

func main() {
	fmt.Println(strStr("mississippi", "issip"))
}
