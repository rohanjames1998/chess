require_relative 'movement'

class Rook


  attr_reader :unicode, :color
  include Movement

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2656"
    @color = 'white'
  end

  def black
    @unicode = "\u265c"
    @color = 'black'
  end

  def generate_potential_moves(initial_loc, board)
    potential_moves = []
    generate_left_moves(initial_loc, board, color) { |move| potential_moves << move }
    generate_right_moves(initial_loc, board, color) { |move| potential_moves << move }
    generate_up_moves(initial_loc, board, color) { |move| potential_moves << move }
    generate_down_moves(initial_loc, board, color) { |move| potential_moves << move }
    potential_moves
  end
end
