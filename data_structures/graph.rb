class Graph
  class Node
    attr_accessor :value, :edges
    def initialize(data)
      @value = data
      @edges = []
    end

    def list_connect_nodes_val(ignore_node = [])
      result = []
      self.edges.each do |edge|
        result << edge.next_node(self.value)
      end
      result - ignore_node
    end
  end
  
  class Edge
    attr_accessor :node_1, :node_2, :weight
    def initialize(node_1, node_2, weight)
      @node_1 = node_1
      @node_2 = node_2
      @weight = weight
    end

    def next_node(node_value)
      self.node_1.value == node_value ? self.node_2.value : self.node_1.value
    end
  end

  attr_accessor :nodes
  def initialize
    @nodes = []
  end

  def insert(value)
    node = Node.new(value)
    @nodes << node
  end

  def find_node(value)
    @nodes.select { |node| node.value == value }.first
  end

  def create_edge(node_1, node_2, weight = 0)
    edge = Edge.new(node_1, node_2, weight)
    node_1.edges << edge
    node_2.edges << edge
  end

  def count_short_way_between_nodes(node_1_value, node_2_value, level = 1, checked_nodes =[])
    start_node = find_node(node_1_value)
    level = level
    result = []
    p "node #{start_node.value} to #{node_2_value}"
    connect_nodes_values = start_node.list_connect_nodes_val(checked_nodes)
    return if connect_nodes_values.empty?
    return 0 if node_2_value == node_1_value
    if connect_nodes_values.include?(node_2_value)
      return level
    else
      level += 1
      checked_nodes = checked_nodes
      checked_nodes << start_node.value unless checked_nodes.include?(start_node.value)
      checked_nodes |= connect_nodes_values
      connect_nodes_values.each do |node_value|
        result << count_short_way_between_nodes(node_value, node_2_value, level, checked_nodes)
      end
    end
    return result.flatten.compact
  end
end

graph = Graph.new
9.times do |i| 
  a = graph.insert(i + 1)
end
graph.create_edge(graph.find_node(1), graph.find_node(2))
graph.create_edge(graph.find_node(1), graph.find_node(4))
graph.create_edge(graph.find_node(1), graph.find_node(3))
graph.create_edge(graph.find_node(2), graph.find_node(4))
graph.create_edge(graph.find_node(3), graph.find_node(4))
graph.create_edge(graph.find_node(4), graph.find_node(5))
graph.create_edge(graph.find_node(6), graph.find_node(5))
graph.create_edge(graph.find_node(6), graph.find_node(7))
graph.create_edge(graph.find_node(5), graph.find_node(8))
graph.create_edge(graph.find_node(8), graph.find_node(9))
graph.create_edge(graph.find_node(7), graph.find_node(9))
# puts '1================'
# puts graph.find_node(1).list_connect_nodes_val
# puts '2================'
# puts graph.find_node(2).list_connect_nodes_val
# puts '3================'
# puts graph.find_node(3).list_connect_nodes_val
# puts '4================'
# puts graph.find_node(4).list_connect_nodes_val
# puts '5================'
# puts graph.find_node(5).list_connect_nodes_val
p graph.count_short_way_between_nodes(1, 7)
