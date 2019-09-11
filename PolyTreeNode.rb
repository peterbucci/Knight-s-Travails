class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    ## If a parent node exists, then we're reassigning the parent
    ## We need to delete the current node from the parent's @children array.
    @parent.children.delete(self) if @parent
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    @children.include?(node) ? node.parent = nil : (raise "The node passed into remove_child is not a child of the current node.")
  end

  def dfs(target)
    if @value == target 
      return self
    else 
      @children.each do |child|
        node = child.dfs(target)
        return node if (node && node.value == target)
      end
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue += current_node.children
    end
    nil
  end
end