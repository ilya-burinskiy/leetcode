defmodule Cache do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get(k) do
    Agent.get(__MODULE__, fn table -> Map.fetch(table, k) end)
  end

  def put(k, v) do
    Agent.update(__MODULE__, fn table -> Map.put(table, k, v) end)
  end

  def stop() do
    Agent.stop(__MODULE__)
  end
end

defmodule Solution do
  def num_trees(n) do
    {:ok, _pid} = Cache.start_link(%{0 => 1, 1 => 1})
    res = num_trees_helper(n)
    Cache.stop()
    res
  end

  def num_trees_helper(n) do
    Enum.map(1..n, fn k ->
      left_subtrees_cnt =
        case Cache.get(k - 1) do
          {:ok, left_subtrees_cnt} ->
            left_subtrees_cnt

          :error ->
            count = num_trees_helper(k - 1)
            Cache.put(k - 1, count)
            count
        end

      right_subtrees_cnt =
        case Cache.get(n - k) do
          {:ok, right_subtrees_cnt} ->
            right_subtrees_cnt

          :error ->
            count = num_trees_helper(n - k)
            Cache.put(n - k, count)
            count
        end

      left_subtrees_cnt * right_subtrees_cnt
    end)
    |> Enum.sum()
  end
end
