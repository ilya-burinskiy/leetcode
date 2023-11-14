class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def build_tree(preorder, inorder)
  return nil if preorder.empty?

  root_val = preorder.first
  tree_size = preorder.count
  ltree_size = inorder.index(root_val)

  TreeNode.new(
    root_val,
    build_tree(preorder[1..ltree_size], inorder[...ltree_size]),
    build_tree(preorder[(ltree_size + 1)..], inorder[(ltree_size + 1)..])
  )
end
