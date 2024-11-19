=begin
if D = 0 then error(DivisionByZeroException) end -- Деление на ноль
Q := 0                  -- Начальные значения частного и остатка полагаем равны 0
R := 0                     
for i := n − 1 .. 0 do  -- Здесь n равно числу бит в N
  R := R << 1           -- Сдвиг влево числа R на 1 бит
  R(0) := N(i)          -- Полагаем младший бит R равным биту i делимого
  if R >= D then
    R := R − D
    Q(i) := 1
  end
end
=end

def divide(n, d)
  return 0 if n == 0
  return in_range(n) if d == 1
  return in_range(-n) if d == -1

  is_positive = true
  if n < 0 && d > 0
    n = -n
    is_positive = false
  elsif n < 0 && d < 0
    n = -n
    d = -d
  elsif n > 0 && d < 0
    d = -d
    is_positive = false
  end
  q = unsigned_divide(n, d)[0]
  q = -q if !is_positive

  q
end

def unsigned_divide(n, d)
  r = 0
  q = 0
  31.downto(0).each do |i|
    r = r << 1
    # R(0) = N(i)
    if n >> i & 1 == 0
      r = r - 1 if r & 1 == 1
    else
      r = r + 1 if r & 1 == 0
    end

    if r >= d
      r = r - d
      q = q | (1 << i)
    end
  end

  [q, r]
end

def in_range(x)
  if x > 2 ** 31 - 1
    2 ** 31 - 1
  elsif x < -2 ** 31
    -2 ** 31
  else
    x
  end
end
