def partition(arr, l, r)
  j = k = l
  rnd = rand(l...r)
  arr[l], arr[rnd] = arr[rnd], arr[l]
  pivot = arr[l]
  (l + 1...r).each do |i|
    if arr[i] < pivot
      j += 1
      k += 1
      arr[j], arr[i] = arr[i], arr[j]
      arr[k], arr[i] = arr[i], arr[k] if j < k
    elsif arr[i] == pivot
      k += 1
      arr[k], arr[i] = arr[i], arr[k]
    end
  end
  arr[l], arr[j] = arr[j], arr[l]

  return j, k
end

def qsort(arr, l, r)
  if l < r
    j, k = partition(arr, l, r)
    qsort(arr, l, j)
    qsort(arr, k + 1, r)
  end
end

if __FILE__ == $0
  n, *a = STDIN.read.split().map(&:to_i)
  qsort(a, 0, n)
  puts "#{a.join(' ')}"
end
