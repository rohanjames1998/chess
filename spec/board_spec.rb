require_relative "../lib/board.rb"

describe Board do

  describe "#make_chess_board" do
    subject(:chess) { described_class.new }

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
end
