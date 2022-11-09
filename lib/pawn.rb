# require_relative "board"

class Pawn
  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @first_move = true
    @color = ''
  end

  def white
    @unicode = "\u2659"
    @color = 'white'
  end

  def black
    @unicode = "\u265f"
    @color = 'black'
  end

  def generate_possible_moves(initial_loc, board)
    # Since this method is hard coded and relies on other method for its main work
    # we won't test it. Instead we will test #check_valid_move.
    # converting both row and col to integers so we can increase or decrease them.
    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    normal_moves = []
    kill_moves = []

    if @first_move
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

  def check_valid_moves(normal_moves, kill_moves, board)
    possible_moves = []
    if normal_moves.length > 0
      normal_moves.each do |move|
        possible_moves << move if board[move] == ''
      end
    end

    if kill_moves.length > 0
      kill_moves.each do |move|
        # assigning the element at location to a variable
        ele = board[move]
        if ele != ''
          possible_moves << move if ele.color != color
        end
      end
    end
    possible_moves
  end
end
