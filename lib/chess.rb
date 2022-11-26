require_relative 'player'
require_relative 'board'

class Chess
  attr_reader :board, :game_end, :p1, :p2

  def initialize
    @p1 = Player.new
    @p2 = Player.new
    @board = Board.new
    @game_end = false
  end

  def play_game(player1 = p1, player2 = p2)
    loop do
      break if game_end == true

      board.display_chess
      round(player1)
      break if game_end == true

      board.display_chess
      round(player2)
    end
  end

  def round(player)
    piece_to_move = get_player_piece(player)
    get_player_move(player, piece_to_move)
  end

  def valid_input?(coordinates, player)
    if valid_format?(coordinates) && valid_choice?(coordinates, player)
      return true
    end

    display_valid_input_format
    return false
  end

  def valid_format?(loc)
    row = loc[0]
    col = loc[1].downcase
    if /[1-8]$/.match(row) && /[a-h]$/.match(col)
      return true
    end

    return false
  end

  # This method checks if player color matches the color of the piece.
  def valid_choice?(loc, player)
    if board[loc].color == player.color
      return true
    end

    return false
  end

  # This method prompts player to select a piece to move on the board. Then it proceeds to check if
  # given input is valid or not.
  def get_player_piece(player)
    loop do
      puts "Which piece do you want to move?:"
      input = get_input
      # This conditional checks whether the given input is valid && there is a piece present at the given
      # location
      case
      when valid_input?(input, player) && board[input] == " "
        print "The location you entered has no chess piece."
        next
      when valid_input?(input, player) && board[input] != " "
        return input
        break
      else
        next
      end
    end
  end

  def get_input
    gets.chomp.downcase.delete(' ')
  end

  def get_player_move(player, piece)
    potential_moves = board[piece].generate_potential_moves(piece, board)
    display_potential_moves(potential_moves)
    loop do
      puts "\nEnter your move or 'x' to choose another piece:"
      move = get_input
      case
      when move == 'x'
        round(player)
        remove_potential_moves(potential_moves)
        break
      when valid_move?(move)
        move_piece(piece, move)
        remove_potential_moves(potential_moves)
        break
      else
        puts "\n\033[31;1Invalid move\033[0m"
        next
      end
    end
  end

  def display_potential_moves(potential_moves)
    indicator = "\u2718"
    potential_moves.each do |move|
      board[move] = indicator
    end
  end

  def valid_move?(move, piece)
    potential_moves = board[piece].generate_potential_moves(piece, board)
    if valid_format?(move) && potential_moves.include?(move)
      return true
    end

    return false
  end

  def move_piece(move, piece)
    # This method moves the piece to given location and removes it from the previous location
    board[move] = board[piece]
    board[piece] = ' '
  end

  def remove_potential_moves_indicator(potential_moves)
    indicator = "\u2718"
    potential_moves.each do |move|
      if board[move] == indicator
        board[move] = ' '
      end
    end
  end

  def display_valid_input_format
    puts "\nYou either cannot move that piece or your input is invalid.",
         "the only valid input you can give has to be like:",
         "1a",
         "Where '1' is the row and 'a' is the column of the board.",
         "\033[31mRemember your row cannot be greater than 8 and your column cannot be any alphabet higher than 'h'.\033[0m"
  end
end
