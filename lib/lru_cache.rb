require_relative 'hash_map'
require_relative 'linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.get(key)
      node = @map.get(key)
      update_node!(node)
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map[key] = @store.append(key, val)

    eject! if count > @max
    val
  end

  def update_node!(node)
    node.remove
    @map[node.key] = @store.append(node.key, node.val)
    node.val
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
    nil
  end
end
