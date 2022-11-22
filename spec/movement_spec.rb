require_relative '../lib/movement'
require_relative '../lib/knight'
require_relative '../lib/board'

describe Movement do
  let (:dummy_class) { Class.new { extend Movement } }
  let (:dummy_piece) { instance_double(Knight) }
  let(:board) { instance_double(Board) }


  before do
    allow(dummy_class).to receive(:color).and_return('white')
  end

  describe '#generate_pawn_moves' do
    context 'When its the first move' do
      it 'returns 2 normal moves' do
        first_move = true
        initial_loc = '2a'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(2)
      end
      it 'first move is two steps front and second is one step front' do
        first_move = true
        initial_loc = '2c'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[0][0]
        second_suggested_move = moves[0][1]
        expect(first_suggested_move).to eq('4c')
        expect(second_suggested_move).to eq('3c')
      end
    end
    context 'When its not the first move' do
      it 'returns only 1 normal move' do
        first_move = false
        initial_loc = '4g'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(1)
      end
    end
    context 'When called' do
      it 'returns two kill moves when first_move is true' do
        first_move = true
        initial_loc = '2g'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[0].length
        expect(kill_moves_length).to eq(2)
      end
      it 'returns two kill moves when first_move is false' do
        first_move = false
        initial_loc = '6g'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[1].length
        expect(kill_moves_length).to eq(2)
      end
      it 'first kill move is right and the second is left' do
        first_move = false
        initial_loc = '4d'
        moves = dummy_class.generate_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[1][0]
        second_suggested_move = moves[1][1]
        expect(first_suggested_move).to eq('5e')
        expect(second_suggested_move).to eq('5c')
      end
    end
  end

  describe "#generate_left_moves" do
    context "When there are no pieces on the left" do
      it "returns all empty places on the left upto board end" do
        initial_loc = '3h'
        expected_result = ["3g", "3f", "3e", "3d", "3c", "3b", "3a"]
        allow(board).to receive(:[]).and_return('')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the left" do
      it "returns moves upto ally piece" do
        initial_loc = '3h'
        expected_result = ['3g', '3f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the left" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '6e'
        expected_result = ['6d', '6c', '6b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_right_moves" do
    context "When there are no pieces to the right" do
      it "returns all empty places on the right upto board end" do
        initial_loc = '3a'
        expected_result = ['3b', '3c', '3d', '3e', '3f', '3g', '3h']
        allow(board).to receive(:[]).and_return('')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the right" do
      it "returns all potential moves upto ally piece" do
        initial_loc = '4b'
        expected_result = ['4c', '4d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the right" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '5c'
        expected_result = ['5d', '5e', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_up_moves" do
    context "When there are no piece at top" do
      it "returns all empty top places upto board end" do
        initial_loc = '3a'
        expected_result = ['4a', '5a', '6a', '7a', '8a']
        allow(board).to receive(:[]).and_return('')
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board)
        expect(potential_top_moves).to eq(expected_result)
      end
    end
    context 'When there are is an ally piece at top' do
      it "returns potential moves upto ally piece" do
      initial_loc = '3h'
      expected_result = ['4h', '5h']
      allow(board).to receive(:[]).and_return('', '', dummy_piece)
      allow(dummy_piece).to receive(:color).and_return('white')
      potential_top_moves = dummy_class.generate_up_moves(initial_loc, board)
      expect(potential_top_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece at top" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '3f'
        expected_result = ['4f', '5f', '6f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board)
        expect(potential_top_moves).to eq(expected_result)
      end
    end

    describe "#generate_up_moves" do
      context "When there are no piece at bot" do
        it "returns all empty bot locations upto board end" do
          initial_loc = '6a'
          expected_result = ['5a', '4a', '3a', '2a', '1a']
          allow(board).to receive(:[]).and_return('')
          potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board)
          expect(potential_bot_moves).to eq(expected_result)
        end
      end
      context "When there is an ally piece at bot" do
        it "returns all potential moves upto ally piece" do
        initial_loc = '7f'
        expected_result = ['6f', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board)
        expect(potential_bot_moves).to eq(expected_result)
        end
      end
      context "When there is an enemy piece at bot" do
        it "returns all potential moves including enemy piece's location" do
          initial_loc = '5b'
          expected_result = ['4b', '3b', '2b']
          allow(board).to receive(:[]).and_return('', '', dummy_piece)
          allow(dummy_piece).to receive(:color).and_return('black')
          potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board)
          expect(potential_bot_moves).to eq(expected_result)
        end
      end
    end
  end

  describe "#generate_knight_moves" do
    context "When called" do
      it "returns total of 8 moves" do
        initial_loc = '3a'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves.length).to eq(8)
      end
      it "returns a move for top left" do
        initial_loc = '4d'
        top_left = '6c'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[0]).to eq(top_left)
      end
      it "returns a move for top right" do
        initial_loc = '4d'
        top_right = '6e'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[1]).to eq(top_right)
      end
      it "returns a move for down left" do
        initial_loc = '3f'
        down_left = '1e'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[2]).to eq(down_left)
      end
      it "returns a move for down right" do
        initial_loc = '3f'
        down_right = '1g'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[3]).to eq(down_right)
      end
      it "returns a move for right right up" do
        initial_loc = '5e'
        right_right_up = '6g'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[4]).to eq(right_right_up)
      end
      it "returns a move for left left up" do
        initial_loc = '5e'
        left_left_up = '6c'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[5]).to eq(left_left_up)
      end
      it "returns a move for right right down" do
        initial_loc = '4f'
        right_right_down = '3h'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[6]).to eq(right_right_down)
      end
      it "returns a move for left left down" do
        initial_loc = '4f'
        left_left_down = '3d'
        moves = dummy_class.generate_knight_moves(initial_loc)
        expect(moves[7]).to eq(left_left_down)
      end
    end
  end
end


