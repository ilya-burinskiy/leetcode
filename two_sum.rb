def two_sum(nums, target)
  h = {}
  nums.each_with_index do |num, i|
    z = target - num
    if h.key?(z)
      return h[z][1], i
    end
    h[num] = [z, i]
  end
end

def main
  l = [3,2,4]
  target = 6
  puts two_sum(l, target).to_s
end

main
