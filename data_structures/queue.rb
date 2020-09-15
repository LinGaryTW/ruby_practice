class Queue
  class Node
    attr_accessor :next_node, :value
    def initialize
      @next_node = nil
    end
  end

  attr_accessor :head, :length, :tail
  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def enqueue(value) # always append node
    node = Node.new(value)
    if head.nil?
      self.head = node
    else
      self.tail.next_node = node
    end
    self.tail = node
    length += 1
  end

  def dequeue # always get first node
    return if length.zero?
    self.head = self.head.next_node
    self.tail = nil if length == 1
    length -=1
  end
end