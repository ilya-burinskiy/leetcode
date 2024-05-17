def largest_number(a)
  a.sort! do |x, y|
    u = x.to_f / (10 ** decimal_len(x) - 1)
    v = y.to_f / (10 ** decimal_len(y) - 1)
    v <=> u
  end
  a.join('')
end

def decimal_len(n)
  ord = 0
  while n != 0
    n /= 10
    ord += 1
  end
  ord
end

if __FILE__ == $0
  a = STDIN.read.split().drop(1).map(&:to_i)
  puts largest_number(a)
end
