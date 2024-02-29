def interval_intersection(first_list, second_list)
  return [] if first_list.empty? || second_list.empty?

  i = 0
  j = 0
  result = []
  while (i != first_list.length && j != second_list.length)
    a = first_list[i][0]
    b = first_list[i][1]
    c = second_list[j][0]
    d = second_list[j][1]

    if c <= a && b <= d || c <= b && b < d
      result << [[a, c].max, [b, d].min]
      i += 1
    elsif a <= c && d <= b || c < a && a <= d
      result << [[a, c].max, [b, d].min]
      j += 1
    else
      i += 1 if b < c
      j += 1 if d < a
    end
  end

  result
end
