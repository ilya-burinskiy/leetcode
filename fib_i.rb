def fib(n)
  return n if n == 0 || n == 1

  a = 1 # f1
  b = 0 # f0
  (1..n-1).each do
    a, b = a + b, a
  end
  a
end

if __FILE__ == $0
  n = gets.to_i
  p fib(n)
end
