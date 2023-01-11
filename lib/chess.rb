require_relative 'player'
require_relative 'board'
require 'json'
require 'fileutils'

class Chess
  attr_reader :board, :game_end, :p1, :p2, :turn, :potential_winner

  def initialize
    @p1 = Player.new
    @p2 = Player.new
    @board = Board.new
    @game_end = false
    @turn = p1
    @potential_winner = p2 #This variable track who might win the game when we run #checkmate(see below)
  end

  def start_game
    loop do
      print 'Do you want to load a saved game?[Y/n]:'
      input = get_input
      if input == 'y'
        load_game
        play_game
        break
      elsif input == 'n'
        p1.white
        p2.black
        board.add_new_pieces_to_board
        play_game
        break
      else
        puts 'Invalid input'
        next
      end
    end
  end

  def play_game
    loop do
      break if game_end == true
      board.display_chess
      round(@turn)
      checkmate(turn, potential_winner)
      change_turns
    end
  end

  def change_turns
    if turn == p1
      @turn = p2
      @potential_winner = p1
    else
      @turn = p1
      @potential_winner = p2
    end
  end

  def round(player)
    if check?(player, board)
      puts "\n\033[31;1;1m#{player.name}\033[0m your king is under threat!!",
           "Save your king or type quit to end the game."
    end
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
    if loc.length >= 2
      row = loc[0]
      col = loc[1].downcase
      if /[1-8]$/.match(row) && /[a-h]$/.match(col)
        return true
      end
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
      puts "#{player.name}, which piece do you want to move?:"
      input = get_input
      case
      when input == 'save'
        save_game
        next
      when input == 'quit'
        @game_end = true
        return 'quit'
      when valid_format?(input) && board[input] == ""
        # This conditional checks whether the given input is valid && there is a piece present at the given
        # location
        print "The location you entered has no chess piece.\n"
        next
      when valid_input?(input, player) && board[input] != ""
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
    # If player wants to quit the game while choosing their piece
    # this method wont run
    return if piece == 'quit'
    potential_moves = board[piece].generate_potential_moves(piece, board)
    display_potential_moves(potential_moves)
    loop do
      puts "\nEnter your move or enter 'x' to choose another piece:"
      move = get_input
      case
      when move == 'x'
        remove_potential_moves_indicator(potential_moves)
        board.display_chess
        round(player)
        break
      when valid_move?(move, piece, potential_moves)
        move_piece(piece, move, player)
        remove_potential_moves_indicator(potential_moves)
        break
      else
        puts "\n\033[31;1;1mInvalid move\033[0m"
        next
      end
    end
  end

  def display_potential_moves(potential_moves)
    indicator = "\u2718"
    potential_moves.each do |move|
      if board[move] == ''
        board[move] = indicator
      end
    end
    board.display_chess
  end

  def valid_move?(move, piece, potential_moves)
    # This method checks if move given by player has valid format and
    # is included in potential moves of the piece selected.
    if valid_format?(move) && potential_moves.include?(move)
      return true
    end
    return false
  end

  def move_piece(piece, move, player)
    # This method moves the piece to given location and removes it from the previous location
    # Also if player chooses to move their king it changes player.king_loc to new location
    # so we can track where the king's location for #check? and #checkmate?
    if board[piece].is_a?(King)
      board[move] = board[piece]
      player.king_loc = move
      board[piece] = ""
    else
      board[move] = board[piece]
      board[piece] = ""
    end
  end

  def remove_potential_moves_indicator(potential_moves)
    indicator = "\u2718"
    potential_moves.each do |move|
      if board[move] == indicator
        board[move] = ""
      end
    end
  end

  def display_valid_input_format
    puts "\nYou either cannot move that piece or your input is invalid.",
         "the only valid input you can give has to be like:",
         "1a",
         "Where '1' is the row and 'a' is the column of the board.",
         "\033[31mRemember your row cannot be greater than 8 and your column cannot be any alphabet higher than 'h'.\033[0m"
    board.display_chess
  end

  def check?(player, board)
    # Checks if player's king's current position is clear. If it is
    # it returns false. Else it returns true.
    king_loc = player.king_loc
    king = board[king_loc]
    if king.clear?(king_loc, board)
      return false
    end

    return true
  end

  def checkmate(loser, winner)
    # This method takes two players as arguments and check if winner(i.e., potentially the winner)
    # has won the game. In order to do this, this method checks if #check? returns true after
    # loser's turn has ended.
    if check?(loser, board)
      puts "Congratulations #{winner.name} you have won the game!!!"
      @game_end = true
    end
  end
  def save_game
    loop do
      print "\nEnter the name of your save file:"
      file_name = get_input
      file_name += '.json'
      path = './saved_games'
      FileUtils.mkdir_p(path) unless File.exist?(path)
      complete_file_name = File.join(path, file_name)
      if File.exist?(complete_file_name)
        puts 'A save file with that name already exists.'
        next
      else
        File.open(complete_file_name, 'w') do |file|
          file.write(convert_to_json(p1, p2, board, turn, potential_winner))
        end
        puts "\nYour game has been successfully saved."
        break
      end
    end
  end

  def convert_to_json(p1, p2, board, turn, potential_winner)
    hash = {
      'p1_name' => p1.name,
      'p1_color' => p1.color,
      'p1_king_loc' => p1.king_loc,
      'p2_name' => p2.name,
      'p2_color' => p2.color,
      'p2_king_loc' => p2.king_loc,
      'board' => save_game_board(board.grid),
      'turn' => turn,
      'potential_winner' => potential_winner
    }.to_json
  end

  def load_game
    saved_data = get_saved_file
    p1.name = saved_data['p1_name']
    p1.color = saved_data['p1_color']
    p1.king_loc = saved_data['p1_king_loc']
    p2.name = saved_data['p2_name']
    p2.color = saved_data['p2_color']
    p2.king_loc = saved_data['p2_king_loc']
    board.grid = convert_json_hash(saved_data['board'])
    @turn = saved_data['turn']
    @potential_winner = saved_data['potential_winner']
  end

  def get_saved_file
    path = './saved_games'
    puts "\nPlease choose a save file:"
    Dir.each_child(path) do |file|
      saved_file_name = file.split('.')[0]
      puts saved_file_name # Showing file names for user to choose from.
    end
    user_input = get_file_name
    selected_file = File.read(user_input)
    saved_data = JSON.parse(selected_file)
    saved_data
  end

  def get_file_name
    loop do
      name = get_input
      file_name_with_path = File.join('./saved_games', name)
      if File.exist?("#{file_name_with_path}.json")
        return "#{file_name_with_path}.json"
      else
        print "Please enter a valid file name:"
        next
      end
    end
  end

  def save_game_board(grid)
    hash_to_save = Hash.new
    row_to_save = Array.new
    row_num = 8
    grid.each do |row, array|
      array.each do |item|
        if item == ''
           row_to_save << ''
        else
          row_to_save << save_piece_info(item)
        end
      end
      hash_to_save[row_num] = row_to_save
      row_to_save = []
      row_num -= 1
    end
    hash_to_save
  end

  def save_piece_info(piece)
    # Saving each piece's attributes in order to use it when we load game.
    info_arr = [piece.class, piece.color]
    info_arr
  end

  def load_game_board(saved_hash)
    # This method constructs game grid from saved json hash.
    converted_hash = Hash.new
    converted_row = Array.new
    row_num = 8
    saved_hash.each do |row, array|
      array.each do |item|
        if item == ''
          converted_row << ''
        else
          converted_row << load_piece_from_json(item)
        end
        converted_hash[row_num] = converted_row
        converted_row = []
        row_num -= 1
      end
    end
    converted_hash
  end

  def load_piece_from_json(piece_info)
    case
    when piece_info[0] == 'Pawn'
      piece = Pawn.new
    when piece_info[0] == 'Rook'
      piece = Rook.new
    when piece_info[0] == 'Knight'
      piece = Knight.new
    when piece_info[0] == 'Bishop'
      piece = Bishop.new
    when piece_info[0] == 'Queen'
      piece = Queen.new
    when piece_info[0] == 'King'
      piece = King.new
    end

    # Adding color to piece
    if piece_info[1] == 'white'
      piece.white
    else
      piece.black
    end
    piece
  end
end
