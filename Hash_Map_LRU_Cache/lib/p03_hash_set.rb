class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count + 1 > num_buckets

    value = key.hash
    unless @store[bucket_num(value)].include?(value)
      @count += 1
      @store[bucket_num(value)] << [key, value]
    end
  end

  def include?(key)
    value = key.hash
    @store[bucket_num(value)].each do |el|
      return true if el == [key, value]
    end
    false
  end

  def remove(key)
    value = key.hash
    if @store[bucket_num(value)].include?([key, value])
      @store[bucket_num(value)].delete([key, value])
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def bucket_num(num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    old_store.each do |bucket|
      bucket.each do |key, value|
        @store[bucket_num(value)] << [key, value]
      end
    end
  end
end
