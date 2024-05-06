class PriorityQueue
  def initialize
    @elements = []
  end

  def empty?
    @elements.empty?
  end

  def <<(element)
    @elements << element
    @elements[-1] = Float::INFINITY
    decrease(@elements.length - 1, element)
  end

  def min
    @elements[0]
  end

  def pop_min
    raise "Queue is empty" if @elements.length == 0

    min = @elements[0]
    @elements[0] = @elements[-1]
    @elements = @elements[0...@elements.length - 1]
    bubble_down(0)
    min
  end

  def decrease(i, new_val)
    raise "#{new_val} is greater than #{@elements[i]}" if @elements[i] < new_val

    @elements[i] = new_val
    bubble_up(i)
  end

  private

  def parent(i)
    (i - 1) / 2
  end

  def left(i)
    2 * i + 1
  end

  def right(i)
    2 * (i + 1)
  end

  def bubble_up(i)
    while i > 0 && @elements[parent(i)] > @elements[i]
      exchange(i, parent(i))
      i = parent(i)
    end
  end

  def bubble_down(i)
    l = left(i)
    r = right(i)
    if l <= @elements.length - 1 && @elements[l] < @elements[i]
      smallest = l
    else
      smallest = i
    end

    if r <= @elements.length - 1 && @elements[r] < @elements[smallest]
      smallest = r
    end

    if smallest != i
      exchange(i, smallest)
      bubble_down(smallest)
    end
  end

  def exchange(src, target)
    @elements[src], @elements[target] = @elements[target], @elements[src]
  end
end

class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def merge_k_lists(lists)
  return [] if lists.length == 0
  return lists[0] if lists.length == 1

  queue = PriorityQueue.new
  lists.each do |lst|
    while lst != nil
      queue << lst.val
      lst = lst.next
    end
  end

  result = curr = ListNode.new
  while !queue.empty?
    curr.next = ListNode.new(queue.pop_min)
    curr = curr.next
  end

  result.next
end

def merge2lists(l1, l2)
  i = l1
  j = l2
  result = ListNode.new
  curr = result
  while i != nil && j != nil
    if i.val <= j.val
      curr.next = i
      i = i.next
    else
      curr.next = j
      j = j.next
    end
    curr = curr.next
  end

  if i == nil
    while j != nil
      curr.next = j
      curr = curr.next
      j = j.next
    end
  else
    while i != nil
      curr.next = i
      curr = curr.next
      i = i.next
    end
  end

  result.next
end
