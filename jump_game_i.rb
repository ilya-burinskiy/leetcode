# T(i) = 1 + min{ T(i + 1), T(i + 2), ..., T(i + nums[i]) }
# T(N - 1) = 0
def can_jump(nums)
  return true if nums.length == 1

  j = nums.length - 1
  (nums.length - 2).downto(0).each do |i|
    next if nums[0] == 0

    j = i if nums[i] >= j - i
  end

  return true if j == 0

  false
end
