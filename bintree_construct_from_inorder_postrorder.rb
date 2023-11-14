require 'debug'

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# @param {Integer[]} inorder
# @param {Integer[]} postorder 
# @return {TreeNode}
def build_tree(inorder, postorder)
  return nil if inorder.empty?

  root_val = postorder.last
  tree_size = inorder.count
  ltree_size = inorder.index(root_val)
  rtree_size = tree_size - ltree_size - 1

  TreeNode.new(
    root_val,
    build_tree(inorder[...ltree_size], postorder[...ltree_size]),
    build_tree(inorder[(ltree_size + 1)..], postorder[ltree_size...-1])
  )
end
