defmodule Stack do
  use Agent

  def start_link(init_val) do
    Agent.start_link(fn -> init_val end, name: __MODULE__)
  end

  def push(val) do
    Agent.update(__MODULE__, fn stack -> [val | stack] end)
  end

  def pop() do
    case Agent.get(__MODULE__, & &1) do
      [] ->
        {:error, "empty stack"}

      [head | tail] ->
        Agent.update(__MODULE__, fn _ -> tail end)
        {:ok, head}
    end
  end

  def stop() do
    Agent.stop(__MODULE__)
  end
end

defmodule Solution do
  @spec eval_rpn(tokens :: [String.t()]) :: integer
  def eval_rpn(tokens) do
    {:ok, _pid} = Stack.start_link([])
    {:ok, res} = eval_rpn_helper(tokens)
    Stack.stop()
    res
  end

  def eval_rpn_helper([]) do
    Stack.pop()
  end

  def eval_rpn_helper([token | tokens]) do
    case token do
      "+" ->
        {:ok, rhs} = Stack.pop()
        {:ok, lhs} = Stack.pop()
        Stack.push(lhs + rhs)

      "-" ->
        {:ok, rhs} = Stack.pop()
        {:ok, lhs} = Stack.pop()
        Stack.push(lhs - rhs)

      "*" ->
        {:ok, rhs} = Stack.pop()
        {:ok, lhs} = Stack.pop()
        Stack.push(lhs * rhs)

      "/" ->
        {:ok, rhs} = Stack.pop()
        {:ok, lhs} = Stack.pop()
        Stack.push(div(lhs, rhs))

      _ ->
        {val, _} = Integer.parse(token)
        Stack.push(val)
    end

    eval_rpn_helper(tokens)
  end
end
