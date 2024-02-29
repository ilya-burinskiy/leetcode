def permute(nums)
  perms = partial_permutations(nums.length, nums.length)
  h = {}
  nums.each_with_index { |num, i| h[i] = num }
  perms.map { |perm| perm.map { |num| h[num] } }
end

def partial_permutations(n, k)
  if k > n
    []
  elsif k == 1
    (0...n).map { |x| [x] }
  else
    combine(partial_permutations(n - 1, k - 1), n - 1, k - 1) + partial_permutations(n - 1, k)
  end
end

def combine(perms, n, k)
  perms.map do |perm|
    (0..k).map do |pos|
      perm_dup = perm.dup
      perm_dup.insert(pos, n)
      perm_dup
    end
  end.flatten(1)
end
