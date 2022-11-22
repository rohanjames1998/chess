require_relative "../lib/pawn"
require_relative "../lib/board"
require_relative "../lib/knight"

describe Pawn do
  subject (:pawn) { described_class.new }
  let(:board) { instance_double(Board)}
  let(:dummy_piece) { instance_double(Knight) }

  before do
    allow(pawn).to receive(:color).and_return("white")
  end

  describe "#check_valid_moves" do
    context "When its the first move and both forward locations are empty" do
      it "returns both locations" do
        normal_moves = ["3a", "4a"]
        # We leave kill_moves empty because it is not the subject of this test.
        kill_moves = []
        all_possible_moves = [normal_moves, kill_moves]
        expected_result = normal_moves
        allow(board).to receive(:[]).and_return('')
        potential_moves = pawn.check_valid_moves(all_possible_moves, board)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When one forward move is blocked and its the first move" do
      it "returns one forward move if other is blocked" do
        normal_moves = ["3a", "4a"]
        kill_moves = []
        all_possible_moves = [normal_moves, kill_moves]
        expected_result = ["3a"]
        allow(board).to receive(:[]).and_return('', dummy_piece)
        potential_moves = pawn.check_valid_moves(all_possible_moves, board)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When there are no pieces to kill" do
      it "returns only one potential move" do
        normal_moves =  ["5b"]
        kill_moves = ["5a", "5c"]
        all_possible_moves = [normal_moves, kill_moves]
        expected_result = normal_moves
        # returning empty string for every call of #:[]
        allow(board).to receive(:[]).and_return('')
        potential_moves = pawn.check_valid_moves(all_possible_moves, board)
        expect(potential_moves).to eq(normal_moves)
      end
    end
    context "When there are enemy pieces to kill" do
      it "returns enemy piece's location" do
        normal_moves = ["4b"]
        kill_moves = ["4a", "4c"]
        all_possible_moves = [normal_moves, kill_moves]
        expected_result = ["4b", "4a", "4c"]
        allow(board).to receive(:[]).and_return('', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return("black")
        potential_moves = pawn.check_valid_moves(all_possible_moves, board)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When pawn is blocked from all sides" do
      it "returns empty an array" do
      normal_moves = ["6b"]
      kill_moves = ["6a", "6c"]
      all_possible_moves = [normal_moves, kill_moves]
      expected_result = []
      allow(board).to receive(:[]).and_return(dummy_piece)
      allow(dummy_piece).to receive(:color).and_return("white")
      allow(pawn).to receive(:color).and_return("white")
      potential_moves = pawn.check_valid_moves(all_possible_moves, board)
      expect(potential_moves).to eq(expected_result)
      end
    end
  end

  describe "#first_move_check" do
    context "When its the first move" do
      it "changes first move instance variable to false" do
        # @first_move before we run the function
        before = pawn.instance_variable_get(:@first_move)
        pawn.first_move_check
        # @first_move after we run the function
        after = pawn.instance_variable_get(:@first_move)
        expect(before).to eq(true)
        expect(after).to eq(false)
      end
    end
  end
end




