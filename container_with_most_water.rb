# NOTE: with hints
def max_area(heights)
  i = 0
  j = heights.length - 1
  volume = 0

  while i < j
    volume = [volume, (j - i) * [heights[i], heights[j]].min].max
    if heights[i] < heights[j]
      i += 1
    else
      j -= 1
    end
  end

  volume
end
