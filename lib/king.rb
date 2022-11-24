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
    all_moves = generate_king_moves(initial_loc, board)
    potential_moves = check_valid_moves(all_moves, board)
    potential_moves
  end

  def check_valid_moves(all_moves, board)
    potential_moves = []
    all_moves.each do |move|
      potential_moves << move if clear?(move, board)
    end
    potential_moves
  end

  def clear?(move, board)
    # This method checks if the location is threatened by an enemy piece
    # Returns true if there is no threat; returns false if there is a threat.
    case
    when diagonal_threat?(move, board)
      return false
    when vertical_threat?(move, board)
      return false
    when horizontal_threat?(move, board)
      return false
    when knight_threat?(move, board)
      return false
    when king_threat?(move, board, color)
      return false
    when pawn_threat?(move, board)
      return false
    else
      return true
    end
  end

end
