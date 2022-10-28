
class Board

  attr_accessor :grid

  def initialize
    @grid = {}
  end

  def make_chess_board
    dummy_ele = ''
    col = []
    row = 1
    while row <= 8
      while col.length < 8
        col << dummy_ele
      end
      grid[row] = col
      row += 1
      col = []
    end
  end
end
