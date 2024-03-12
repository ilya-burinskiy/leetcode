def reverse(x)
  sign = x >= 0 ? 1 : -1
  x = x.abs
  tmp = x
  n = 0
  while tmp != 0
    tmp /= 10
    n += 1
  end

  result = 0
  (0...n).each do |i|
    digit = (x / 10 ** i) % 10
    result += digit * 10 ** (n - i -1)
  end

  (-(2 ** 31)...2 ** 31).include?(result) ? result * sign : 0
end
