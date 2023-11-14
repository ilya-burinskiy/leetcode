class Node
  attr_accessor :val, :left, :right, :next

  def initialize(val)
    @val = val
    @left, @right, @next = nil, nil, nil
  end
end

def connect(root)
  levelorder_enumerator(root).each do |level|
    level.each_with_index { |node, i| node.next = level[i + 1] }
  end

  root
end

def levelorder_enumerator(root)
  return (Enumerator.new {}) if root.nil?

  Enumerator.new do |yielder|
    queue = [root]
    level = []
    next_level_last_node = nil
    current_level_last_node = root

    while queue.length != 0 do
      node = queue.shift
      level << node

      if !node.left.nil?
        queue << node.left
        next_level_last_node = node.left
      end

      if !node.right.nil?
        queue.append(node.right)
        next_level_last_node = node.right
      end

      if node == current_level_last_node
        yielder << level
        level = []
        current_level_last_node = next_level_last_node
        next_level_last_node = nil
      end
    end
  end
end
