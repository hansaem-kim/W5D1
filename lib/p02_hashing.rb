class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    num = 0
    self.each.with_index do |ele, index|
      num += ele.hash ^ index
    end
    num.hash
  end
end

class String
  def hash
    num = 0
    self.each_char.with_index {|char , index| num += char.ord ^ index}
    num.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = 0
    self.each {|key, value| num += key.hash ^ value.hash}
    num
  end
end
