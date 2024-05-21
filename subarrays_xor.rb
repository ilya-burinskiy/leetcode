def subsets(set_)
  return [[]] if set_.empty?

  rest_subsets = subsets(set_[1..])
  rest_subsets + rest_subsets.map { |s| s_dup = s.dup; s_dup << set_[0]; s_dup }
end

def subset_xor_sum(nums)
  subsets(nums)
    .map { |subset| subset.reduce(0) { |sum, num| sum ^= num } }
    .reduce(:+)
end
