require_relative '../lib/knight'
require_relative '../lib/pawn'

describe Knight do
  subject(:knight) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:dummy_piece) { instance_double(Pawn) }

  before do
    allow(knight).to receive(:color).and_return('white')

  describe '#check_valid_moves' do
    context 'When all eight possible moves are possible' do
      xit "returns all 8 possible moves" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return('')
        possible_moves = knight.check_valid_moves(all_moves, board)
        expect(possible_moves).to eq(all_moves)
      end
    end
    context "When there is an ally piece that blocks a move" do
      xit "returns every move except the one blocked ally piece" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return(dummy_ele, '')
        allow(dummy_ele).to receive(:color).and_return('white')
        possible_moves = knight.check_valid_moves(all_moves, board)
        expect(possible_moves).not_to include('6e')
      end
    end
    context "When there is an enemy piece knight can kill" do
      xit "returns enemy's location as one of the possible move" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to_receive(:[]).and_return(dummy_ele, '')
        allow(dummy_ele).to receive(:color).and_return('black')
        possible_moves = knight.check_valid_moves(all_moves, board)
        expect(possible_moves).to include('6e')
      end
    end
  end
end

