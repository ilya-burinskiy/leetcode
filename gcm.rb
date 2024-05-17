def gcm(a, b)
  b, a = a, b if b > a
  while b != 0
    a, b = b, a % b
  end
  a
end

if __FILE__ == $0
  a, b = gets.split.map(&:to_i)
  p gcm(a, b)
end
