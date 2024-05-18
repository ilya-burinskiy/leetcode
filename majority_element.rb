def majority_element_divide_and_conquer(arr, l, r)
  return arr[l] if r - l == 1

  m = (l + r) / 2
  left_major_el = majority_element_divide_and_conquer(arr, l, m)
  right_major_el = majority_element_divide_and_conquer(arr, m, r)
  left_major_el_cnt = 0
  right_major_el_cnt = 0
  arr[l...r].each do |el|
    left_major_el_cnt += 1 if el == left_major_el
    right_major_el_cnt += 1 if el == right_major_el
  end

  return left_major_el if left_major_el_cnt > (r - l) / 2
  return right_major_el if right_major_el_cnt > (r - l) / 2

  nil
end

def majority_element_naive(arr)
  h = Hash.new(0)
  arr.each do |el|
    h[el] += 1
  end

  h.values.filter { |v| v > arr.length / 2 }.length > 0 ? 1 : 0
end

if __FILE__ == $0
  n, *a = STDIN.read.split().map(&:to_i)
  answer = majority_element_divide_and_conquer(a, 0, a.length)

  puts "#{answer.nil? ? 0 : 1}"
end
