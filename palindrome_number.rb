def is_palindrome(x)
  return false if x < 0

  tmp = x
  n = 0
  while tmp != 0
    tmp /= 10
    n += 1
  end

  (0...(n / 2)).each do |i|
    a = (x / 10 ** i) % 10
    b = (x / 10 ** (n - i - 1)) % 10
    return false if a != b
  end

  true
end
