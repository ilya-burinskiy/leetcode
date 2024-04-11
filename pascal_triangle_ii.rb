def pascal(i, j)
  @h ||= {[0, 0] => 1}
  if j > i || j < 0 then 0
  elsif @h.key?([i, j]) then @h[[i, j]]
  else
    @h[[i, j]] = pascal(i - 1, j - 1) + pascal(i - 1, j)
    @h[[i, j]]
  end
end

def get_row(row_index)
  row = []
  for j in 0..row_index
    row << pascal(row_index, j)
  end

  row
end
