require_relative 'board'
class Queen
  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2655"
    @color = 'white'
  end

  def black
    @unicode = "\u265b"
    @color = 'black'
  end

  def generate_possible_moves(initial_loc, board)
    possible_moves = []
    possible_moves << generate_up_moves(initial_loc, board)
    possible_moves << generate_up_right_moves(initial_loc, board)
    possible_moves << generate_up_left_moves(initial_loc, board)
    possible_moves << generate_right_moves(initial_loc, board)
    possible_moves << generate_down_moves(initial_loc, board)
    possible_moves << generate_down_right_moves(initial_loc, board)
    possible_moves << generate_down_left_moves(initial_loc, board)
    possible_moves << generate_left_moves(initial_loc, board)

    possible_moves
  end

  def generate_up_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    valid_moves = []

    while row < 8
      row += 1
      possible_move = row.to_s + col

      case
      when board[possible_move] == "" # For empty locations.
        valid_moves << possible_move
        next
      when board[possible_move].color != color # For enemy pieces.
        valid_moves << possible_move
        break
      else # For ally pieces.
        break
      end
    end
    valid_moves
  end

  def generate_up_right_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row < 8 && col < 7
      row += 1
      col += 1
      # Converting col back to alphabet by adding 97.
      possible_move = row.to_s + (col + 97).chr
      piece = board[possible_move]
      case
      when piece == '' # For empty location.
        valid_moves << possible_move
      when piece.color != color # For enemy piece.
        valid_moves << possible_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_up_left_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row < 8 && col > 0
      row += 1
      col -= 1
      # Converting col back to alphabet by adding 97.
      possible_move = row.to_s + (col + 97).chr
      piece = board[possible_move]
      case
      when piece == '' # For empty location.
        valid_moves << possible_move
      when piece.color != color # For enemy piece.
        valid_moves << possible_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_right_moves(initial_loc, board)
    row = initial_loc[0]
    col = initial_loc[1].ord - 97
    valid_moves = []

    while col < 7
      col += 1
      possible_move = row + (col + 97).chr
      case
      when board[possible_move] == "" # For empty location
        valid_moves << possible_move
        next
      when board[possible_move].color != color # For enemy piece
        valid_moves << possible_move
        break
      else # For ally piece
        break
      end
    end
    valid_moves
  end

  def generate_down_moves(initial_loc, board)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    valid_moves = []

    while row > 1
      row -= 1
      possible_move = row.to_s + col

      case
      when board[possible_move] == ""
        valid_moves << possible_move
        next
      when board[possible_move].color != color
        valid_moves << possible_move
        break
      else
        break
      end
    end
    valid_moves
  end

  def generate_down_right_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row > 1 && col < 7
      row -= 1
      col += 1
      # Converting col back to alphabet by adding 97.
      possible_move = row.to_s + (col + 97).chr
      piece = board[possible_move]
      case
      when piece == '' # For empty location.
        valid_moves << possible_move
      when piece.color != color # For enemy piece.
        valid_moves << possible_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_down_left_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row >= 0 && col > 0
      row -= 1
      col -= 1
      # Converting col back to alphabet by adding 97.
      possible_move = row.to_s + (col + 97).chr
      piece = board[possible_move]
      case
      when piece == '' # For empty location.
        valid_moves << possible_move
      when piece.color != color # For enemy piece.
        valid_moves << possible_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_left_moves(initial_loc, board)
    # Since we will only manipulate col there is no need to convert
    # row into an integer.
    row = initial_loc[0]
    col = initial_loc[1].ord - 97 # - 97 because 97 is ord for small 'a'
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
end
