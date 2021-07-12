require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
    @hash = Hash.new
  end

  def count
    @map.count
  end

  def get(key)
    if @hash.key?(key)
      node = @hash[key]
      node.remove
    else
      node = Node.new(key, @prc.call(key))
      @hash[key] = node
      if @hash.length > @max
        toRemove = @store.head.next
        @hash.delete(toRemove.key)
        toRemove.remove
      end
    end

    #append
    prevTail = @store.tail.prev
    prevTail.next = node
    node.prev = prevTail
    node.next = @store.tail
    @store.tail.prev = node

    node.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(key)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    # return to-update node
  end
end
