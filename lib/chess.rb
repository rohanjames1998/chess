require_relative 'player'
require_relative 'board'

class Chess

  attr_reader :board

  def initialize
    @p1 = Player.new
    @p2 = Player.new
    @board = Board.new
  end

  def valid_location?(coordinates)
    row = coordinates[0]
    col = coordinates[1].downcase
    if /[1-8]$/.match(row) && /[a-h]$/.match(col)
      return true
    end
    display_valid_input_format
    return false
  end

  # This method prompts player to select a piece to move on the board. Then it proceeds to check if
  # given input is valid or not.
  def get_player_piece(player)
    loop do
      puts "Which piece do you want to move?:"
      input = gets.chomp.delete(' ')
      # This conditional checks whether the given input is valid && there is a piece present at the given
      # location
      if valid_location?(input) && board[input] != " "
        chosen_piece = board[input]
        player.chosen_piece = chosen_piece
        get_piece_placement(chosen_piece)
        break
      else
        next
      end
    end
  end

  def display_valid_input_format
    puts "\n When choosing which piece to move or where to put said piece",
         "the only valid input you can give has to be like:",
         "1a",
         "Where '1' is the row and 'a' is the column of the board.",
         "Remember your row cannot be greater than 8 and your column cannot be any
         alphabet higher than 'h'."
  end

  def get_piece_placement(chosen_piece)
  end
end
