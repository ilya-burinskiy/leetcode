=begin
[A -- B -- C -- D -- E -- F -- G]

* can jump from A to D
* can jump from B to E
* can jump from C to F
=end

# T(i) = 1 + min{ T(i + 1), T(i + 2), ..., T(i + nums[i]) }
# T(N - 1) = 0
def jump(nums)
  return 0 if nums.length == 1

  table = Array.new(nums.length, Float::INFINITY)
  table[-1] = 0
  (nums.length - 2).downto(0).each do |i|
    (1..nums[i]).each do |j|
      break if i + j >= nums.length

      table[i] = [table[i], table[i + j]].min
    end
    table[i] += 1
  end
  table[0]
end

if __FILE__ == $0
  nums = [2, 1]
  p jump(nums)
end
