require_relative 'board'
class Bishop

  attr_reader :unicode, :color

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2657"
    @color = 'white'
  end

  def black
    @unicode = "\u265d"
    @color = 'black'
  end

  def generate_possible_moves(initial_loc, board)
    possible_moves = []

    possible_moves << generate_top_right_moves(initial_loc, board)
    possible_moves << generate_top_left_moves(initial_loc, board)
    possible_moves << generate_down_right_moves(initial_loc, board)
    possible_moves << generate_down_left_moves(initial_loc, board)

    possible_moves
  end

  def generate_top_right_moves(initial_loc, board)
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
        next
      end
    end
    valid_moves
  end

  def generate_top_left_moves(initial_loc, board)
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
        next
      end
    end
    valid_moves
  end

  def generate_down_right_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row > 0 && col < 7
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
        next
      end
    end
    valid_moves
  end

  def generate_down_left_moves(initial_loc, board)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97

    while row > 0 && col > 0
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
        next
      end
    end
    valid_moves
  end
end
