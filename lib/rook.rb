class Rook
  attr_reader :unicode, :color

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

  def generate_possible_moves(initial_loc, board)
    possible_moves = []
    possible_moves << generate_left_moves(initial_loc, board)
    possible_moves << generate_right_moves(initial_loc, board)
    possible_moves << generate_up_moves(initial_loc, board)
    possible_moves << generate_down_moves(initial_loc, board)
    possible_moves
  end

  def generate_left_moves(initial_loc, board)
    # Since we will only manipulate col there is no need to convert
    # row into an integer.
    row = initial_loc[0]
    col = initial_loc[1].ord - 97
    possible_left_moves = []

    while col > 0
      col -= 1
      possible_move = row + (col + 97).chr
      case
      when board[possible_move] == "" # For empty location
        possible_left_moves << possible_move
        next
      when board[possible_move].color != color # For enemy piece
        possible_left_moves << possible_move
        break
      else # For ally piece
        break
      end
    end
    possible_left_moves
  end

  def generate_right_moves(initial_loc, board)
    row = initial_loc[0]
    col = initial_loc[1].ord - 97
    possible_right_moves = []

    while col < 7
      col += 1
      possible_move = row + (col + 97).chr
      case
      when board[possible_move] == "" # For empty location
        possible_right_moves << possible_move
        next
      when board[possible_move].color != color # For enemy piece
        possible_right_moves << possible_move
        break
      else # For ally piece
        break
      end
    end
    possible_right_moves
  end

  def generate_up_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    possible_top_moves = []

    while row < 8
      row += 1
      possible_move = row.to_s + col

      case
      when board[possible_move] == ""
        possible_top_moves << possible_move
        next
      when board[possible_move].color != color
        possible_top_moves << possible_move
        break
      else
        break
      end
    end
    possible_top_moves
  end

  def generate_down_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    possible_down_moves = []

    while row > 1
      row -= 1
      possible_move = row.to_s + col

      case
      when board[possible_move] == ""
        possible_down_moves << possible_move
        next
      when board[possible_move].color != color
        possible_down_moves << possible_move
        break
      else
        break
      end
    end
    possible_down_moves
  end
end
