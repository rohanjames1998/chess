require_relative "movement"
require_relative "board"

class Pawn
  attr_reader :unicode, :color

  include Movement

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

  def generate_potential_moves(initial_loc, board)
    if self.color == 'white'
      all_possible_moves = generate_white_pawn_moves(initial_loc, @first_move)
    else
      all_possible_moves = generate_black_pawn_moves(initial_loc, @first_move)
    end
    first_move_check
    potential_moves = check_valid_moves(all_possible_moves, board)
    potential_moves
  end

  def check_valid_moves(all_possible_moves, board)
    potential_moves = []
    normal_moves = all_possible_moves[0]
    kill_moves = all_possible_moves[1]

    if normal_moves.length > 0
      normal_moves.each do |move|
        potential_moves << move if board[move] == ''
      end
    end

    if kill_moves.length > 0
      kill_moves.each do |move|
        # assigning the piece on board to a variable
        piece = board[move]
        if piece != ''
          potential_moves << move if piece.color != color
        end
      end
    end
    potential_moves
  end

  def first_move_check
    # Changing @first_move to false if it is true.
    if @first_move
      @first_move = false
    end
  end
end
