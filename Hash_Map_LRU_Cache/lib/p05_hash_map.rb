require_relative 'p04_linked_list'

class HashMap < LinkedList
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)

    self[key].each do |node|
      return true if node.key == key
    end
    false
  end

  def set(key, val)
    # bucket_num = key.hash % num_buckets
    @count += 1 unless self.include?(key)
    self[key].append(key, val)
  end

  def get(key)
  end

  def delete(key)
    # bucket_num = key.hash % num_buckets
    self[key].each do |node|
      node.remove(key) if node.include?(key)
    end
  end

  def each
    current_node = self.head
    until current_node == self.tail.prev
      next_node = current_node.next
      yield [next_node.key, next_node.val]
      current_node = next_node
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

  def [](key)
    key.hash % num_buckets
  end

  def []=(key) # hash[key] = value

  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |bucket|
      bucket.each do |key, value|
        hash_key = key.hash
        @store[hash_key].append(Node.new(key, val))
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
