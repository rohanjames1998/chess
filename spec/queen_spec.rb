require_relative '../lib/queen'
require_relative '../lib/board'
require_relative '../lib/pawn'

describe Queen do
  subject(:queen) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:dummy_piece) { instance_double(Pawn) }

  before do
    allow(queen).to receive(:color).and_return('white')
  end

  describe "#generate_up_moves" do
    context 'When all top places are empty' do
      xit 'returns all empty places upto board end' do
        initial_loc = '1d'
        expected_result = ['2d', '3d', '4d', '5d', '6d', '7d', '8d']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_up_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When an ally is blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '3b'
        expected_result = ['4b', '5b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_up_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When an enemy is on its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '4f'
        expected_result = ['5f', '6f', '7f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_up_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_up_right_moves' do
    context 'When all top right places are empty' do
      xit 'returns all empty top right location upto board end' do
        initial_loc = '1d'
        expected_result = ['2e', '3f', '4g', '5h']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_up_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '4a'
        expected_result = ['5b', '6c']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_up_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '3e'
        expected_result = ['4f', '5g', '6h']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_up_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_up_left_moves' do
    context 'When all top left places are empty' do
      xit 'returns all empty top left location upto board end' do
        initial_loc = '2g'
        expected_result = ['3f', '4e', '5d', '6c', '7b', '8a']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_up_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '5g'
        expected_result = ['6f', '7e']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_up_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '4e'
        expected_result = ['5d', '6c', '7b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_up_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_right_moves' do
    context 'When all right places are empty' do
      xit 'returns all empty right location upto board end' do
        initial_loc = '3a'
        expected_result = ['3b', '3c', '3d', '3e', '3f', '3g']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '5d'
        expected_result = ['5e', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '7b'
        expected_result = ['7c', '7d', '7e']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_moves' do
    context 'When all bottom places are empty' do
      xit 'returns all empty bottom location upto board end' do
        initial_loc = '8d'
        expected_result = ['7d', '6d', '5d', '4d', '3d', '2d', '1d']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_down_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '7f'
        expected_result = ['6f', '5f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_down_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '5e'
        expected_result = ['4e', '3e', '2e']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_down_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_right_moves' do
    context 'When all down right places are empty' do
      xit 'returns all empty down right location upto board end' do
        initial_loc = '6b'
        expected_result = ['5c', '4d', '3e', '2f', '3g', '1h']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '5d'
        expected_result = ['4e', '3f']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '7a'
        expected_result = ['6b', '5c', '4d']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_down_right_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_down_left_moves' do
    context 'When all down left places are empty' do
      xit 'returns all empty down left location upto board end' do
        initial_loc = '8h'
        expected_result = ['7g', '6f', '5e', '4d', '3c', '2b', '1a']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '6d'
        expected_result = ['5c', '4b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '4f'
        expected_result = ['3e', '2d', '1c']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_down_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end

  describe '#generate_left_moves' do
    context 'When all left places are empty' do
      xit 'returns all empty left location upto board end' do
        initial_loc = '4h'
        expected_result = ['4g', '4f', '4e', '4d', '4c', '4b', '4a']
        allow(board).to receive(:[]).and_return('')
        possible_moves = queen.generate_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an ally blocking its path' do
      xit 'returns all moves upto ally' do
        initial_loc = '5d'
        expected_result = ['5c', '5b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        possible_moves = queen.generate_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
    context 'When there is an enemy in its way' do
      xit 'returns all moves upto and including enemy\'s location' do
        initial_loc = '7e'
        expected_result = ['7d', '7c', '7b']
        allow(board).to receive(:[]).and_return('', '', dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        possible_moves = queen.generate_left_moves(initial_loc, board)
        expect(possible_moves).to eq(expected_result)
      end
    end
  end
end
