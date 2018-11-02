class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num >= @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }

  end

  def insert(num)
    @store[bucket_num(num)] << num
  end

  def remove(num)
    @store[bucket_num(num)].delete(num)
  end

  def include?(num)
    @store[bucket_num(num)].include?(num)
  end

  private

  def bucket_num(num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count + 1 > num_buckets
    unless @store[bucket_num(num)].include?(num)
      @count += 1
      @store[bucket_num(num)] << num
    end
  end

  def remove(num)
    if @store[bucket_num(num)].include?(num)
      @store[bucket_num(num)].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[bucket_num(num)].each do |el|
      return true if el == num
    end
    false
  end

  private

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
      bucket.each do |el|
        @store[bucket_num(el)] << el
      end
    end
  end
end
