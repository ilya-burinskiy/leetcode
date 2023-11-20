def pascal(row, column)
  if column == 0 || column > row then 0
  elsif column == 1 && row == 1 then 1
  else
    pascal(row - 1, column - 1) + pascal(row - 1, column)
  end
end

def get_row(row_index)
  row = []
  for i in 1..row_index + 1
    row << pascal(row_index + 1, i)
  end

  row
end
