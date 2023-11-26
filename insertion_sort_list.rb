require 'debug'

class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def insertion_sort_list(head)
  dummy = ListNode.new
  curr = head

  while !curr.nil?
    prev = dummy

    while prev.next && prev.next.val <= curr.val
      prev = prev.next
    end

    tmp = curr.next
    curr.next = prev.next
    prev.next = curr
    curr = tmp
  end

  dummy.next
end

def main
  l = ListNode.new(
    3,
    ListNode.new(
      2,
      ListNode.new(1)
    )
  )
  p insertion_sort_list(l)
end

main
