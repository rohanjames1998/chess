require_relative "../lib/rook"
require_relative "../lib/board"
require_relative "../lib/knight"

describe Rook do
  subject(:rook) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:dummy_piece) { instance_double(Knight) }

  before do
    allow(rook).to receive(:color).and_return('white')
  end

  describe "#generate_left_moves" do
    context "When there are no pieces on the left" do
      xit "returns all empty places on the left" do
        initial_loc = '3h'
        expected_result = ["3g", "3f", "3e", "3d", "3c", "3b", "3a"]
        allow(board).to receive(:[]).and_return('')
        possible_left_moves = rook.generate_left_moves(initial_loc, board)
        expect(possible_left_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the left" do
      xit "returns moves upto ally piece" do
        initial_loc = '3h'
        expected_result = ['3g', '3f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_left_moves = rook.generate_left_moves(initial_loc, board)
        expect(possible_left_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the left" do
      xit "returns all possible moves including enemy piece's location" do
        initial_loc = '6e'
        expected_result = ['6d', '6c', '6b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return(black)
        possible_left_moves = rook.generate_left_moves(initial_loc, board)
        expect(possible_left_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_right_moves" do
    context "When there are no pieces to the right" do
      xit "returns all empty places on the right" do
        initial_loc = '3a'
        expected_result = ['3b', '3c', '3d', '3e', '3f', '3g', '3h']
        allow(board).to receive(:[]).and_return('')
        possible_right_moves = rook.generate_right_moves(initial_loc, board)
        expect(possible_right_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the right" do
      xit "returns all possible moves upto ally piece" do
        initial_loc = '4b'
        expected_result = ['4c', '4d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_right_moves = rook.generate_right_moves(initial_loc, board)
        expect(possible_right_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the right" do
      xit "returns all possible moves including enemy piece's location" do
        initial_loc = '5c'
        expected_result = ['5d', '5e', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_right_moves = rook.generate_right_moves(initial_loc, board)
        expect(possible_right_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_top_moves" do
    context "When there are no piece at top" do
      xit "returns all empty top places" do
        initial_loc = '3a'
        expected_result = ['4a', '5a', '6a', '7a', '8a']
        allow(board).to receive(:[]).and_return('')
        possible_top_moves = rook.generate_top_moves(initial_loc, board)
        expect(possible_top_moves).to eq(expected_result)
      end
    end
    context 'When there are is an ally piece at top' do
      xit "returns possible moves upto ally piece" do
      initial_loc = '3h'
      expected_result = ['4h', '5h']
      allow(board).to receive(:[]).and_return('', '', dummy_piece)
      allow(dummy_piece).to receive(:color).and_return('white')
      possible_top_moves = rook.generate_top_moves(initial_loc, board)
      expect(possible_top_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece at top" do
      xit "returns all possible moves including enemy piece's location" do
        initial_loc = '3f'
        expected_result = ['4f', '5f', '6f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_top_moves = rook.generate_top_moves(initial_loc, board)
        expect(possible_top_moves).to eq(expected_result)
      end
    end

    describe "#generate_bot_moves" do
      context "When there are no piece at bot" do
        xit "returns all empty bot locations" do
          initial_loc = '6a'
          expected_result = ['5a', '4a', '3a', '2a', '1a']
          allow(board).to receive(:[]).and_return('')
          possible_bot_moves = rook.generate_bot_moves(initial_loc, board)
          expect(possible_bot_moves).to eq(expected_result)
        end
      end
      context "When there is an ally piece at bot" do
        xit "returns all possible moves upto ally piece" do
        initial_loc = '7f'
        expected_result = ['6f', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_bot_moves = rook.generate_bot_moves(initial_loc, board)
        expect(possible_bot_moves).to eq(expected_result)
        end
      end
      context "When there is an enemy piece at bot" do
        xit "returns all possible moves including enemy piece's location" do
          initial_loc = '5b'
          expected_result = ['4b', '3b', '2b']
          allow(board).to receive(:[]).and_return('', '', dummy_piece)
          allow(dummy_piece).to receive(:color).and_return('black')
          possible_bot_moves = rook.generate_bot_moves(initial_loc, board)
          expect(possible_bot_moves).to eq(expected_result)
        end
      end
    end
  end
end

