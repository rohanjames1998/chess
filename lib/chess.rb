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
      case
      when valid_location?(input) && board[input] == " "
        print "The location you entered has no chess piece."
        next
      when valid_location?(input) && board[input] != " "
        chosen_piece = board[input]
        player.chosen_piece = chosen_piece
        get_piece_placement(player)
        break
      else
        next
      end
    end
  end

  def display_valid_input_format
    puts "\nWhen choosing which piece to move or moving the piece",
         "the only valid input you can give has to be like:",
         "1a",
         "Where '1' is the row and 'a' is the column of the board.",
         "\033[31mRemember your row cannot be greater than 8 and your column cannot be any alphabet higher than 'h'.\033[0m"
  end

  def get_piece_placement(player)
  end
end
