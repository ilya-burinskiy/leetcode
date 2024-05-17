class PriorityQueue
  def initialize
    @elements = []
  end

  def empty?
    @elements.empty?
  end

  # insert
  def <<(element)
    @elements << element
    @elements[-1] = Float::INFINITY
    decrease(@elements.length - 1, element)
  end

  # minimum
  def min
    @elements[0]
  end

  # extract-min
  def pop_min
    raise "Queue is empty" if @elements.length == 0

    min = @elements[0]
    @elements[0] = @elements[-1]
    @elements = @elements[0...@elements.length - 1]
    bubble_down(0)
    min
  end

  # deacrease-key
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
