
# This module has methods that create moves for each piece.
# Depending on the piece each move's validity is checked in their respective class.
module Movement

  def generate_pawn_moves(initial_loc, first_move)
    # This method provides all possible moves for a pawn it doesn't check
    # whether or not the moves are valid it. The only check this method performs is to check
    # for first move.

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
    return moves
  end

  # These left right top down methods generate movements for rook and queen when they move vertically
  # or horizontally.
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
      else # For ally piece and moves outside board
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
      else # For ally piece and moves outside board
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


end
