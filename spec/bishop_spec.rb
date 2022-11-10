require_relative '../lib/bishop'
require_relative '../lib/board'
require_relative '../lib/pawn'

describe Bishop do
  subject(:bishop) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:dummy_piece) { instance_double(Pawn) }

  before do
    allow(bishop).to receive(:color).and_return('white')
  end

  describe '#generate_top_right_moves' do
    context 'When all top right moves are empty' do
      xit 'returns all valid top-right moves' do
        initial_loc = '1c'
        expected_result = ['2d', '3e', '4f', '5g', '6h']
        allow(board).to receive(:[]).and_return('')
        possible_moves = bishop.generate_top_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When an ally is blocking its way' do
      xit 'returns all valid moves top-right upto ally' do
        initial_loc = '3e'
        expected_result = ['4e', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = bishop.generate_top_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When an enemy is in its way' do
      xit 'returns all top-right moves upto and including enemy\'s location' do
        initial_loc = '1c'
        expected_result = ['2d', '3e', '4f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = bishop.generate_top_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_top_left_moves' do
    context 'When all top-left moves are empty' do
      xit 'returns all valid top-left moves' do
        initial_loc = '1f'
        expected_result = ['2e', '3d', '4c', '5b', '6a']
        allow(board).to receive(:[]).and_return('')
        possible_moves = bishop.generate_top_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      xit 'returns all top-left valid moves upto ally piece' do
        initial_loc = '1f'
        expected_result = ['2e', '3d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = bishop.generate_top_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all top-left moves upto and including enemy\'s location' do
        initial_loc = '1f'
        expected_result = ['2e', '3d', '4c']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = bishop.generate_top_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_right_moves' do
    context 'When all down-right moves are empty' do
      xit 'returns all valid down-right moves' do
        initial_loc = '8c'
        expected_result = ['7d', '6e', '5f', '4g', '3h']
        allow(board).to receive(:[]).and_return('')
        possible_moves = bishop.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      xit 'returns all down-right valid moves upto ally' do
        initial_loc = '8c'
        expected_result = ['7d', '6e']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = bishop.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all down-right valid moves upto and including enemy\'s location' do
        initial_loc = '7d'
        expected_result = ['6e', '5f', '4g']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = bishop.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_left_moves' do
    context 'When all down-left moves are empty' do
      xit 'returns all down-left valid moves' do
        initial_loc = '8f'
        expected_result = ['7e', '6d', '5c', '4b', '3a']
        allow(board).to receive(:[]).and_return('')
        possible_moves = bishop.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its way' do
      xit 'returns all valid down-left moves upto ally' do
        initial_loc = '7e'
        expected_result = ['6d', '5c']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = bishop.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy on its way' do
      xit 'returns all valid down-left moves upto and including enemy\'s location' do
        initial_loc = '4d'
        expected_result = ['3c', '2b', '1a']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = bishop.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end
end
