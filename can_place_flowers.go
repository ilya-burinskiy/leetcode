package main

import "fmt"

/*
0 1 0
i

0 1 0

	i

0 1 0 0

	i

0 1 0 0

	i
*/
func canPlaceFlowers(flowerbed []int, n int) bool {
	m := len(flowerbed)
	i := 0
	for i < m && n > 0 {
		if flowerbed[i] == 1 {
			i += 2
			continue
		}

		if (i-1 >= 0 && flowerbed[i-1] == 0 || i-1 < 0) &&
			(i+1 < m && flowerbed[i+1] == 0 || i+1 >= m) {
			i += 2
			n--
		} else {
			i++
		}
	}

	if n == 0 {
		return true
	}

	return false
}

func main() {
	fmt.Println(canPlaceFlowers([]int{1, 0, 0, 0, 1}, 2))
}
