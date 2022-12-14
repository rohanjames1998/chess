require_relative '../lib/movement'
require_relative '../lib/knight'
require_relative '../lib/board'

describe Movement do
  let(:dummy_class) { Class.new { extend Movement } }
  let(:dummy_piece) { instance_double(Knight) }
  let(:board) { instance_double(Board) }

  before do
    allow(dummy_class).to receive(:color).and_return('white')
  end

  describe '#generate_white_pawn_moves' do
    context 'When its the first move' do
      it 'returns 2 normal moves' do
        first_move = true
        initial_loc = '2a'
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(2)
      end
      it 'first move is two steps front and second is one step front' do
        first_move = true
        initial_loc = '2c'
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
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
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(1)
      end
    end
    context 'When called' do
      it 'returns two kill moves when first_move is true' do
        first_move = true
        initial_loc = '2g'
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[0].length
        expect(kill_moves_length).to eq(2)
      end
      it 'returns two kill moves when first_move is false' do
        first_move = false
        initial_loc = '6g'
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[1].length
        expect(kill_moves_length).to eq(2)
      end
      it 'first kill move is right and the second is left' do
        first_move = false
        initial_loc = '4d'
        moves = dummy_class.generate_white_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[1][0]
        second_suggested_move = moves[1][1]
        expect(first_suggested_move).to eq('5e')
        expect(second_suggested_move).to eq('5c')
      end
    end
  end

  describe "#generate_black_pawn_moves" do
    context 'When its the first move' do
      it 'returns 2 normal moves' do
        first_move = true
        initial_loc = '7a'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(2)
      end
      it 'first move is two steps front and second is one step front' do
        first_move = true
        initial_loc = '7c'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[0][0]
        second_suggested_move = moves[0][1]
        expect(first_suggested_move).to eq('5c')
        expect(second_suggested_move).to eq('6c')
      end
    end
    context 'When its not the first move' do
      it 'returns only 1 normal move' do
        first_move = false
        initial_loc = '5g'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(1)
      end
    end
    context 'When called' do
      it 'returns two kill moves when first_move is true' do
        first_move = true
        initial_loc = '7g'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[0].length
        expect(kill_moves_length).to eq(2)
      end
      it 'returns two kill moves when first_move is false' do
        first_move = false
        initial_loc = '5g'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[1].length
        expect(kill_moves_length).to eq(2)
      end
      it 'first kill move is right and the second is left' do
        first_move = false
        initial_loc = '5d'
        moves = dummy_class.generate_black_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[1][0]
        second_suggested_move = moves[1][1]
        expect(first_suggested_move).to eq('4e')
        expect(second_suggested_move).to eq('4c')
      end
    end
  end

  describe "#generate_left_moves" do
    context "When there are no pieces on the left" do
      it "returns all empty places on the left upto board end" do
        initial_loc = '3h'
        color = 'white'
        expected_result = ["3g", "3f", "3e", "3d", "3c", "3b", "3a"]
        allow(board).to receive(:[]).and_return('')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board, color)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the left" do
      it "returns moves upto ally piece" do
        initial_loc = '3h'
        color = 'white'
        expected_result = ['3g', '3f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board, color)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the left" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '6e'
        color = 'white'
        expected_result = ['6d', '6c', '6b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board, color)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
    context "When called on left most piece" do
      it "doesn't return out of board moves" do
        initial_loc = '2a'
        color = 'white'
        expected_result = []
        potential_left_moves = dummy_class.generate_left_moves(initial_loc, board, color)
        expect(potential_left_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_right_moves" do
    context "When there are no pieces to the right" do
      it "returns all empty places on the right upto board end" do
        initial_loc = '3a'
        color = 'white'
        expected_result = ['3b', '3c', '3d', '3e', '3f', '3g', '3h']
        allow(board).to receive(:[]).and_return('')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board, color)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece to the right" do
      it "returns all potential moves upto ally piece" do
        initial_loc = '4b'
        color = 'white'
        expected_result = ['4c', '4d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board, color)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece to the right" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '5c'
        color = 'white'
        expected_result = ['5d', '5e', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board, color)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
    context "When called on right most piece" do
      it "doesn't return out of board moves" do
        initial_loc = '2h'
        color = 'white'
        expected_result = []
        potential_right_moves = dummy_class.generate_right_moves(initial_loc, board, color)
        expect(potential_right_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_up_moves" do
    context "When there are no piece at top" do
      it "returns all empty top places upto board end" do
        initial_loc = '3a'
        color = 'white'
        expected_result = ['4a', '5a', '6a', '7a', '8a']
        allow(board).to receive(:[]).and_return('')
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board, color)
        expect(potential_top_moves).to eq(expected_result)
      end
    end
    context 'When there are is an ally piece at top' do
      it "returns potential moves upto ally piece" do
        initial_loc = '3h'
        color = 'white'
        expected_result = ['4h', '5h']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board, color)
        expect(potential_top_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece at top" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '3f'
        color = 'white'
        expected_result = ['4f', '5f', '6f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board, color)
        expect(potential_top_moves).to eq(expected_result)
      end
    end
    context "When called on piece that is on top" do
      it "doesn't return out of board moves" do
        initial_loc = '8g'
        color = 'white'
        expected_result = []
        potential_top_moves = dummy_class.generate_up_moves(initial_loc, board, color)
        expect(potential_top_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_down_moves" do
    context "When there are no piece at bot" do
      it "returns all empty bot locations upto board end" do
        initial_loc = '6a'
        color = 'white'
        expected_result = ['5a', '4a', '3a', '2a', '1a']
        allow(board).to receive(:[]).and_return('')
        potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board, color)
        expect(potential_bot_moves).to eq(expected_result)
      end
    end
    context "When there is an ally piece at bot" do
      it "returns all potential moves upto ally piece" do
        initial_loc = '7f'
        color = 'white'
        expected_result = ['6f', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board, color)
        expect(potential_bot_moves).to eq(expected_result)
      end
    end
    context "When there is an enemy piece at bot" do
      it "returns all potential moves including enemy piece's location" do
        initial_loc = '5b'
        color = 'white'
        expected_result = ['4b', '3b', '2b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board, color)
        expect(potential_bot_moves).to eq(expected_result)
      end
    end
    context "When called on piece that is on the bottom" do
      it "doesn't return out of board moves" do
        initial_loc = '1g'
        color = 'white'
        expected_result = []
        potential_bot_moves = dummy_class.generate_down_moves(initial_loc, board, color)
        expect(potential_bot_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_knight_moves" do
    context "When called" do
      it "returns total of 8 moves" do
        initial_loc = '4e'
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

  describe '#generate_top_right_moves' do
    context 'When all top right moves are empty' do
      it 'returns all valid top-right moves upto board end' do
        initial_loc = '1c'
        color = 'white'
        expected_result = ['2d', '3e', '4f', '5g', '6h']
        allow(board).to receive(:[]).and_return('')
        potential_moves = dummy_class.generate_top_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When an ally is blocking its way' do
      it 'returns all valid moves top-right upto ally' do
        initial_loc = '3e'
        color = 'white'
        expected_result = ['4f', '5g']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_moves = dummy_class.generate_top_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When an enemy is in its way' do
      it 'returns all top-right moves upto and including enemy\'s location' do
        initial_loc = '1c'
        color = 'white'
        expected_result = ['2d', '3e', '4f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_moves = dummy_class.generate_top_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When called on piece that is on the top right" do
      it "doesn't return out of board moves" do
        initial_loc = '8h'
        color = 'white'
        expected_result = []
        potential_moves = dummy_class.generate_top_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_top_left_moves' do
    context 'When all top-left moves are empty' do
      it 'returns all valid top-left moves upto board end' do
        initial_loc = '1f'
        color = 'white'
        expected_result = ['2e', '3d', '4c', '5b', '6a']
        allow(board).to receive(:[]).and_return('')
        potential_moves = dummy_class.generate_top_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      it 'returns all top-left valid moves upto ally piece' do
        initial_loc = '1f'
        color = 'white'
        expected_result = ['2e', '3d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_moves = dummy_class.generate_top_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      it 'returns all top-left moves upto and including enemy\'s location' do
        initial_loc = '1f'
        color = 'white'
        expected_result = ['2e', '3d', '4c']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_moves = dummy_class.generate_top_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When on piece that on the top left" do
      it "doesn't return out of board moves" do
        initial_loc = '8a'
        color = 'white'
        expected_result = []
        potential_moves = dummy_class.generate_top_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_right_moves' do
    context 'When all down-right moves are empty' do
      it 'returns all valid down-right moves' do
        initial_loc = '8c'
        color = 'white'
        expected_result = ['7d', '6e', '5f', '4g', '3h']
        allow(board).to receive(:[]).and_return('')
        potential_moves = dummy_class.generate_down_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      it 'returns all down-right valid moves upto ally' do
        initial_loc = '8c'
        expected_result = ['7d', '6e']
        color = 'white'
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_moves = dummy_class.generate_down_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      it 'returns all down-right valid moves upto and including enemy\'s location' do
        initial_loc = '7d'
        expected_result = ['6e', '5f', '4g']
        color = 'white'
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_moves = dummy_class.generate_down_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When called on piece that is on down right corner" do
      it "doesn't return out of board moves" do
        initial_loc = '1h'
        color = 'white'
        expected_result = []
        potential_moves = dummy_class.generate_down_right_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_left_moves' do
    context 'When all down-left moves are empty' do
      it 'returns all down-left valid moves' do
        initial_loc = '8f'
        color = 'white'
        expected_result = ['7e', '6d', '5c', '4b', '3a']
        allow(board).to receive(:[]).and_return('')
        potential_moves = dummy_class.generate_down_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      it 'returns all valid down-left moves upto ally' do
        initial_loc = '7e'
        expected_result = ['6d', '5c']
        color = 'white'
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_moves = dummy_class.generate_down_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy on its way' do
      it 'returns all valid down-left moves upto and including enemy\'s location' do
        initial_loc = '4d'
        expected_result = ['3c', '2b', '1a']
        color = 'white'
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_moves = dummy_class.generate_down_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
    context "When called on piece that is on the down left corner" do
      it "doesn't return out of board moves" do
        initial_loc = '1a'
        color = 'white'
        expected_result = []
        potential_moves = dummy_class.generate_down_left_moves(initial_loc, board, color)
        expect(potential_moves).to eq(expected_result)
      end
    end
  end

  describe "#generate_king_moves" do
    context "When called" do
      it "generates total of 8 moves" do
        initial_loc = '5d'
        moves = dummy_class.generate_king_moves(initial_loc)
        expect(moves.length).to eq(8)
      end
      it "returns 3 forward moves" do
        initial_loc = '3d'
        moves = dummy_class.generate_king_moves(initial_loc)
        top_left = moves[0]
        top = moves[1]
        top_right = moves[2]
        expect(top_left).to eq('4c')
        expect(top).to eq('4d')
        expect(top_right).to eq('4e')
      end
      it "returns left and right moves" do
        initial_loc = '6c'
        moves = dummy_class.generate_king_moves(initial_loc)
        left = moves[3]
        right = moves[4]
        expect(left).to eq('6b')
        expect(right).to eq('6d')
      end
      it "returns 3 backward moves" do
        initial_loc = '4f'
        moves = dummy_class.generate_king_moves(initial_loc)
        down_left = moves[5]
        down = moves[6]
        down_right = moves[7]
        expect(down_left).to eq('3e')
        expect(down).to eq('3f')
        expect(down_right).to eq('3g')
      end
    end
  end

  describe "#remove_out_of_board_moves" do
    context "When called with some moves that are out of board" do
      it "removes out of board moves and leaves valid moves" do
        all_moves = ['1e', '0c', '-1d', '3k']
        expected_result = ['1e']
        result = dummy_class.remove_out_of_board_moves(all_moves)
        expect(result).to eq(expected_result)
      end
    end
  end
end
