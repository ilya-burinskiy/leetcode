class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def reverse_list(head)
  helper(head, nil)
end

def helper(head, result)
  return result if head.nil?

  helper(head.next, ListNode.new(head.val, result))
end
