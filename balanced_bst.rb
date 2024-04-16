class Tree

  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort.uniq!
    @root = build_tree(@array)
  end

  def build_tree(array=@array, start=0, last=array.length-1)

    mid = (start + last) / 2

    if start > last
      nil
    else
      root = Node.new(array[mid])
      root.left_child = build_tree(array, start, mid-1)
      root.right_child = build_tree(array, mid+1, last)
    end
  root
  end

  def insert(value, node)
    if value < node.data
      if !node.left_child
        node.left_child = Node.new(value)
      else
        insert(value, node.left_child)
      end
    elsif value > node.data
      if !node.right_child
        node.right_child = Node.new(value)
      else
        insert(value, node.right_child)
      end
    end
  end

  def new_node(node, x, *args)
    return @root = Node.new(x, *args) if @root.nil?
    return Node.new(x, *args) if node.nil?
    return node if node.x == x

    if x < node.x
      if node.west.nil?
        node.west = new_node(node.west, x, *args)
      else
        new_node(node.west, x, *args)
      end
    elsif node.east.nil?
      node.east = new_node(node.east, x, *args)
    else
      new_node(node.east, x, *args)
    end
  end

  # Create a new node and balance the tree
  def new_node_balanced(node, x, *args)
    new_node(node, x, *args)
    balance unless balanced?
  end

  def search(value, node)
    if !node || node.data == value
      return node
    elsif value < node.data
      return search(value, node.left_child)
    else
      return search(value, node.right_child)
    end
  end

  def search_depth(value, node, level=0)
    if !node || node.data == value
      return level
    elsif value < node.data
      return search(value, node.left_child, level + 1)
    else
      return search(value, node.right_child, level + 1)
    end
  end

  def delete(value, node)
    #find the value node(nil if not found)
    if !node
      return nil
    elsif value < node.data
      node.left_child = delete(value, node.left_child)
      return node
    elsif value > node.date
      node.right_child = delete(value, node.right_child)
      return node
    elsif value == node.data
      if !node.left_child
        return node.right_child
      elsif !node.right_child
        return node.left_child
      else
        node.right_child = lift(node.right_child, node)
      end
    end
  end

  def lift(node, node_to_delete)
    if node.left_child
      node.left_child = lift(node.left_child, node_to_delete)
      return node
    else
      node_to_delete.data = node.data
      return node.right_child
    end
  end

  def level_preorder(node) #preorder
    if !node
      return
    end
    print node.data
    level_order(node.left_child)
    level_order(node.right_child)
  end

  def level_postorder(node) #preorder
    if !node
      return
    end
    level_order(node.left_child)
    level_order(node.right_child)
    print node.data
  end

  def level_inorder(node) #inorder
    if !node
      return
    end
    level_order(node.left_child)
    print node.data
    level_order(node.right_child)
  end

  def get_depth(node=@root, depth=1, max=0)
    max = get_depth(node.right_child, depth + 1, max) unless !node.right_child
    max = get_depth(node.left_child, depth + 1, max) unless !node.left_child
    max = depth if node.right_child.nil? && node.left_child.nil? && depth > max
    return max
  end

  def number_nodes(node = @root)
    node.nil? ? 0 : 1 + number_nodes(node.right_child) + number_nodes(node.left_child)
  end

  def balanced?
    number_nodes.between?(2**(get_depth - 1), 2**get_depth)
  end

  def get_all_nodes(nodes, node = @root)
    nodes = get_all_nodes(nodes, node.right_child) unless !node.right_child
    nodes << node
    nodes = get_all_nodes(nodes, node.left_child) unless !node.left_child
    return nodes
  end

  def new_balance_nodes(nodes, newroot = @root)
    # p nodes
    return if nodes.empty?
    new_node(newroot, nodes[nodes.length / 2].x, *nodes[nodes.length / 2].args)
    return if nodes.length == 1
    new_balance_nodes(nodes[0..(nodes.length / 2) - 1], @root)
    new_balance_nodes(nodes[(nodes.length / 2) + 1..-1], @root)
  end

  def balance
    unless balanced?
      nodes = get_all_nodes([])
      @root = nil
      new_balance_nodes(nodes, @root)
    end
  end



  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

class Node
  attr_accessor :data, :right_child, :left_child

  def initialize(data, right_child=nil, left_child=nil)
    @data = data
    @right_child = right_child
    @left_child = left_child
  end
end
