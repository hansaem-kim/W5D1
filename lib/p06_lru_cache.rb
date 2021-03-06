require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

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
    if @map.include?(key)

      update_node!
    else
      eject!
      calc!(key)

    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    node = @store.append(key, val)
    @map[key] = node
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(key)
    node = @map.get(key)
    @store.remove(node.key)
    @store.append(node.key, node.val)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    firstkey = @store[0].key
    @store.remove(firstkey)
    @map.delete(firstkey)
    # return to-update node
  end
end
