def optimal_points(segments)
  segments.sort! { |s1, s2| s1[1] <=> s2[1] }
  points = []
  while !segments.empty?
    s = segments.shift
    points << s[1]

    while !segments.empty? && segments[0][0] <= s[1] && s[1] <= segments[0][1]
      segments.shift
    end
  end
  points
end

if __FILE__ == $0
  data = STDIN.read.split().map(&:to_i)
  n = data[0]
  segments = data[1..2*n].each_slice(2).to_a
  points = optimal_points(segments)
  puts points.size
  puts points.join(' ')
end
