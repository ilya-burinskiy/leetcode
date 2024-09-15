def longest_valid_parentheses(str)
  return 0 if str == ""

  res = Array.new(str.length, 1)
  stack = []
  (0...str.length).each do |i|
    if str[i] == '('
      stack << ['(', i]
    elsif str[i] == ')'
      next stack << [')', i] if stack.empty? || stack[-1][0] != '('

      stack.pop
    end
  end

  while !stack.empty?
    res[stack[-1][1]] = 0
    stack.pop
  end

  max_sub_array(res)
end

def max_sub_array(arr)
  max_len = 0
  curr_len = 0
  arr.each do |x|
    if x == 0
      max_len = max_(max_len, curr_len)
      curr_len = 0
    else
      curr_len += 1
    end
  end

  max_(max_len, curr_len)
end

def max_(a, b)
  a > b ? a : b
end
