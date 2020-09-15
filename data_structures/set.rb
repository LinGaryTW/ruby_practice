class Set
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
      return nil if node.nil?
      if value == node.value
        return node
      else
        find_node(value, node.point)
      end
    end
  
    def cat list
      return nil unless list
      self.tail = list.head
      self.length += list.length
    end

    def each
      return nil unless block_given?
  
      current = self.head
      while current
        yield current
        current = current.next
      end
    end
  end

  attr_accessor :count
  def initialize
    @list = LinkedList.new
    @count = @list.length
  end

  def insert(data)
    return if contains?(data)
    @list.insert(data)
  end

  def contains?(node_value)
    @list.find_node(node_value)
  end

  def remove node
    node = find_node(node)
    @list.remove(node) if node
  end

  def union other_list
    res = Set.new
    @list.each { |node| res.insert(node.value) }
    other_list.each { |node| res.insert(node.value) }
    
    res
  end

  def intersect(other_list)
    res = Set.new
    @list.each do |node|
      res.insert(node.value) if other_list.contains?(node.value)
    end

    res
  end

  def diff(other_list)
    res = Set.new
    @list.each do |node|
      res.insert(node.value) unless other_list.contains?(node.value)
    end

    res
  end

  def subset?(other_set)
    return false if self.count > other_set.count

    @list.each do |node|
      return false unless other_set.contains?(node.value)
    end

    true
  end

  def equal?(other_set)
    return false if self.count != other_set.count
    subset?(other_set)
  end
end