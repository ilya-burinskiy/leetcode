def number_of_inversions(arr, l, r)
  return 0 if r - l <= 1

  m = (l + r) / 2
  inversions = number_of_inversions(arr, l, m)
  inversions += number_of_inversions(arr, m, r)
  inversions += merge(arr, l, m, r)
  inversions
end

def merge(arr, l, m, r)
  left_arr = arr[l...m].dup
  right_arr = arr[m...r].dup
  left_arr_size = m - l
  right_arr_size = r - m

  inversions = i = j = 0
  k = l
  while i < left_arr_size && j < right_arr_size
    if left_arr[i] <= right_arr[j]
      arr[k] = left_arr[i]
      i += 1
    else
      inversions += left_arr_size - i
      arr[k] = right_arr[j]
      j += 1
    end
    k += 1
  end

  if i != left_arr_size
    while i < left_arr_size
      arr[k] = left_arr[i]
      i += 1
      k += 1
    end
  else
    while j < right_arr_size
      arr[k] = right_arr[j]
      j += 1
      k += 1
    end
  end

  inversions
end

if __FILE__ == $0
  gets
  arr = gets.split.map(&:to_i)
  puts number_of_inversions(arr, 0, arr.length)
end
