def optimal_value(max_capacity, weights, values)
  val_per_weights = values.each_with_index.map do |val, i|
    Rational(val, weights[i])
  end

  value = Rational(0)
  cap = max_capacity
  while cap != 0 && !val_per_weights.empty?
    val_per_weight, idx = val_per_weights.each_with_index.max { |a, b| a[0] <=> b[0] }
    weight = [cap, weights[idx]].min
    value += val_per_weight * weight
    cap -= weight

    val_per_weights.delete_at(idx)
    weights.delete_at(idx)
    values.delete_at(idx)
  end

  value.to_f
end

if __FILE__ == $0
  data = STDIN.read.split().map(&:to_i)
  n, capacity = data[0,2]
  values = data.values_at(*(2..2*n).step(2))
  weights = data.values_at(*(3..2*n+1).step(2))

  answer = optimal_value(capacity, weights, values)
  puts "#{'%.4f' % answer}"
end
