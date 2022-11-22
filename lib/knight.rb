require_relative 'board'
require_relative 'movement'
class Knight

attr_reader :unicode, :color
include Movement

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2658"
    @color = 'white'
  end

  def black
    @unicode = "\u265e"
    @color = 'black'
  end

  def generate_potential_moves(initial_loc, board)
    all_moves = generate_knight_moves(initial_loc)
    potential_moves = check_valid_moves(all_moves, board)
    potential_moves
  end

  def check_valid_moves(all_moves, board)
    valid_moves = []
    all_moves.each do |move|
      piece = board[move]
      case
      when piece == nil # For moves outside the board
        next
      when piece == "" # For empty places
        valid_moves << move
        next
      when piece.color != color # For enemy pieces
        valid_moves << move
        next
      else # For ally pieces
        break
      end
    end
    valid_moves
  end
end
