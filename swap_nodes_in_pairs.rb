class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def swap_pairs(head)
  return nil if head.nil?
  return head if head.next.nil?

  head_val = head.val
  next_node = head.next

  ListNode.new(
    next_node.val,
    ListNode.new(
      head.val,
      swap_pairs(next_node.next)
    )
  )
end
