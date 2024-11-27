=begin
[[0, 1], [1, 2]]         => { 0 => [1], 1 => [2] }
[[0, 2], [1, 3], [1, 2]] => { 0 => [2], 1 => [2, 3] }
[[0, 2], [1, 3], [1, 2]].group_by { |arr| arr[0] }.transform_values { |arrs| arrs.map { |arr| arr[1] }}
=end

def topological_sort(edges)
end

def dfs(graph, &block)
  verticies = {}
  predecessors = {}
  seen = Set.new

  graph.each do |n, v|
  end
end

def dfs_visit(node)

end

def to_graph(edges)
  edges
    .group_by { |edge| edge[0] }
    .transform_values { |edges| edges.map { |edge| edge[1] } }
end
