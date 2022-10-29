require_relative 'king'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'knight'
require_relative 'pawn'
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

  def add_pieces_to_board
    add_white_pieces
    add_white_pawns
    add_black_pieces
    add_black_pawns
  end

  def add_white_pieces
    array_with_pieces = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]

    # Making each piece white
    array_with_pieces.each do |piece|
      piece.white
    end

    grid[1] = array_with_pieces
  end

  def add_white_pawns
  end
end
