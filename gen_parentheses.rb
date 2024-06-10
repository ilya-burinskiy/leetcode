def generate_parenthesis(n)
  @table ||= {0 => [""], 1 => ["()"]}

  return [""] if n == 0
  return ["()"] if n == 1

  res = []
  (1..n).each do |k|
    pseq1 = if @table.key?(k - 1)
              @table[k - 1]
            else
              @table[k - 1] = generate_parenthesis(k - 1)
              @table[k - 1]
            end
    pseq2 = if @table.key?(n - k)
              @table[n - k]
            else
              @table[n - k] = generate_parenthesis(n - k)
              @table[n - k]
            end
    res += combine(pseq1, pseq2)
  end

  res
end

def combine(a, b)
  a.map { |pseq| "(#{pseq})"}.map do |pseq1|
    b.map { |pseq2| "#{pseq1}#{pseq2}" }
  end.flatten(1)
end
