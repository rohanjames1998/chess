require_relative 'movement'
class King

  attr_reader :unicode, :color
  include Movement

  def initialize
    @unicode = ''
    @color = ''
  end

  def white
    @unicode = "\u2654"
    @color = 'white'
  end

  def black
    @unicode = "\u265a"
    @color ='black'
  end

  def generate_potential_moves(initial_loc, board)
    all_moves = generate_king_moves(initial_loc)
    valid_moves = validate_moves(all_moves, board, color)
    potential_moves = check_safe_moves(valid_moves, board)
    potential_moves
  end
  # This method checks each move and returns only those where king can move.
  # Such as empty locations or locations where king can kill the enemy.
  # This function doesn't check whether the position is safe for the king.
  def validate_moves(all_moves, board, color)
    valid_moves = []
    all_moves.each do |move|
      piece = board[move]
      case
      when piece == '' #For empty locations.
        valid_moves << move
      when piece.color != color #For enemy pieces.
        valid_moves << move
      else #For ally pieces or out of board moves.
        next
      end
    end
    valid_moves
  end

  # Since our king can only move to a location if it is safe(i.e., not threatened by an enemy) we are gonna check if the location is safe or not.
  def check_safe_moves(all_moves, board)
    potential_moves = []
    all_moves.each do |move|
      potential_moves << move if clear?(move, board)
    end
    potential_moves
  end

  def clear?(move, board)
    # This method checks if a location is threatened by an enemy piece
    # Returns true if there is no threat; returns false if there is a threat.
    case
    when diagonal_threat?(move, board)
      return false
    when vertical_threat?(move, board)
      return false
    when horizontal_threat?(move, board)
      return false
    when knight_threat?(move, board)
      return false
    when king_threat?(move, board, color)
      return false
    when pawn_threat?(move, board, color)
      return false
    else
      return true
    end
  end


  # In the threat detection methods (#diagonal_threat?, #horizontal_threat?, and so on)
  # we first generate all the moves from the possible move location and then check if our
  #king can safely move to this location.
  def diagonal_threat?(move, board)
    # Since these movement methods will return enemy pieces (if any) as their last element
    #(they always return arrays) all we will do is check if the last element is a bishop or queen
    #(these method doesn't return ally pieces).
    last_top_right = generate_top_right_moves(move, board, color).last
    last_top_left = generate_top_left_moves(move, board, color).last
    last_down_right = generate_down_right_moves(move, board, color).last
    last_down_left = generate_down_left_moves(move, board, color).last

    case
    when board[last_top_right].is_a?(Queen) || board[last_top_right].is_a?(Bishop)
      return true
    when board[last_top_left].is_a?(Queen) || board[last_top_left].is_a?(Bishop)
      return true
    when board[last_down_right].is_a?(Queen) || board[last_down_right].is_a?(Bishop)
      return true
    when board[last_down_left].is_a?(Queen) || board[last_down_left].is_a?(Bishop)
      return true
    else
      return false
    end
  end

  def vertical_threat?(move, board)
    last_top = generate_up_moves(move, board, color).last
    last_down = generate_down_moves(move, board, color).last
    # Only rook or queen can threaten vertically.
    case
    when board[last_top].is_a?(Rook) || board[last_top].is_a?(Queen)
      return true
    when board[last_down].is_a?(Rook) || board[last_down].is_a?(Queen)
      return true
    else
      return false
    end
  end

  def horizontal_threat?(move, board)
    last_left = generate_left_moves(move, board, color).last
    last_right = generate_right_moves(move, board, color).last
    # Only rook or queen can threaten horizontally.
    case
    when board[last_left].is_a?(Rook) || board[last_left].is_a?(Queen)
      return true
    when board[last_right].is_a?(Rook) || board[last_right].is_a?(Queen)
      return true
    else
      return false
    end
  end

  def knight_threat?(move, board)
    # In this method we generate all potential knight moves from the location (that our king wants to move to) and check if an enemy knight is on the location.
    potential_enemy_locations = generate_knight_moves(move)
    potential_enemy_locations.each do |loc|
      piece = board[loc]
      if enemy_knight?(piece, color)
        return true
      end
    end
    return false
  end

  def enemy_knight?(piece, color)
    # This method just check a piece and returns true if it is an enemy knight
    if piece.is_a?(Knight) && piece.color != color
      return true
    end
    return false
  end

  def king_threat?(move, board, color)
    potential_enemy_locations = generate_king_moves(move)
    potential_enemy_locations.each do |loc|
      piece = board[loc]
      if piece.is_a?(King) && piece.color != color
        return true
      end
    end
    return false
  end

  def pawn_threat?(move, board, color)
    # Possible enemy pawn locations differ according to king's color.
    row = move[0].to_i
    col = move[1].ord
    if color == 'white'
      loc_1 = (row + 1).to_s + (col - 1).chr #up-left
      loc_2 = (row + 1).to_s + (col + 1).chr #up-right
    else # For black
      loc_1 = (row - 1).to_s  + (col - 1).chr #down-left
      loc_2 = (row - 1).to_s + (col + 1).chr #down-right
    end
    # checking for enemy pawn on both locations
    case
    when enemy_pawn?(loc_1, board, color)
      return true
    when enemy_pawn?(loc_2, board, color)
      return true
    else
      return false
    end
  end

  def enemy_pawn?(location, board, color)
    piece = board[location]
    if piece.is_a?(Pawn) && piece.color != color
      return true
    end
    return false
  end
end
