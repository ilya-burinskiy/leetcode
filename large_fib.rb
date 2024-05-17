def pi(m)
  p = [0, 1]
  a = 0
  b = 1

  i = 1
  while i <= m * m - 1
    if i > 1 && p[-1] == 1 && p[-2] == 0
      p = p[..-3]
      break
    end

    c = (a + b) % m
    a = b
    b = c
    p << c
    i += 1
  end

  if p[-1] == 1 && p[-2] == 0
    p = p[..-3]
  end

  p
end

def large_fib(n, m)
  pesano_seq = pi(m)
  pesano_seq[n % pesano_seq.length]
end

if __FILE__ == $0
  n, m = gets.split().map(&:to_i)
  p large_fib(n, m)
end
