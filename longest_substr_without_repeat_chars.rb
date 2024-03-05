def length_of_longest_substring(s)
  return s.length if s.length == 0 || s.length == 1

  sp = s.split('')
  h = { sp[0] => 0 }
  max_substr_len = 1
  i = 0
  j = 1

  while j < sp.length
    if !h.key?(sp[j])
      h[sp[j]] = j
      max_substr_len = [max_substr_len, j - i + 1].max
      j += 1
    else
      i = [h[sp[j]] + 1, i].max
      h.delete(sp[j])
    end
  end

  max_substr_len
end
