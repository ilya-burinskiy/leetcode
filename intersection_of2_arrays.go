package main

func intersection(nums1 []int, nums2 []int) []int {
	n := len(nums1)
	m := len(nums2)
	if m == 0 || n == 0 {
		return []int{}
	}

	seen := make([]bool, 1001)
	res := make([]int, 0, 1000)
	for i := 0; i < n; i++ {
		if !seen[nums1[i]] && find(nums2, nums1[i]) >= 0 {
			res = append(res, nums1[i])
			seen[nums1[i]] = true
		}
	}
	return res
}

func find(nums []int, target int) int {
	n := len(nums)
	for i := 0; i < n; i++ {
		if nums[i] == target {
			return i
		}
	}
	return -1
}

func main() {
	intersection([]int{1, 2, 2, 1}, []int{2, 2})
}
