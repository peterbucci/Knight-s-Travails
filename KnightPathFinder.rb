require_relative 'PolyTreeNode'

class KnightPathFinder
  def self.valid_moves(pos)
    row, column = pos
    directions = [[2, -1], [1, -2], [2, 1], [1, 2], [-2, -1], [-1, -2], [-2, 1], [-1, 2]]
    possible_moves = []

    directions.each do |direction|
      current_move = [row + direction[0], column + direction[1]]
      possible_moves << current_move unless current_move.any? { |n| n < 1 || n >  7}
    end

    possible_moves
  end

  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    @considered_positions = [start_pos]
    @tree = build_move_tree(@root_node)
  end

  def build_move_tree(start)
    queue = [start]
    move_tree = []

    until queue.empty?
      parent = queue.shift
      move_tree << parent

      children = new_move_positions(parent.value)
      children.each do |pos|
        child = PolyTreeNode.new(pos)
        parent.add_child(child)
        child.parent = parent
        queue << child
      end
    end

    move_tree
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move) }
    @considered_positions += new_moves

    new_moves
  end

  def find_path(end_pos)
    path = []
    current_pos = @root_node.bfs(end_pos)

    while current_pos
      path.unshift(current_pos.value)
      current_pos = current_pos.parent
    end

    path
  end
end

pathfinder = KnightPathFinder.new([0,0])
p pathfinder.find_path([3,2])