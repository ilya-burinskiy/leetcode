defmodule ListNode do
  @type t :: %__MODULE__{
    val: integer,
    next: ListNode.t() | nil
  }
  defstruct val: 0, next: nil
end

defmodule Solution do
  @spec reverse_k_group(head :: ListNode.t | nil, k :: integer) :: ListNdoe.t | nil
  def reverse_k_group(head, k) do
    {:ok, kgroups_agent} = Agent.start_link(fn -> nil end)
    reverse_k_group_helper(head, k, kgroups_agent)
    res = Agent.get(kgroups_agent, fn kgroups -> kgroups end)
    Agent.stop(kgroups_agent)
    res
  end

  def reverse_k_group_helper(head, k, kgroups_agent) do
    {{kgroup, group_size}, rest} = take(head, k)
    case rest do
      nil ->
        if group_size != k do
          Agent.update(kgroups_agent, fn _res -> kgroup end)
        else
          Agent.update(kgroups_agent, fn res -> insert_reversed(kgroup, res) end)
        end
        :ok
      _ ->
        reverse_k_group_helper(rest, k, kgroups_agent)
        Agent.update(kgroups_agent, fn res -> insert_reversed(kgroup, res) end)
    end
  end

  def insert_reversed(nil, res), do: res

  def insert_reversed(%ListNode{val: val, next: next}, res) do
    insert_reversed(next, %ListNode{val: val, next: res})
  end

  def take(head, k) do
    cond do
      k > 0 -> take_helper(head, k)
      true -> {{nil, 0}, nil}
    end
  end

  def take_helper(nil, _) do
    {{nil, 0}, nil}
  end

  def take_helper(%ListNode{val: val, next: next}, 1) do
    {{%ListNode{val: val, next: nil}, 1}, next}
  end

  def take_helper(%ListNode{val: val, next: next}, k) do
    {{xs, xs_size}, rest} = take_helper(next, k - 1)
    {{%ListNode{val: val, next: xs}, xs_size + 1}, rest}
  end
end
