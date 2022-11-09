require_relative "../lib/pawn"

describe Pawn do
  subject (:pawn) { described_class.new }
  let(:board) { instance_double(Board)}
  let(:dummy_piece) { instance_double(Knight) }

  describe "#check_valid_moves" do
    context "When pawn its the first move" do
      xit "returns two forward locations when they are empty" do
        normal_moves = ["3a", "4a"]
        kill_moves = []
        expected_result = normal_moves
        allow(board).to receive(["3a"]).and_return('')
        allow(board).to receive(["4a"]).and_return('')
        allow(pawn).to receive(:first_move).and_return(true)
        possible_moves = pawn.check_valid_moves(normal_moves, kill_moves, board)
        expect(possible_moves).to eq(expected_result)
      end
      xit "returns one forward move if other is blocked" do
        normal_moves = ["3a", "4a"]
        # We leave kill_moves empty because it is not the subject of this test.
        kill_moves = []
        expected_result = ["3a"]
        allow(board).to receive(["3a"]).and_return('')
        allow(board).to receive(["4a"]).and_return(dummy_piece)
        allow(pawn).to receive(:first_move).and_return(true)
        possible_moves = pawn.check_valid_moves(normal_moves, kill_moves, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context "When its not the first move" do
      xit "returns only one possible move if there are no enemy pieces to kill" do
        normal_moves =  ["5b"]
        kill_moves = []
        expected_result = normal_moves
        allow(board).to receive(["5b"]).and_return('')
        allow(pawn).to receive(:first_move).and_return(false)
        possible_moves = pawn.check_valid_moves(normal_moves, kill_moves, board)
        expect(possible_moves).to eq(normal_moves)
      end
    end
    context "When there are enemy pieces to kill" do
      xit "returns enemy piece's location" do
        normal_moves = ["4b"]
        kill_moves = ["4a", "4c"]
        expected_result = kill_moves
        allow(pawn).to receive(:first_move).and_return(false)
        allow(board).to receive(["4a"])
        possible_moves = pawn.check_valid_moves(normal_moves, kill_moves, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end




