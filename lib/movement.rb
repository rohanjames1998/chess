
# This module has methods that create moves for each piece.
# Depending on the piece each move's validity is checked in their respective class.
module Movement

  def gen_pawn_moves(initial_loc, first_move)
    # This method provides all possible moves for a pawn it doesn't check
    # whether or not the moves are valid it just generates them.


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


end
