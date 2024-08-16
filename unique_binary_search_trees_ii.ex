# T(1, 3) = 1..3.each { |k| combine(T(1, k - 1), T(k + 1, 3)) }
# T(1, 3) = combine(T(1, 0), T(2, 3)) ++ combine(T(1, 1), T(3, 3)) ++ combine(T(1, 2), T(4, 3))
# T(1, 3) = combine([nil], T(2, 3)) ++ combine(T(1, 1), T(3, 3)) ++ combine(T(1, 2), [nil])
#
# T(2, 3) = 2..3.each { |k| combine(T(2, k - 1), T(k + 1, 3)) }
# T(2, 3) = combine(T(2, 1), T(3, 3))
#
# T(1, 2) = combine(T(1, 0), T(2, 2)) ++ combine(T(1, 1), T(3, 2))
# T(1, 2) = combine([nil], T(2, 2)) ++ combine([%TreeNode{val: 1}], [nil])
# T(1, 2) = combine([nil], [%TreeNode{val: 2}], 1) ++ combine([%TreeNode{val: 1}], [nil], 2)
# combine()
#
# T(2, 2) = combine(T(2, 1), T(3, 2)) = [nil], [nil], 2 =[%TreeNode{val: 2}]
#
# T(1, 1) = combine(T(1, 0), T(2, 1)) = [nil] [nil] 1 = [%TreeNode{val: 1}]
# T(1, 0) = [nil]
# T(2, 1) = [nil]
# &(module_name.function_name/arity)
# fn x -> x + 1 end ~ &(&1 + 1)

defmodule TreeNode do
  @type t :: %__MODULE__{
          val: integer,
          left: TreeNode.t() | nil,
          right: TreeNode.t() | nil
        }
  defstruct val: 0, left: nil, right: nil
end

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
  @spec generate_trees(n :: integer) :: [TreeNode.t() | nil]
  def generate_trees(n) do
    {:ok, _pid} = Cache.start_link(%{})
    res = generate_trees_helper(1, n)
    Cache.stop()
    res
  end

  def generate_trees_helper(l, r) when l > r, do: [nil]

  def generate_trees_helper(l, r) do
    Enum.flat_map(l..r, fn k ->
      left_subtrees =
        case Cache.get({l, k - 1}) do
          {:ok, left_subtrees} ->
            left_subtrees

          :error ->
            trees = generate_trees_helper(l, k - 1)
            Cache.put({l, k - 1}, trees)
            trees
        end

      right_subtrees =
        case Cache.get({k + 1, r}) do
          {:ok, right_subtrees} ->
            right_subtrees

          :error ->
            trees = generate_trees_helper(k + 1, r)
            Cache.put({k + 1, r}, trees)
            trees
        end

      combine(left_subtrees, right_subtrees, k)
    end)
  end

  def combine(left_trees, right_trees, root_val) do
    for(
      ltree <- left_trees,
      do: for(rtree <- right_trees, do: %TreeNode{val: root_val, left: ltree, right: rtree})
    )
    |> List.flatten()
  end
end
