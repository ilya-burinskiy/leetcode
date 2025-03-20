# @param {Integer} target
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(target, nums)
  n = nums.length
  return 0 if nums.length == 0

  min_len =
    if nums[0] >= target
      1
    else
      Float::INFINITY
    end
  l = r = 0
  sum = nums[0]
  while r < n
    while l < r && sum > target
      sum -= nums[l]
      l += 1
      if sum >= target
        min_len = [min_len, r - l + 1].min
      end
    end

    r += 1
    if r < n
      sum += nums[r]
      if sum >= target
        min_len = [min_len, r - l + 1].min
      end
    end
  end

  # debugger
  if min_len != Float::INFINITY
    min_len
  else
    return 0 if sum < target

    n
  end
end

p min_sub_array_len(6, [10,2,3])
