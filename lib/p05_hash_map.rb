require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = @store[key.hash % num_buckets]
    list.include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    list = @store[key.hash % num_buckets]
    if !list.include?(key)
      list.append(key, val)
      @count += 1
    else
      list.update(key, val)
    end
  end

  def get(key)
    list = @store[key.hash % num_buckets]
    list.get(key)
  end

  def delete(key)
    list = @store[key.hash % num_buckets]
    if list.include?(key)
      list.remove(key)
      @count -= 1
    end
    
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call([node.key, node.val])
      end
    end

  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    prev = @store
    @store = Array.new(prev.length * 2) { LinkedList.new }
    prev.each do |list|
      list.each {|node| @store[node.key.hash % num_buckets].append(node.key, node.val) }
    end
  end
  
  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
