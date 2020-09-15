class Node
  attr_reader :value
  attr_accessor :left, :right
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def pushNode(node, value)
  if value > node.value
    if node.right
      pushNode(node.right, value)
    else
      node.right = Node.new(value)
    end
  else
    if node.left
      pushNode(node.left, value)
    else
      node.left = Node.new(value)
    end
  end
end

def traverse(node)
  return if node == nil
  traverse(node.right)
  puts node.value
  traverse(node.left)
end

def breadth_first_traverse(node)
  queue = []
  output = []
  queue.push(node)
  while !queue.empty?
    current = queue.shift
    queue.push(current.left) if current.left
    queue.push(current.right) if current.right
    output.push(current.value)
  end

  puts "Breadth-first traversal:"
  puts output.join(" ")
end

def breadth_first_traverse_with_empty_node(node)
  queue = []
  output = []
  queue.push(node)
  while !queue.select { |e| e != 'nil' }.empty?
    current = queue.shift
    if current == 'nil'
      2.times { queue.push(current) }
      output.push(current)
      next  
    end
    if current.left
      queue.push(current.left)
    else
      queue.push('nil')
    end
    if current.right
      queue.push(current.right)
    else
      queue.push('nil')
    end
    output.push(current.value)
  end
  return output
end

def add_depth(node_array)
  length = 1
  result = []
  node_array = node_array
  until node_array.empty?
    level = node_array.slice!(0, length)
    result << level
    length = length * 2
  end
  return result
end

# expect with depth
# [[5], 
# [2, 6], 
# [1, 4, "nil", 8], 
# ["nil", "nil", 3, "nil", "nil", "nil", 7, 9]]


arr = [5,6,2,4,1,8,7,9,3];
root = Node.new(arr.shift);
arr.each{|e| pushNode(root, e) }

traverse(root)
puts '======='
breadth_first_traverse(root)
puts '======='
p breadth_first_traverse_with_empty_node(root)
puts '-------'
p add_depth(breadth_first_traverse_with_empty_node(root))