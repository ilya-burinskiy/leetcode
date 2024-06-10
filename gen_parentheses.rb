def generate_parenthesis(n)
  return [""] if n == 0
  return ["()"] if n == 1

  res = []
  (1..n).each do |k|
    res += combine(generate_parenthesis(k - 1), generate_parenthesis(n - k))
  end
  res
end

def combine(a, b)
  a.map { |pseq| "(#{pseq})"}.map do |pseq1|
    b.map { |pseq2| "#{pseq1}#{pseq2}" }
  end.flatten(1)
end
