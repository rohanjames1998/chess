require_relative 'board'
require_relative 'movement'
class Bishop

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2657"
    @color = 'white'
  end

  def black
    @unicode = "\u265d"
    @color = 'black'
  end

  def generate_potential_moves(initial_loc, board)
    potential_moves = []

    potential_moves << generate_top_right_moves(initial_loc, board)
    potential_moves << generate_top_left_moves(initial_loc, board)
    potential_moves << generate_down_right_moves(initial_loc, board)
    potential_moves << generate_down_left_moves(initial_loc, board)

    potential_moves
  end
end
