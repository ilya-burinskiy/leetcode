def merge(intervals)
  sorted = intervals.sort { |i1, i2| i1[0] <=> i2[0] }
  sorted[1..].reduce([sorted[0]]) do |result, interval|
    if result[-1][1] >= interval[0]
      result[-1][1] = [interval[1], result[-1][1]].max
    else
      result << interval
    end

    result
  end
end
