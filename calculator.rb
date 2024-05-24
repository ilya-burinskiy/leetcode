def gen_calculations(m)
  return [[1], 0] if m == 1

  seq1, calcs1 = gen_calculations(m - 1)
  seq2, calcs2 = if m % 2 == 0
                   gen_calculations(m / 2)
                 else
                   [[], Float::INFINITY]
                 end
  seq3, calcs3 = if m % 3 == 0
                   gen_calculations(m / 3)
                 else
                   [[], Float::INFINITY]
                 end
  min_calc = [calcs1, calcs2, calcs3].min
  if min_calc == calcs1
    seq = seq1
  elsif min_calc == calcs2
    seq = seq2
  else
    seq = seq3
  end

  [seq << m, min_calc + 1]
end

def memoized_gen_calculations(m)
  table = Array.new(m + 1, [[], Float::INFINITY])
  table[1] = [[1], 0]
  memoized_gen_calculations_bottom_up(m, table)
end

def memoized_gen_calculations_bottom_up(m, table)
  return table[m] if table[m][1] != Float::INFINITY

  (2..m).each do |i|
    seq1, min_calcs1 = table[i - 1]
    seq2, min_calcs2 = if i % 2 == 0
                         table[i / 2]
                       else
                         [[], Float::INFINITY]
                       end
    seq3, min_calcs3 = if i % 3 == 0
                         table[i / 3]
                       else
                         [[], Float::INFINITY]
                       end
    min_calcs = [min_calcs1, min_calcs2, min_calcs3].min
    if min_calcs == min_calcs1
      seq = seq1
    elsif min_calcs == min_calcs2
      seq = seq2
    else
      seq = seq3
    end

    table[i] = [seq.dup << i, min_calcs + 1]
  end

  table[m]
end

if __FILE__ == $0
  n = gets.to_i
  seq, min_calcs = memoized_gen_calculations(n)
  p min_calcs
  p seq.join(' ')
end
