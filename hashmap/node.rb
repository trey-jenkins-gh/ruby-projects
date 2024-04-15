class Node
  attr_accessor :key, :value, :next, :prev

  def initialize(key, value, following=nil, prev=nil)
    @key = key
    @value = value
    @next = following
    @prev = prev
  end

end
