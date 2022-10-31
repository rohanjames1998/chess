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
    row = 8
    while row > 0
      while col.length < 8
        col << dummy_ele
      end
      grid[row] = col
      row -= 1
      col = []
    end
  end

  def add_new_pieces_to_board
    make_chess_board
    add_white_pieces
    add_white_pawns
    add_black_piece
    add_black_pawn
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
    grid[2].each_with_index do |ele, index|
      pawn = Pawn.new
      pawn.white
      grid[2][index] = pawn
    end
  end

  def add_black_pieces
    array_with_pieces = [Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new]

    # Making each piece black
    array_with_pieces.each do |piece|
      piece.black
    end

    grid[8] = array_with_pieces
  end

  def add_black_pawns
    grid[7].each_with_index do |ele, index|
      pawn = Pawn.new
      pawn.black
      grid[7][index] = pawn
    end
  end
end



