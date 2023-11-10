def sorted_squares(nums)
  i = 0
  j = nums.length - 1
  l = nums.length - 1
  result = nums.dup

  while i <= j do
    if nums[i] * nums[i] >= nums[j] * nums[j]
      result[l] = nums[i] * nums[i]
      i = i + 1
    else
      result[l] = nums[j] * nums[j]
      j = j - 1
    end
    l = l - 1
  end

  result
end
