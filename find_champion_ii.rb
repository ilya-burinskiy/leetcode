def to_graph(n, edges)
  graph = {}
  (0...n).each { |i| graph[i] = [] }
  edges.each do |edge|
    graph[edge[0]] << edge[1]
  end
  graph
end

def indegree_count(graph)
  res = {}
  graph.keys.each { |k| res[k] = 0 }
  graph.values.each do |edges|
    edges.each { |v| res[v] = res[v] + 1 }
  end
  res
end

def find_champion(n, edges)
  champions = indegree_count(to_graph(n, edges)).filter { |_, v| v == 0 }
  if champions.count == 1
    champions.keys[0]
  else
    -1
  end
end
