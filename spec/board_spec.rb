require_relative "../lib/board"

describe Board do
  subject(:chess) { described_class.new }

  describe "#make_chess_board" do

    context "When called" do
      it "it populates grid with 8 arrays" do
        chess.make_chess_board
        expect(chess.grid.length).to eq(8)
      end

      it "each array also has the length of 8" do
        chess.make_chess_board
        expect(chess.grid[1].length).to eq(8)
      end
    end
  end

  describe "#add_white_pieces" do

    context "When called" do
      it "removes all dummy elements" do
        chess.add_white_pieces
        result = chess.grid[1].include?('')
        expect(result).to eq(false)
      end

      it "adds two white rooks" do
        chess.add_white_pieces
        rook1 = chess.grid[1][0]
        rook2 = chess.grid[1][7]
        expect(rook1).to be_a(Rook)
        expect(rook2).to be_a(Rook)
        expect(rook1.unicode).to eq("\u2656")
        expect(rook2.unicode).to eq("\u2656")
      end

      it "adds two white knights" do
        chess.add_white_pieces
        knight1 = chess.grid[1][1]
        knight2 = chess.grid[1][6]
        expect(knight1).to be_a(Knight)
        expect(knight2).to be_a(Knight)
        expect(knight1.unicode).to eq("\u2658")
        expect(knight2.unicode).to eq("\u2658")
      end

      it "adds two white bishops" do
        chess.add_white_pieces
        bishop1 = chess.grid[1][2]
        bishop2 = chess.grid[1][5]
        expect(bishop1).to be_a(Bishop)
        expect(bishop2).to be_a(Bishop)
        expect(bishop1.unicode).to eq("\u2657")
        expect(bishop2.unicode).to eq("\u2657")
      end

      it "adds a white queen" do
        chess.add_white_pieces
        queen = chess.grid[1][3]
        expect(queen).to be_a(Queen)
        expect(queen.unicode).to eq("\u2655")
      end

      it "adds a white king" do
        chess.add_white_pieces
        king = chess.grid[1][4]
        expect(king).to be_a(King)
        expect(king.unicode).to eq("\u2654")
      end
    end
  end
end
