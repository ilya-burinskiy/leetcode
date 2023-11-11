require 'debug'

# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# NOTE: copied from Wiki
def inorder_traversal(root)
  result = []
  return result if root.nil?

  stack = []
  current_node = root

  while stack.length != 0 || !current_node.nil? do
    if !current_node.nil?
      stack.push(current_node)
      current_node = current_node.left
    else
      current_node = stack.pop
      result << current_node.val
      current_node = current_node.right
    end
  end

  result
end
