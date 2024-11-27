require 'set'

class CycleError < StandardError; end

def topological_sort(edges)
  graph = to_graph(edges)
  order = []
  dfs(graph) do |v|
    order << v
  rescue CycleError
    return []
  end

  order
end

def dfs(graph, &block)
  predecessors = {}
  seen = Set.new
  vs = Set.new
  graph.each do |v, edges|
    vs.add(v)
    edges.each { |u| vs.add(u) }
  end

  debugger
  vs.each do |v|
    dfs_visit(v, graph, predecessors, seen, &block) if !seen.include?(v)
  end
end

def dfs_visit(v, graph, predecessors, seen, &block)
  seen.add(v)
  graph[v].each do |u| 
    raise CycleError if predecessors[v] == u

    if !seen.include?(u)
      predecessors[u] = v
      dfs_visit(u, graph, predecessors, seen, &block)
    end
  end

  block.call(v)
end

def to_graph(edges)
  graph = {}
  edges.each do |edge|
    graph[edge[0]] = [] if !graph.key?(edge[0])
    graph[edge[0]] << edge[1]
    graph[edge[1]] = []
  end
  graph
end

puts to_graph([[0, 1], [1, 2]])
