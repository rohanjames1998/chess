require_relative "board"

class Pawn

  attr_reader :unicode

  def initialize
    @unicode = ''
    @first_move = true
  end

  def white
    @unicode = "\u2659"
  end

  def black
    @unicode = "\u265f"
  end

  def generate_possible_moves(initial_loc, board)
    # Since this method is hard coded and relies on other method for its main work
    # We won't test it. Instead we will test #check_valid_move.
    pawn = board[initial_location]
    # converting both row and col to integers so we can increase or decrease them.
    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    normal_moves = []
    kill_moves = []

    if @first_move?
      normal_moves << (row + 2).to_s + col.chr
      normal_moves << (row + 1).to_s + col.chr
      kill_moves << (row + 1).to_s + (col + 1).chr
      kill_moves << (row + 1).to_s + (col - 1).chr
    else
      normal_moves << (row + 1).to_s + col.chr
      kill_moves << (row + 1).to_s + (col + 1).chr
      kill_moves << (row + 1).to_s + (col - 1).chr
    end

    possible_moves = check_valid_move(normal_moves, kill_moves, board)
    return possible_moves
  end


end
