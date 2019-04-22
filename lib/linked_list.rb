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

  attr_reader :head, :tail
  attr_accessor :size

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @size = 0
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
    self.size == 0
  end

  def get(key)
    node = self.head
    until node.key == key || node.next == nil
      node = node.next
    end
    node.val
  end

  def include?(key)
    node = self.head
    until !node.next
      if node.key == key
        return true
      end
      node = node.next
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    self.tail.prev.next = new_node
    new_node.prev = self.tail.prev
    new_node.next = self.tail
    self.tail.prev = new_node

    self.size += 1

    new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    return if self.empty?

    curr_node = self.head.next

    until curr_node.key == key || !curr_node.next
      curr_node = curr_node.next
    end

    if curr_node.key
      curr_node.prev.next = curr_node.next
      curr_node.next.prev = curr_node.prev
    end

  end

  def each(&blk)
    return if self.empty? 

    curr_node = self.head.next
    until !curr_node.next
      yield(curr_node)
      curr_node = curr_node.next
    end

  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
