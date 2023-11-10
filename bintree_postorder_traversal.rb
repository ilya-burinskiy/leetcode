require 'debug'

# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end

  def child_nodes_enumerator
    Enumerator.new do |yielder|
      yielder.yield(self.left)
      yielder.yield(self.right)
    end
  end
end

def postorder_traversal(root)
  current_node = root
  current_enumerator = root.child_nodes_enumerator
  nodes_stack = [current_node]
  enumerators_stack = [current_enumerator]
  result = []

  while nodes_stack.length != 0 do
    begin
      next_node = current_enumerator.next
      if next_node != nil
        current_node = next_node
        current_enumerator = next_node.child_nodes_enumerator
        nodes_stack.push(current_node)
        enumerators_stack.push(current_enumerator)
      end
    rescue StopIteration
      result << current_node.val
      nodes_stack.pop
      enumerators_stack.pop
      current_node = nodes_stack.last
      current_enumerator = enumerators_stack.last
    end
  end

  result
end

def main
  root =
    TreeNode.new(
      1,
      nil,
      TreeNode.new(
        2,
        TreeNode.new(3, nil, nil),
        nil
      )
    )
  p postorder_traversal(root)
end

main
