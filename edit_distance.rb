def edit_distance(a, b)
  table = Array.new(a.length + 1) { Array.new(b.length + 1, 0) }

  (0..a.length).each do |i|
    (0..b.length).each do |j|
      if i == 0 || j == 0
        table[i][j] = [i, j].max
        next
      end

      insertion = table[i][j - 1] + 1
      deletion = table[i - 1][j] + 1
      match = table[i - 1][j - 1]
      mismatch = table[i - 1][j - 1] + 1
      if a[i - 1] != b[j - 1]
        table[i][j] = [insertion, deletion, mismatch].min
      else
        table[i][j] = [insertion, deletion, match].min
      end
    end
  end

  table[a.length][b.length]
end

if __FILE__ == $0
  a, b = gets.chomp, gets.chomp
  puts edit_distance(a, b)
end
