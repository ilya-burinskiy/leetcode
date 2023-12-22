class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def add_two_numbers(l1, l2)
  helper(l1, l2, nil, 0)
end

def helper(l1, l2, result, c)
  if  l1.nil? && l2.nil?
    if c != 0
      reverse_list(ListNode.new(1, result))
    else
      reverse_list(result)
    end
  elsif l1.nil?
    helper(
      l1,
      l2.next,
      ListNode.new((l2.val + c) % 10, result),
      (l2.val + c) / 10
    )
  elsif l2.nil?
    helper(
      l1.next,
      l2,
      ListNode.new((l1.val + c) % 10, result),
      (l1.val + c) / 10
    )
  else
    helper(
      l1.next,
      l2.next,
      ListNode.new((l1.val + l2.val + c) % 10, result),
      (l1.val + l2.val + c) / 10
    )
  end
end

def reverse_list(head)
  reverse_helper(head, nil)
end

def reverse_helper(head, result)
  return result if head.nil?

  reverse_helper(head.next, ListNode.new(head.val, result))
end
