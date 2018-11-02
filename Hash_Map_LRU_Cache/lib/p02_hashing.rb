class Fixnum
  # Fixnum#hash already implemented for you
  def my_hash
    self.to_s(2).to_i
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |char, idx|
      result += char.ord * (idx + 1)
    end
    result
  end
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      result += el.ord * (idx + 1)
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.each do |key, value|
      result += key.hash * value.hash
    end
    result
  end
end
