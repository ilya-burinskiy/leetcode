package main

import (
  "fmt"
  "math"
)

func findMaxAverage(nums []int, k int) float64 {
	kFloat := float64(k)
	var sum int
	for i := 0; i < k; i++ {
		sum += nums[i]
	}
	maxAvgSum := float64(sum) / kFloat
	for i := 0; i < len(nums) - k; i++ {
		sum = sum - nums[i] + nums[i + k]
		maxAvgSum = math.Max(maxAvgSum, float64(sum) / kFloat)
	}

	return maxAvgSum
}

func main() {
	fmt.Printf("%.2f\n", findMaxAverage([]int{0, 4, 0, 3, 2}, 1))
}
