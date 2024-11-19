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

('01111010'.to_i(2) | "11011100".to_i(2) >> 2 & 1).to_s(2)
=end
$int_32_max = 2 ** 31 - 1
$int_32_min = -2 ** 31

def divide(dividend, divisor)
  # divisor != 0
  return 0 if dividend == 0
  return in_range(dividend) if divisor == 1
  return in_range(-dividend) if divisor == -1

  is_positive = true
  if dividend < 0 && divisor > 0
    dividend = -dividend
    is_positive = false
  elsif dividend < 0 && divisor < 0
    dividend = -dividend
    divisor = -divisor
  elsif dividend > 0 &&  divisor < 0
    divisor = -divisor
    is_positive = false
  end

  q = 0
  while dividend >= divisor
    dividend -= divisor
    q += 1
  end

  q
end

def in_range(x)
  if x > $int_32_max
    $int_32_max
  elsif x < $int_32_min
    $int_32_min
  else
    x
  end
end
