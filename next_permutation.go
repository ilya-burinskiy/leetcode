package main

import (
	"fmt"
	"math"
	"sort"
)

func nextPermutation(nums []int) {
	n := len(nums)
	iMax := math.Inf(-1)
	for i := 0; i < n; i++ {
		if i + 1 < n && nums[i] < nums[i + 1] && iMax < float64(i) {
			iMax = float64(i)
		}
	}

	if math.IsInf(iMax, -1) {
		sort.Slice(nums, func(i, j int) bool {
			return nums[i] < nums[j]
		})
		printResult(nums)
		return
	}

	iMaxInt := int(iMax)
	kMax := math.Inf(-1)
	for k := iMaxInt + 1; k < n; k++ {
		if nums[iMaxInt] < nums[k] && kMax < float64(k) {
			kMax = float64(k)
		}
	}
	if math.IsInf(kMax, -1) || int(kMax) == n {
		panic("kMax is undefined")
	}
	nums[iMaxInt], nums[int(kMax)] = nums[int(kMax)], nums[iMaxInt]
	reverse(nums[iMaxInt + 1:n])
	printResult(nums)
}

func reverse(nums []int) {
	n := len(nums)
	m := n / 2
	for i := 0; i < m; i++ {
		nums[i], nums[n - i - 1] = nums[n - i - 1], nums[i]
	}
}

func printResult(nums []int) {
	for i, num := range nums {
		if i == 0 {
			fmt.Printf("[%d,", num)
		} else if i == len(nums) - 1 {
			fmt.Printf("%d]\n", num)
		} else {
			fmt.Printf("%d,", num)
		}
	}
}

func main() {
	nextPermutation([]int{2, 3, 1})
}
