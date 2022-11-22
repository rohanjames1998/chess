require_relative 'movement'
class King

  attr_reader :unicode, :color
  include Movement

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2654"
    @color = 'white'
  end

  def black
    @unicode = "\u265a"
    @color ='black'
  end

  def generate_potential_moves(initial_loc, board)
    all_moves = generate_king_moves(initial_loc)
    potential_moves = check_valid_moves(all_moves, board)
    potential_moves
  end

  def check_valid_moves(all_moves, board)
    potential_moves = []
    all_moves.each do |move|
      potential_moves << move if clear?(move)
    end
    potential_moves
  end

  def clear?(move)
  end

end
