def is_subsequence(s, t)
  s_i = 0
  t_i = 0

  while s_i < s.length
    while t_i < t.length && t[t_i] != s[s_i]
      t_i += 1
    end

    if t_i == t.length
      return false
    else
      s_i += 1
      t_i += 1
    end
  end

  true
end
