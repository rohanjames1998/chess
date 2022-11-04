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

  # This instance method uses combination of unicode and ASNI escape sequences to display chess board on the console.
  def display_chess
    puts <<~CHESSBOARD
    8 \033[48;5;254m #{chess_piece_at(grid[8][0])} \033[48;5;90m #{chess_piece_at(grid[8][1])} \033[48;5;254m #{chess_piece_at(grid[8][2])} \033[48;5;90m #{chess_piece_at(grid[8][3])} \033[48;5;254m #{chess_piece_at(grid[8][4])} \033[48;5;90m #{chess_piece_at(grid[8][5])} \033[48;5;254m #{chess_piece_at(grid[8][6])} \033[48;5;90m #{chess_piece_at(grid[8][7])} \033[0m
    7 \033[48;5;90m #{chess_piece_at(grid[7][0])} \033[48;5;254m #{chess_piece_at(grid[7][1])} \033[48;5;90m #{chess_piece_at(grid[7][2])} \033[48;5;254m #{chess_piece_at(grid[7][3])} \033[48;5;90m #{chess_piece_at(grid[7][4])} \033[48;5;254m #{chess_piece_at(grid[7][5])} \033[48;5;90m #{chess_piece_at(grid[7][6])} \033[48;5;254m #{chess_piece_at(grid[7][7])} \033[0m
    6 \033[48;5;254m #{chess_piece_at(grid[6][0])} \033[48;5;90m #{chess_piece_at(grid[6][1])} \033[48;5;254m #{chess_piece_at(grid[6][2])} \033[48;5;90m #{chess_piece_at(grid[6][3])} \033[48;5;254m #{chess_piece_at(grid[6][4])} \033[48;5;90m #{chess_piece_at(grid[6][5])} \033[48;5;254m #{chess_piece_at(grid[6][6])} \033[48;5;90m #{chess_piece_at(grid[6][7])} \033[0m
    5 \033[48;5;90m #{chess_piece_at(grid[5][0])} \033[48;5;254m #{chess_piece_at(grid[5][1])} \033[48;5;90m #{chess_piece_at(grid[5][2])} \033[48;5;254m #{chess_piece_at(grid[5][3])} \033[48;5;90m #{chess_piece_at(grid[5][4])} \033[48;5;254m #{chess_piece_at(grid[5][5])} \033[48;5;90m #{chess_piece_at(grid[5][6])} \033[48;5;254m #{chess_piece_at(grid[5][7])} \033[0m
    4 \033[48;5;254m #{chess_piece_at(grid[4][0])} \033[48;5;90m #{chess_piece_at(grid[4][1])} \033[48;5;254m #{chess_piece_at(grid[4][2])} \033[48;5;90m #{chess_piece_at(grid[4][3])} \033[48;5;254m #{chess_piece_at(grid[4][4])} \033[48;5;90m #{chess_piece_at(grid[4][5])} \033[48;5;254m #{chess_piece_at(grid[4][6])} \033[48;5;90m #{chess_piece_at(grid[4][7])} \033[0m
    3 \033[48;5;90m #{chess_piece_at(grid[3][0])} \033[48;5;254m #{chess_piece_at(grid[3][1])} \033[48;5;90m #{chess_piece_at(grid[3][2])} \033[48;5;254m #{chess_piece_at(grid[3][3])} \033[48;5;90m #{chess_piece_at(grid[3][4])} \033[48;5;254m #{chess_piece_at(grid[3][5])} \033[48;5;90m #{chess_piece_at(grid[3][6])} \033[48;5;254m #{chess_piece_at(grid[3][7])} \033[0m
    2 \033[48;5;254m #{chess_piece_at(grid[2][0])} \033[48;5;90m #{chess_piece_at(grid[2][1])} \033[48;5;254m #{chess_piece_at(grid[2][2])} \033[48;5;90m #{chess_piece_at(grid[2][3])} \033[48;5;254m #{chess_piece_at(grid[2][4])} \033[48;5;90m #{chess_piece_at(grid[2][5])} \033[48;5;254m #{chess_piece_at(grid[2][6])} \033[48;5;90m #{chess_piece_at(grid[2][7])} \033[0m
    1 \033[48;5;90m #{chess_piece_at(grid[1][0])} \033[48;5;254m #{chess_piece_at(grid[1][1])} \033[48;5;90m #{chess_piece_at(grid[1][2])} \033[48;5;254m #{chess_piece_at(grid[1][3])} \033[48;5;90m #{chess_piece_at(grid[1][4])} \033[48;5;254m #{chess_piece_at(grid[1][5])} \033[48;5;90m #{chess_piece_at(grid[1][6])} \033[48;5;254m #{chess_piece_at(grid[1][7])} \033[0m
       a  b  c  d  e  f  g  h
    CHESSBOARD
  end

  def chess_piece_at(grid_location)
    # If given location is empty it returns empty space else it returns the unicode
    # of the piece at the location.
    if grid_location == ""
      return " "
    else
      return grid_location.unicode
    end
  end

  def [](location)
    row = location[0].to_i
    col = location[1].downcase.ord - 97
    if grid[row]
      chess_piece_at(grid[row][col])
    end
  end
end



