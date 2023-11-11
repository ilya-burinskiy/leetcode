# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def is_symmetric(root)
  return true if root.nil?

  eq(root.left, flip_binary_tree(root.right))
end

def flip_binary_tree(root)
  return root if root.nil?

  left_flipped = flip_binary_tree(root.left)
  right_flipped = flip_binary_tree(root.right)
  TreeNode.new(root.val, right_flipped, left_flipped)  
end

def eq(root1, root2)
  return false if !root1.nil? && root2.nil? || !root2.nil? && root1.nil? 
  return true if root1.nil? && root2.nil?

  root1.val == root2.val &&
        eq(root1.left, root2.left) &&
        eq(root1.right, root2.right)
end
