
# This module has methods that create moves for each piece.
# Depending on the piece each move's validity is checked in their respective class.
module Movement

  def generate_white_pawn_moves(initial_loc, first_move)
    # This method provides all possible moves for a pawn.
    # It doesn't check whether or not the moves are valid it.
    # The only check this method performs is to check for first move.

    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    normal_moves = []
    kill_moves = []

    if first_move
      normal_moves << (row + 2).to_s + col.chr
      normal_moves << (row + 1).to_s + col.chr
      kill_moves << (row + 1).to_s + (col + 1).chr
      kill_moves << (row + 1).to_s + (col - 1).chr
    else
      normal_moves << (row + 1).to_s + col.chr
      kill_moves << (row + 1).to_s + (col + 1).chr
      kill_moves << (row + 1).to_s + (col - 1).chr
    end

    moves = [normal_moves, kill_moves]
    moves
  end

  def generate_black_pawn_moves(initial_loc, first_move)
    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    normal_moves = []
    kill_moves = []

    if first_move
      normal_moves << (row - 2).to_s + col.chr
      normal_moves << (row - 1).to_s + col.chr
      kill_moves << (row - 1).to_s + (col + 1).chr
      kill_moves << (row - 1).to_s + (col - 1).chr
    else
      normal_moves << (row - 1).to_s + col.chr
      kill_moves << (row - 1).to_s + (col + 1).chr
      kill_moves << (row - 1).to_s + (col - 1).chr
    end

    moves = [normal_moves, kill_moves]
    moves
  end


  # These left, right, top, and down methods generate movements for rook and queen when they move vertically or horizontally.
  def generate_left_moves(initial_loc, board, color)
    # Since we will only manipulate col there is no need to convert
    # row into an integer.
    row = initial_loc[0]
    col = initial_loc[1].ord - 97 # - 97 because 97 is ord for small 'a'
    potential_left_moves = []
    col -= 1 # Starting from left to avoid the position piece is already at.

    while col >= 0
      potential_move = row + (col + 97).chr
      case
      when board[potential_move] == "" # For empty location
        potential_left_moves << potential_move
        col -= 1 # Moving left only if it is empty otherwise we don't need to move left.
      when board[potential_move].color != color # For enemy piece
        potential_left_moves << potential_move
        break
      else # For ally piece
        break
      end
    end
    potential_left_moves
  end

  def generate_right_moves(initial_loc, board, color)
    row = initial_loc[0]
    col = initial_loc[1].ord - 97
    potential_right_moves = []
    col += 1

    while col <= 7
      potential_move = row + (col + 97).chr
      case
      when board[potential_move] == "" # For empty location
        potential_right_moves << potential_move
        col += 1
      when board[potential_move].color != color # For enemy piece
        potential_right_moves << potential_move
        break
      else # For ally piece and moves outside board
        break
      end
    end
    potential_right_moves
  end

  def generate_up_moves(initial_loc, board, color)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    potential_top_moves = []
    row += 1

    while row <= 8
      potential_move = row.to_s + col

      case
      when board[potential_move] == ""
        potential_top_moves << potential_move
        row += 1
      when board[potential_move].color != color
        potential_top_moves << potential_move
        break
      else
        break
      end
    end
    potential_top_moves
  end

  def generate_down_moves(initial_loc, board, color)
    # Since we won't manipulate col we will not convert it to integer.
    row = initial_loc[0].to_i
    col = initial_loc[1]
    potential_down_moves = []
    row -= 1

    while row >= 1
      potential_move = row.to_s + col

      case
      when board[potential_move] == ""
        potential_down_moves << potential_move
        row -= 1
      when board[potential_move].color != color
        potential_down_moves << potential_move
        break
      else
        break
      end
    end
    potential_down_moves
  end

  def generate_knight_moves(initial_loc)

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
    return all_moves
  end

  # top_right, top_left, down_right, and down_left all generate
  # diagonal movements for bishop and queen.

  def generate_top_right_moves(initial_loc, board, color)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97
    row += 1
    col += 1

    while row <= 8 && col <= 7
      # Converting col back to alphabet by adding 97.
      potential_move = row.to_s + (col + 97).chr
      piece = board[potential_move]
      case
      when piece == '' # For empty location.
        valid_moves << potential_move
        row += 1
        col += 1
      when piece.color != color # For enemy piece.
        valid_moves << potential_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_top_left_moves(initial_loc, board, color)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97
    row += 1
    col -= 1

    while row <= 8 && col >= 0
      # Converting col back to alphabet by adding 97.
      potential_move = row.to_s + (col + 97).chr
      piece = board[potential_move]
      case
      when piece == '' # For empty location.
        valid_moves << potential_move
        row += 1
        col -= 1
      when piece.color != color # For enemy piece.
        valid_moves << potential_move
        break
      else # For ally piece
        break
      end
    end
    valid_moves
  end

  def generate_down_right_moves(initial_loc, board, color)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97
    row -= 1
    col += 1

    while row >= 1 && col <= 7
      # Converting col back to alphabet by adding 97.
      potential_move = row.to_s + (col + 97).chr
      piece = board[potential_move]
      case
      when piece == '' # For empty location.
        valid_moves << potential_move
        row -= 1
        col += 1
      when piece.color != color # For enemy piece.
        valid_moves << potential_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_down_left_moves(initial_loc, board, color)
    valid_moves = []
    row = initial_loc[0].to_i
    col = initial_loc[1].ord - 97
    row -= 1
    col -= 1

    while row >= 1 && col >= 0
      # Converting col back to alphabet by adding 97.
      potential_move = row.to_s + (col + 97).chr
      piece = board[potential_move]
      case
      when piece == '' # For empty location.
        valid_moves << potential_move
        row -= 1
        col -= 1
      when piece.color != color # For enemy piece.
        valid_moves << potential_move
        break
      else # For ally piece.
        break
      end
    end
    valid_moves
  end

  def generate_king_moves(initial_loc)
    row = initial_loc[0].to_i
    col = initial_loc[1].ord
    potential_moves = []
    potential_moves << (row + 1).to_s + (col - 1).chr #top-left
    potential_moves << (row + 1).to_s + col.chr # top
    potential_moves << (row + 1).to_s + (col + 1).chr #top-right
    potential_moves << row.to_s + (col - 1).chr #left
    potential_moves << row.to_s + (col + 1).chr # right
    potential_moves << (row - 1).to_s + (col - 1).chr #down-left
    potential_moves << (row - 1).to_s + col.chr #down
    potential_moves << (row - 1).to_s + (col + 1).chr #down-right
    potential_moves
  end

  def remove_out_of_board_moves(moves)
    inboard_moves = []
    moves.each do |move|
      row = move[0].to_i
      col = move[1].ord - 97
      if row.between?(1, 8) && col.between?(0, 7)
        inboard_moves << move
      end
    end
    inboard_moves
  end
end
