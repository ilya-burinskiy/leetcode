defmodule Solution do
  defmodule MaxPalindromeBounds do
    use Agent

    def start_link(init_val) do
      Agent.start_link(fn -> init_val end, name: __MODULE__)
    end

    def set_l(l) do
      Agent.update(__MODULE__, fn bounds -> {l, elem(bounds, 1)} end)
    end

    def set_r(r) do
      Agent.update(__MODULE__, fn bounds -> {elem(bounds, 0), r} end)
    end

    def get_l() do
      Agent.get(__MODULE__, fn bounds -> elem(bounds, 0) end)
    end

    def get_r() do
      Agent.get(__MODULE__, fn bounds -> elem(bounds, 1) end)
    end
    
    def stop() do
      Agent.stop(__MODULE__)
    end
  end

  # TIME LIMIT EXCEEDED
  def longest_palindrome(str) do
    MaxPalindromeBounds.start_link({0, 0})

    Enum.each(0..(String.length(str) - 1), fn i ->
      odd_len = expand(str, i, i)
      odd_dist = div(odd_len, 2)

      if odd_len > MaxPalindromeBounds.get_r() - MaxPalindromeBounds.get_l() + 1 do
        MaxPalindromeBounds.set_l(i - odd_dist)
        MaxPalindromeBounds.set_r(i + odd_dist)
      end

      even_len = expand(str, i, i + 1)
      even_dist = div(even_len, 2) - 1

      if even_len > MaxPalindromeBounds.get_r() - MaxPalindromeBounds.get_l() + 1 do
        MaxPalindromeBounds.set_l(i - even_dist)
        MaxPalindromeBounds.set_r(i + 1 + even_dist)
      end
    end)

    l = MaxPalindromeBounds.get_l()
    r = MaxPalindromeBounds.get_r()
    MaxPalindromeBounds.stop()
    String.slice(str, l..r)
  end

  defp expand(str, i, j) do
    expand_helper(str, i, j)
  end

  defp expand_helper(str, l, r) do
    if l >= 0 and r < String.length(str) and
         String.at(str, l) == String.at(str, r) do
      expand_helper(str, l - 1, r + 1)
    else
      r - l - 1
    end
  end
end
