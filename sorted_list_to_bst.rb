class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def sorted_list_to_bst(head)
  res, _ = helper(head, length(head))
  res
end

def helper(lst, n)
  if n == 0
    return nil, lst
  else
    left_size = (n - 1) / 2
    left_tree, non_left_elms = helper(lst, left_size)
    right_size = n - left_size - 1
    right_tree, remain_elms = helper(non_left_elms.next, right_size)

    return TreeNode.new(non_left_elms.val, left_tree, right_tree), remain_elms
  end
end

def length(head)
  len = 0
  while head != nil
    head = head.next
    len += 1
  end
  len
end
