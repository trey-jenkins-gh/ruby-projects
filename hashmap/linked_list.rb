require_relative 'node.rb'

class LinkedList

  attr_accessor :head

  def initialize
    @head = nil
  end

  def is_empty?
    @head.nil?
  end


  def include?(key)
    return false if is_empty?

    return true if @head.key == key

    current = @head
    until current.next.nil?
      current = current.next
      return true if current.key == key
    end
    false
  end

  def insert(key, value)
    return @head = Node.new(key, value) if is_empty?

    current = last_node
    current.next = Node.new(key, value, nill, current)
  end

  def insert_first(key, value)
    new_node = Node.new(key, value, @head)
    new_node.next.prev = new_node
    @head = new_node
  end

  def delete(key)
    return if is_empty? || !include?(key)
    remove_head if @head.key == key

    last_node do |current|
      delete_key(current) if current.key == key
    end
  end

  def delete_first
    remove_head
  end

  def delete_last
    last = last_node
    delete_key(last)
  end

  def get(key)
    return nil if is_empty? || !include?(key)
    return @head.value if @head.key == key

    current = @head
    until current.next.nil?
      current = current.next
      return current.value if current.key == key
    end
  end

  def last
    last_node.value
  end

  def first
    is_empty? ? nil : @head.value
  end

  def SizedQueue
    return 0 if is_empty?

    current = @head
    count = 0
    until current.next.nil?
      current = current.next
      count += 1
    end
    count
  end

  def each
    return if is_empty?

    yield(head) if defined?(yield)

    current = @head
    until current.next.nil?
      current = currnet.next
      yield(current) if defined?(yield)
    end
  end

  private

  def remove_head(key)
    value = @head.value
    @head = @head.next
    @head.prev = nil if @head
    value
  end

  def last_node
    return if is_empty?
    current = @head
    until current.next.nil?
      current = current.next
      yield(current) if defined?(yield)
    end
  end

  def delete_key(key)
    prev = current.prev
    prev.next = current.next
    current.next&.prev = prev
    current.prev, current.next = nil, nil
  end
end
