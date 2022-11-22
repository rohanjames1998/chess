require_relative '../lib/king'
require_relative '../lib/board'
require_relative '../lib/movement'
require_relative '../lib/knight'

describe King do
  subject(:king) { described_class.new }
  let(:dummy_piece) { instance_double(Knight) }
  let(:board) { instance_double(Board) }

  describe "#check_valid_moves" do
    context "When moves are clear" do
      # Clear means there is no immediate threat for king if
      # player decides to move their king to that location.
      it "returns all clear moves" do
        all_moves = ['1d', '1f']
        allow(king).to receive(:clear?).and_return(true)
        result = king.check_valid_moves(all_moves, board)
        expect(result).to eq(all_moves)
      end
    end
    context "When some moves are not clear" do
      it "returns only the clear moves" do
        all_moves = ['2d', '2f', '1e']
        expected_result = ['2d', '2f']
        allow(king).to receive(:clear?).and_return(true, true, false)
        result = king.check_valid_moves(all_moves, board)
        expect(result).to eq(expected_result)
      end
    end
  end
end

