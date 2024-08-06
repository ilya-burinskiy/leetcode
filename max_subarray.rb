=begin
T(l, r) = max {
  T(l, r - 1),
  T(l + 1, r),
  T(l + 1, r - 1),
  sum(A[l:r])
}
=end

def max_subarray_recursive(nums)
  max_subarray_helper(nums, nums.reduce(&:+))
end

def max_subarray_helper(nums, sum)
  return -Float::INFINITY if nums.length <= 0

  [
    max_subarray_helper(nums[...nums.length - 1], sum - nums[-1]),
    max_subarray_helper(nums[1..], sum - nums[0]),
    max_subarray_helper(nums[1...nums.length - 1], sum - nums[0] - nums[-1]),
    sum
  ].max
end

# Memory limit exceeded
def max_subarray_memo(nums)
  table = Array.new(nums.length) { Array.new(nums.length, -Float::INFINITY) }
  max = -Float::INFINITY
  (0...nums.length).each do |i|
    table[i][i] = nums[i]
    max = max_(max, table[i][i])
  end

  (1...nums.length).each do |k|
    (0...nums.length - k).each do |i|
      table[i][i + k] = table[i][i + k - 1] + nums[i + k]
      max = max_(max, table[i][i + k])
    end
  end

  p table
  max
end

def max_(a, b)
  a > b ? a : b
end

# Kadane's algorithm
def max_subarray(nums)
  best_sum = -Float::INFINITY
  current_sum = 0
  nums.each do |num|
    current_sum = max_(num, current_sum + num)
    best_sum = max(best_sum, current_sum)
  end

  best_sum
end
