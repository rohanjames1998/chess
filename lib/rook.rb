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
    potential_moves << generate_left_moves(initial_loc, board)
    potential_moves << generate_right_moves(initial_loc, board)
    potential_moves << generate_up_moves(initial_loc, board)
    potential_moves << generate_down_moves(initial_loc, board)
    potential_moves
  end

  def generate_left_moves(initial_loc, board)
    # Since we will only manipulate col there is no need to convert
    # row into an integer.
    row = initial_loc[0]
    col = initial_loc[1].ord - 97 # - 97 because 97 is ord for small 'a'
    potential_left_moves = []

    while col > 0
      col -= 1
      potential_move = row + (col + 97).chr
      case
      when board[potential_move] == "" # For empty location
        potential_left_moves << potential_move
        next
      when board[potential_move].color != color # For enemy piece
        potential_left_moves << potential_move
        break
      else # For ally piece
        break
      end
    end
    potential_left_moves
  end

  def generate_right_moves(initial_loc, board)
    row = initial_loc[0]
    col = initial_loc[1].ord - 97
    potential_right_moves = []

    while col < 7
      col += 1
      potential_move = row + (col + 97).chr
      case
      when board[potential_move] == "" # For empty location
        potential_right_moves << potential_move
        next
      when board[potential_move].color != color # For enemy piece
        potential_right_moves << potential_move
        break
      else # For ally piece
        break
      end
    end
    potential_right_moves
  end

  def generate_up_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    potential_top_moves = []

    while row < 8
      row += 1
      potential_move = row.to_s + col

      case
      when board[potential_move] == ""
        potential_top_moves << potential_move
        next
      when board[potential_move].color != color
        potential_top_moves << potential_move
        break
      else
        break
      end
    end
    potential_top_moves
  end

  def generate_down_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    potential_down_moves = []

    while row > 1
      row -= 1
      potential_move = row.to_s + col

      case
      when board[potential_move] == ""
        potential_down_moves << potential_move
        next
      when board[potential_move].color != color
        potential_down_moves << potential_move
        break
      else
        break
      end
    end
    potential_down_moves
  end
end
