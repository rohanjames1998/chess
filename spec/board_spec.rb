require_relative "../lib/board"

describe Board do

  describe "#make_chess_board" do
    subject(:unmade_board) { described_class.new }

    context "When called" do
      it "it populates grid with 8 arrays" do
        unmade_board.make_chess_board
        expect(unmade_board.grid.length).to eq(8)
      end

      it "each array also has the length of 8" do
        unmade_board.make_chess_board
        expect(unmade_board.grid[2].length).to eq(8)
      end
    end
  end

  describe "#add_white_pieces" do
    subject(:white_pieces_board) { described_class.new }

    context "When called" do
      it "removes all dummy elements" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        result = white_pieces_board.grid[1].include?('')
        expect(result).to eq(false)
      end

      it "adds two white rooks" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        rook1 = white_pieces_board.grid[1][0]
        rook2 = white_pieces_board.grid[1][7]
        expect(rook1).to be_a(Rook)
        expect(rook2).to be_a(Rook)
        expect(rook1.unicode).to eq("\u2656")
        expect(rook2.unicode).to eq("\u2656")
      end

      it "adds two white knights" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        knight1 = white_pieces_board.grid[1][1]
        knight2 = white_pieces_board.grid[1][6]
        expect(knight1).to be_a(Knight)
        expect(knight2).to be_a(Knight)
        expect(knight1.unicode).to eq("\u2658")
        expect(knight2.unicode).to eq("\u2658")
      end

      it "adds two white bishops" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        bishop1 = white_pieces_board.grid[1][2]
        bishop2 = white_pieces_board.grid[1][5]
        expect(bishop1).to be_a(Bishop)
        expect(bishop2).to be_a(Bishop)
        expect(bishop1.unicode).to eq("\u2657")
        expect(bishop2.unicode).to eq("\u2657")
      end

      it "adds a white queen" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        queen = white_pieces_board.grid[1][3]
        expect(queen).to be_a(Queen)
        expect(queen.unicode).to eq("\u2655")
      end

      it "adds a white king" do
        white_pieces_board.make_chess_board
        white_pieces_board.add_white_pieces
        king = white_pieces_board.grid[1][4]
        expect(king).to be_a(King)
        expect(king.unicode).to eq("\u2654")
      end
    end
  end

  describe "#add_white_pawns" do
    subject(:white_pawn_board) { described_class.new }

    context "When called" do
      it "removes all dummy elements" do
        white_pawn_board.make_chess_board
        white_pawn_board.add_white_pawns
        result = white_pawn_board.grid[2].include?("")
        expect(result).to eq(false)
      end

      it "adds 8 pawns" do
        white_pawn_board.make_chess_board
        white_pawn_board.add_white_pawns
        result = white_pawn_board.grid[2].all?(Pawn)
        expect(result).to eq(true)
      end

      it "all pawns are white" do
        white_pawn_board.make_chess_board
        white_pawn_board.add_white_pawns
        result = white_pawn_board.grid[2].all? {|piece| piece.unicode = "\u2659"}
        expect(result).to eq(true)
      end
    end
  end

  describe "#add_black_pieces" do
    subject(:black_pieces_board) { described_class.new }

    context "When called" do
      it "removes all dummy elements" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        result = black_pieces_board.grid[8].include?('')
        expect(result).to eq(false)
      end

      it "adds two black rooks" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        rook1 = black_pieces_board.grid[8][0]
        rook2 = black_pieces_board.grid[8][7]
        expect(rook1).to be_a(Rook)
        expect(rook2).to be_a(Rook)
        expect(rook1.unicode).to eq("\u265c")
        expect(rook2.unicode).to eq("\u265c")
      end

      it "adds two black knights" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        knight1 = black_pieces_board.grid[8][1]
        knight2 = black_pieces_board.grid[8][6]
        expect(knight1).to be_a(Knight)
        expect(knight2).to be_a(Knight)
        expect(knight1.unicode).to eq("\u265e")
        expect(knight2.unicode).to eq("\u265e")
      end

      it "adds two black bishops" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        bishop1 = black_pieces_board.grid[8][2]
        bishop2 = black_pieces_board.grid[8][5]
        expect(bishop1).to be_a(Bishop)
        expect(bishop2).to be_a(Bishop)
        expect(bishop1.unicode).to eq("\u265d")
        expect(bishop2.unicode).to eq("\u265d")
      end

      it "adds a black queen" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        queen = black_pieces_board.grid[8][3]
        expect(queen).to be_a(Queen)
        expect(queen.unicode).to eq("\u265b")
      end

      it "adds a black king" do
        black_pieces_board.make_chess_board
        black_pieces_board.add_black_pieces
        king = black_pieces_board.grid[8][4]
        expect(king).to be_a(King)
        expect(king.unicode).to eq("\u265a")
      end
    end
  end

  describe "#add_black_pawns" do
    subject(:black_pawn_board) { described_class.new }

    context "When called" do
      xit "removes all dummy elements" do
        black_pawn_board.make_chess_board
        black_pawn_board.add_black_pawns
        result = black_pawn_board.grid[7].include?("")
        expect(result).to eq(false)
      end

      xit "adds 8 pawns" do
        black_pawn_board.make_chess_board
        black_pawn_board.add_black_pawns
        result = black_pawn_board.grid[2].all?(Pawn)
        expect(result).to eq(true)
      end

      xit "all pawns are black" do
        black_pawn_board.make_chess_board
        black_pawn_board.add_black_pawns
        result = black_pawn_board.grid[2].all? {|piece| piece.unicode = "\u265f"}
        expect(result).to eq(true)
      end
    end
  end

end
