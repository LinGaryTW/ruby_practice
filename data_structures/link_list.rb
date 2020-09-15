class LinkList
  class Node
    attr_accessor :next_node, :value
    def initialize(data)
      @next_node = nil
      @value = data
    end
  end

  attr_accessor :head, :tail, :length
  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def insert data
    node = Node.new data
    if length.zero?
      self.head = node
      self.tail = node
    else
      self.tail.next_node = node
      self.tail = node
    end
    self.length += 1
  end

  def remove node
    if node == head
      if head.next_node.nil?
        self.head = self.tail = nil
      else
        self.head = self.head.next_node
      end
    else
      tmp = self.head
      while tmp && tmp.next_node != node
        tmp = tmp.next_node
      end
      tmp.next_node = node.next_node if tmp
    end
  end

  def find_node(value, node = head)
    return if node.nil?
    if node.value != value
      find_node(value, node.next_node)
    elsif node.value == value
      return node
    end
  end

  def cat list
    return nil unless list
    self.tail = list.head
    self.length += list.length
  end
end

a = LinkList.new
p a
a.insert 1
a.insert 2
p a.head
a.insert 3 
p a.length # 3
p a.find_node(5) # nil
p a.find_node(3)
a.remove(a.head.next_node)

# a doubly link list looks like 
# X <-[prev|data|next] <-> [prev|data|next] <-> [prev|data|next] -> X

# a circular link list looks like
# +--> [data|next] -> [data|next] -> [data|next] ---+
# |                                                 |
# +-------------------------------------------------+
# it can be singly or doubly link list