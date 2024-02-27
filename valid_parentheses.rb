BRACES = {
  '(' => :l_round,
  ')' => :r_round,
  '[' => :l_square,
  ']' => :r_square,
  '{' => :l_curly,
  '}' => :r_curly
}

def is_valid(s)
  stack = []
  s.split('').each do |char|
    br = BRACES[char]
    case br
    when :l_round, :l_square, :l_curly
      stack.push(br)
    when :r_round
      top = stack.pop
      return false if top != :l_round
    when :r_square
      top = stack.pop
      return false if top != :l_square
    when :r_curly
      top = stack.pop
      return false if top != :l_curly
    end
  end

  stack.empty?
end
