require_relative 'player'
require_relative 'board'

class Chess


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
end



