defmodule ListNode do
  @type t :: %__MODULE__{
    val: integer,
    next: ListNode.t() | nil
  }
  defstruct val: 0, next: nil
end

defmodule Solution do
  @moduledoc """
  1:2:3:4:5:[], k = 2
  f([1, 2, 3, 4, 5], 2) -> ([1, 2], [3, 4, 5])
  f([3, 4, 5], 2) -> ([3, 4], [5])
  f([5], 2) -> ([5], [])

  2:1:4:3:5
  
  [5] ++ [] = [5]
  [3, 4] ++ [5]

  take([])
  """

  # @spec reverse_k_group(head :: ListNode.t | nil, k :: integer) :: ListNdoe.t | nil
  def reverse_k_group(xs, k) do
    {:ok, kgroups_agent} = Agent.start_link(fn -> [] end) 
    reverse_k_group_helper(xs, k, kgroups_agent)
    Agent.get(kgroups_agent, fn kgroups -> kgroups end)
  end

  def reverse_k_group_helper(xs, k, kgroups_agent) do
    {kgroup, rest} = take(xs, k)
    case rest do
      [] ->
        Agent.update(kgroups_agent, fn res -> Enum.reverse(kgroup, res) end)
        :ok
      _ ->
        reverse_k_group_helper(rest, k, kgroups_agent)
        Agent.update(kgroups_agent, fn res -> Enum.reverse(kgroup,res) end)
    end
  end

  def take(list, k) do
    cond do
      k > 0 ->
        take_helper(list, k)
      true ->
        {[], []}
    end
  end

  def take_helper([], _) do
    {[], []}
  end

  def take_helper([x | xs], 1) do
    {[x], xs}
  end

  def take_helper([x | xs], k) do
    {xss, rest} = take_helper(xs, k - 1)
    {[x | xss], rest}
  end
end
