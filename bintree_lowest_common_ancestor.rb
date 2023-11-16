class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def lowest_common_ancestor(root, p_node, q_node)
  p_path = find_path(root, p_node)
  q_path = find_path(root, q_node)

  i = 0
  n = [p_path.length, q_path.length].min
  while i < n && p_path[i].val == q_path[i].val do
    i += 1
  end

  p_path[i - 1]
end

def find_path(root, target_node)
  path = []
  is_node_found = false
  postorder_traversal(
    root,
    on_node_entrance: lambda do |node|
      path << node unless is_node_found
      is_node_found = true if node.val == target_node.val
    end,
    on_node_exit: lambda { |node| path.pop unless is_node_found }
  )

  path
end

def postorder_traversal(node, on_node_entrance: nil, on_node_exit: nil)
  return if node.nil?

  on_node_entrance.call(node) unless on_node_entrance.nil?
  postorder_traversal(node.left, on_node_entrance:, on_node_exit:)
  postorder_traversal(node.right, on_node_entrance:, on_node_exit:)
  on_node_exit.call(node) unless on_node_exit.nil?
end
