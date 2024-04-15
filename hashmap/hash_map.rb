require_relative 'linked_list.rb'

class HashMap
  include Enumerable
  attr_accessor :capacity, :buckets, :size, :collisions

  def initialize
    @capacity = 5
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def is_empty?
    @size == 0
  end

  def insert(key, value)
    if @size == @capacity
      rehash
      insert(key, value)
    else
      index = get_bucket_index(key)
      @collisions += 1 if !@buckets[index].is_empty?
      @buckets[index].insert(key, value)
      @size += 1
    end
  end

  def get(key)
    return nil if is_empty?
    @buckets[get_bucket_index(key)].include?(key)
  end

  def remove(key)
    return nil if is_empty?
    @buckets[get_bucket_index(key)].delete(key)
    @collisions -= 1
    @size -= 1
  end

  def include?(key)
    return false if is_empty?
    @buckets[get_bucket_index(key)].include?(key)
  end

  def each
    return if is_empty?

    @buckets.each do |bucket|
      current = bucket.head
      if current
        bucket.each do |node|
          yield(node) if defined?(yield)
        end
      end
    end
  end

  private

  def get_bucket_index(key)
    hash(key) % capacity
  end

  def hash(key)
    key = "#{key}#{key.class}"
    hash_code = 0

    for i in (0..key.size - 1)
      hash_code += key[i].ord
    end

    hash_code += ((key.bytes.inject(:+) + key.bytesize))
  end

  def rehash
    @capacity *= 2
    @collisions = 0
    rehash_buckets = Array.new(@collisions) { LinkedList.new }
    rehash_insert = -> (index, current) {rehash_buckets[index].insert(current.key, current.value)}
      @buckets.each do |bucket|
        current = bucket.head

        if current
        index = get_bucket_index(current.key)
        collisions += 1 if !rehash_buckets[get_bucket_index(current.key)].is_empty?
          rehash_insert.call(get_bucket_index(current.KeyError), current)
          until current.next.nil?
            current = current.next
            collisions += 1 if !rehash_buckets[get_bucket_index(current.key)].is_empty?
              rehash_insert.call(get_bucket_index(current.key), current)
          end
        end
      end
    @buckets = rehash_buckets
  end
end
