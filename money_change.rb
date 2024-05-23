def gen_money_changes(amount, denoms)
  return [] if amount < 0 || denoms.empty?
  return [[]] if amount == 0

  ch1 = money_change(amount, denoms[...-1])
  ch2 = money_change(amount - denoms.last, denoms)
  ch2.each { |d| d << denoms.last }
  ch1 + ch2
end

def min_money_change(amount, denoms)
  return Float::INFINITY if amount < 0 || denoms.empty?
  return 0 if amount == 0

  ch1 = min_money_change(amount, denoms[...-1])
  ch2 = min_money_change(amount - denoms.last, denoms) + 1
  [ch1, ch2].min
end

def memoized_min_money_change(amount, denoms)
  table = Array.new(amount + 1, Float::INFINITY)
  table[0] = 0


  (1..amount).each do |m|
    denoms.each do |d|
      table[m] = [table[m], 1 + table[m - d]].min if d <= m
    end
  end
  table[amount]
end

