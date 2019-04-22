require_relative 'linked_list'

class HashMap
  include Enumerable

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if count >= num_buckets

    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    self.count -= 1
  end

  def each(&blk)
    @store.each do |bucket| 
      bucket.each {|el| yield(el.key, el.val)}
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    self.store = Array.new(num_buckets * 2) { LinkedList.new }
    self.count = 0

    old_store.each do |bucket|
      bucket.each {|el| self.set(el.key, el.val)}
    end
  end

  def bucket(key)
    self.store[key.hash % num_buckets]
  end
end
