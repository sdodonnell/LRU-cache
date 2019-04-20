class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove      
    if !@next && @prev
      @prev.next = nil
    else 
      @prev.next = @next
      @next.prev = @prev
    end
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail, :size

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @size = 2
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if self.head.next == self.tail
      nil
    else
      self.head.next
    end
  end

  def last
    if self.tail.prev == self.head
      nil
    else
      self.tail.prev
    end
  end

  def empty?
    self.size > 2
  end

  def get(key)
    # node = self.head
    # until node.key == key || node.next == nil
    #   node = node.next
    # end
    # node.val
  end

  def include?(key)
    node = self.head
    until node.next == self.tail
      if node.key == key
        return true
      end
      node = node.next
    end
    return false
  end

  def append(key, val)
    curr_node = self.head.next

    if !curr_node.val || val < curr_node.val
      curr_node.next = Node.new(key, val)
      curr_node.next.next = curr_node
      return
    end
    
    until !curr_node.val || val < curr_node.val
      curr_node = curr_node.next
    end

    curr_node.next = Node.new(key, val)
    curr_node.next.next = curr_node
  end

  def update(key, val)
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
