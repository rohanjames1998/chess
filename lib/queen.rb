require_relative 'board'
require_relative 'movement'
class Queen

  attr_reader :unicode, :color
  include Movement

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2655"
    @color = 'white'
  end

  def black
    @unicode = "\u265b"
    @color = 'black'
  end

  def generate_potential_moves(initial_loc, board)
    potential_moves = []
    potential_moves << generate_up_moves(initial_loc, board)
    potential_moves << generate_up_right_moves(initial_loc, board)
    potential_moves << generate_up_left_moves(initial_loc, board)
    potential_moves << generate_right_moves(initial_loc, board)
    potential_moves << generate_down_moves(initial_loc, board)
    potential_moves << generate_down_right_moves(initial_loc, board)
    potential_moves << generate_down_left_moves(initial_loc, board)
    potential_moves << generate_left_moves(initial_loc, board)

    potential_moves
  end
end
