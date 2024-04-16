=begin
T(0) = 0
T(2^m + l) = 1 + T(l), 0 <= l <= 2^m - 1
=end
def count_bits(n)
  result = Array.new(n + 1, 0)
  (1..n).each do |i|
    m = Math.log2(i).floor
    l = i - 2 ** m
    result[i] = 1 + result[l]
  end

  result
end
