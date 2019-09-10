require_relative 'PolyTreeNode'

class KnightPathFinder
  def self.valid_moves(pos)
    row, column = pos
    directions = [[2, -1], [1, -2], [2, 1], [1, 2], [-2, -1], [-1, -2], [-2, 1], [-1, 2]]
    possible_moves = []

    directions.each do |direction|
      current_move = [row + direction[0], column + direction[1]]
      possible_moves << current_move unless current_move.any? { |n| n < 1 }
    end

    possible_moves
  end

  def initialize(start_pos)
    @start = start_pos
    @root_node = PolyTreeNode.new(@start)
    @considered_positions = [@start]

  end

  def build_move_tree
    move_tree = [@start]

  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move) }
    @considered_positions += new_moves

    new_moves
  end

  def find_path(end_pos)
  end
end

p KnightPathFinder.valid_moves([0,0])

pathfinder = KnightPathFinder.new([0,0])
p pathfinder