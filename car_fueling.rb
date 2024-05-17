def car_fueling_iter(stops, m, d)
  stops_count = 0
  location = 0
  while location + m < d
    return -1 if stops.empty? || (stops[0] - location) > m

    last_stop = stops[0]
    while !stops.empty? && (stops[0] - location) <= m
      last_stop = stops[0]
      stops.shift
    end
    location = last_stop
    stops_count += 1
  end
  stops_count
end

if __FILE__ == $0
  distance = gets.to_i
  tank_cap = gets.to_i
  gets
  refils = gets.split.map(&:to_i)
  p car_fueling_iter(refils, tank_cap, distance)
end
