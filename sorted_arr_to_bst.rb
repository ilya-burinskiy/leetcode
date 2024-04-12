class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def sorted_array_to_bst(nums)
  if nums.length == 1
    return TreeNode.new(nums[0])
  elsif nums.length == 0
    return nil
  end

  m = nums.length / 2
  left = sorted_array_to_bst(nums[...m])
  right = sorted_array_to_bst(nums[(m + 1)..])

  TreeNode.new(nums[m], left, right)
end
