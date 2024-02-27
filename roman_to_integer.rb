ROMAN2DECIMAL = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}.freeze

def roman_to_int(s)
  result = 0
  chars = s.split('')
  chars.each_with_index do |char, i|
    next_char = chars[i + 1]
    if next_char.nil? || ROMAN2DECIMAL[char] >= ROMAN2DECIMAL[next_char]
      result += ROMAN2DECIMAL[char]
    else
      result -= ROMAN2DECIMAL[char]
    end
  end

  result
end
