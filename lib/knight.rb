require_relative 'board'
class Knight

attr_reader :unicode, :color

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

  def generate_possible_moves(initial_loc, board)
    # Since this method is hard coded and most of its work is done
    # by #check_valid_move we are not going to test this method.
    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    all_moves = []
    all_moves << (row + 2).to_s + (col - 1).chr #up-up-left
    all_moves << (row + 2).to_s + (col + 1).chr #up-up-right
    all_moves << (row - 2).to_s + (col - 1).chr #down-down-left
    all_moves << (row - 2).to_s + (col + 1).chr #down-down-right
    all_moves << (row + 1).to_s + (col + 2).chr #right-right-up
    all_moves << (row + 1).to_s + (col - 2).chr #left-left-up
    all_moves << (row - 1).to_s + (col + 2).chr #right-right-down
    all_moves << (row - 1).to_s + (col - 2).chr #left-left-down

    possible_moves = check_valid_moves(all_moves, board)
    possible_moves
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
        next
      end
    end
    valid_moves
  end
end
