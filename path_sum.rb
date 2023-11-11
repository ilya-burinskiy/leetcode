# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# @param {TreeNode} root
# @param {Integer} target_sum
# @return {Boolean}
def has_path_sum(root, target_sum)
  sum = 0 
  result = false
  on_node_entrance = lambda do |node|
    sum += node.val
    result = true if node.left.nil? && node.right.nil? && sum == target_sum
  end
  on_node_exit = -> (node) { sum -= node.val }
  postorder_traversal(root, on_node_entrance:, on_node_exit:)

  result
end

def postorder_traversal(node, on_node_entrance: nil, on_node_exit: nil)
  return if node.nil?

  on_node_entrance.call(node) unless on_node_entrance.nil?
  postorder_traversal(node.left, on_node_entrance:, on_node_exit:)
  postorder_traversal(node.right, on_node_entrance:, on_node_exit:)
  on_node_exit.call(node) unless on_node_exit.nil?
end
