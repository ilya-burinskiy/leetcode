defmodule MajorityElement do
  @spec majority_element(nums :: [integer]) :: integer
  def majority_element([x | []]) do
    x
  end

  @spec majority_element(nums :: [integer]) :: integer
  def majority_element(nums) do
    n = length(nums)
    {left_half, right_half} = Enum.split(nums, div(n, 2))
    left_major_el = majority_element(left_half)
    right_major_el = majority_element(right_half)

    %{^left_major_el => left_major_el_cnt, ^right_major_el => right_major_el_cnt} =
      Enum.frequencies(nums) |> Map.merge(%{nil: 0})

    cond do
      left_major_el_cnt > div(n, 2) -> left_major_el
      right_major_el_cnt > div(n, 2) -> right_major_el
      true -> nil
    end
  end
end
