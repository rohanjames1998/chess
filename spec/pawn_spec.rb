require_relative "../lib/pawn"

describe Pawn do
  subject(:single_pawn) { described_class.new }
  let(:board) { instance_double(Board) }

  describe "#generate_possible_moves" do
    context "When the pawn is moving for the first time" do
      xit "returns 2 possible correct moves" do
        initial_location = [2, 0]
        correct_possible_moves = [[3, 0] [4, 0]]
        allow(single_pawn).to receive(:location).and_return(initial_location)
        allow(single_pawn).to receive(:first_move?).and_return(true)
        result = single_pawn.generate_possible_moves(initial_location, board)
        expect(result).to eq(correct_possible_moves)
      end

      xit "changes @first_move? to false" do
        initial_location = [7, 7]
        allow(single_pawn).to receive(:location).and_return(initial_location)
        allow(single_pawn).to receive(:first_move?).and_return(true)
        expect(single_pawn).to receive(:first_move?=).with(false)
        single_pawn.generate_possible_moves(initial_location, board)
      end
    end

    context "When there is an enemy piece that pawn can kill" do
      let(:enemy_piece) { instance_double(Pawn)}
      before do
        allow(enemy_piece).to receive(:unicode).and_return("\u265f")
        allow(single_pawn).to receive(:first_move?).and_return(false)
        allow(board).to receive(:grid[4]).and_return([" ","#{enemy_piece}"," "," "," "," "," "," "," "])
      end

      xit "returns enemy piece's location as a possible move" do
        initial_location = [3, 0]
        enemy_position = [4, 0]
        allow(single_pawn).to receive(:location).and_return(initial_location)
        result = single_pawn.generate_possible_moves(initial_location, board)
        expect(result).to include(enemy_position)
      end
    end
  end
end



