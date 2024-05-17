def optimal_summands(n)
  summands = []
  prev_k = k = 1
  s = k * (k + 1) / 2
  while s <= n
    prev_k = k
    k += 1
    s = k * (k + 1) / 2
  end
  d = n - (prev_k - 1) * prev_k / 2
  (1...prev_k).each { |i| summands << i }
  if d >= 0
    summands << d
  end
  summands
end

if __FILE__ == $0
  n = gets.to_i
  summands = optimal_summands(n)
  puts summands.size
  puts summands.join(' ')
end
