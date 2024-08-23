=begin
s - строка палиндром нечетной длины n
i = j = n / 2: s[i] = s[j]. подстрока s[i - 1..j + 1] - палиндром


     r a c e c a r
     0 1 2 3 4 5 6

r 0  t f f f t f t
a 1  t t f f f t f
c 2  t t t f t f f
e 3  t t t t f f f
c 4  t t t t t f f
a 5  t t t t t t f
r 6  t t t t t t t


i = j
i = i + 1
i = i + 2
  ...
i = i + n - 1

s[i..j].length == 1:
  all are palindromes
s[i..j].length == 2:
  s[0..1] f
  s[1..2] f
  s[2..3] f
  s[3..4] f
  s[4..5] f
  s[5..6] f
s[i..j].length == 3:
  s[0..2]: s[0](r) != s[2](c) && dp[1][1] => s[0..2] not a palindrome,
  s[1..3]: s[1](a) != s[3](e) && dp[2][2] => s[1..3] not a palindrome,
  s[2..4]: s[2](c) == s[4](c) && dp[3][3] => s[2..4] a palindrome,
  s[3..5]: s[3](e) != s[5](a) && dp[4][4] => s[3..5] not a palindrome,
  s[4..6]: s[4](c) != s[6](r) && dp[5][5] => s[4..6] not a palindrome
s[i..j].length == 4:
  s[0..3] s[0](r) != s[3](e) && dp[1][2](f) => f
  s[1..4] s[1](a) != s[4](c) && dp[2][3](f) => f
  s[2..5] s[2](c) != s[5](a) && dp[3][4](f) => f
  s[3..6] s[3](e) != s[6](r) && dp[4][5](f) => f
s[i..j].length == 5:
  s[0..4]: s[0](r) != s[4](c) && dp[1][3]
  s[1..5]
  s[2..6]
=end

def longest_palindrome_dp(s)
  table = Array.new(s.length) { Array.new(s.length, true) }
  l = r = 0
  (1...s.length).each do |d|
    (0...s.length - d).each do |i|
      table[i][i + d] = s[i] == s[i + d] && table[i + 1][i + d - 1]
      l, r = i, i + d if table[i][i + d] && d > r - l
    end
  end

  s[l..r]
end

def longest_palindrome(str)
  l = r = 0
  (0...str.length).each do |i|
    odd_len = expand(str, i, i)
    odd_dist = odd_len / 2
    l, r = i - odd_dist, i + odd_dist if odd_len > r - l + 1

    even_len = expand(str, i, i + 1)
    even_dist = (even_len / 2) - 1
    l, r = i - even_dist, i + 1 + even_dist if even_len > r - l + 1
  end

  str[l..r]
end

# s_l-2 s_l-1, s_l    s_l+1, s_l+2, ...
#  ^           ^              ^ 
#  |           |              |
# l'          i, j            r'
#
# l = l' >= 0, r = r' < str.length
# dst = (r' - 1) - (l' + 1) + 1 = r' - 1 - l'
# l' = -1; r' = str.length
# dst = (str.length - 1) - (-1 + 1) + 1 = str.length - 1 + 1 = str.length
def expand(str, i, j)
  l = i
  r = j
  while l >= 0 && r < str.length && str[l] == str[r]
    l -= 1
    r += 1
  end

  r - l - 1
end
