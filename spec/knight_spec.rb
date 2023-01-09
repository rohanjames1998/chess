require_relative '../lib/knight'
require_relative '../lib/pawn'

describe Knight do
  subject(:knight) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:dummy_piece) { instance_double(Pawn) }

  describe '#white' do
    context 'When called' do
      it 'makes knight white' do
        knight.white
        expect(knight.color).to eq('white')
        expect(knight.unicode).to eq("\u2658")
      end
    end
  end

  describe '#black' do
    context 'When called' do
      it 'makes knight black' do
        knight.black
        expect(knight.color).to eq('black')
        expect(knight.unicode).to eq("\u265e")
      end
    end
  end

  describe '#check_valid_moves' do
    before do
      allow(knight).to receive(:color).and_return('white')
    end
    context 'When all eight potential moves are potential' do
      it "returns all 8 potential moves" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return('')
        potential_moves = knight.check_valid_moves(all_moves, board)
        expect(potential_moves).to eq(all_moves)
      end
    end
    context "When there is an ally piece that blocks a move" do
      it "returns every valid move except the one blocked by ally piece" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return(dummy_piece, '')
        allow(dummy_piece).to receive(:color).and_return('white')
        potential_moves = knight.check_valid_moves(all_moves, board)
        expect(potential_moves).not_to include("6e")
      end
    end
    context "When there is an enemy piece knight can kill" do
      it "returns enemy's location as one of the potential move" do
        all_moves = ['6e', '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return(dummy_piece, '')
        allow(dummy_piece).to receive(:color).and_return('black')
        potential_moves = knight.check_valid_moves(all_moves, board)
        expect(potential_moves).to include('6e')
      end
    end
    context "When one of the moves is invalid (i.e., outside the board)" do
      it "returns all moves except invalid move" do
        invalid_move = '0e'
        all_moves = [invalid_move, '6c', '2e', '2c', '3f', '5f', '3b', '5b']
        allow(board).to receive(:[]).and_return(nil, '')
        potential_moves = knight.check_valid_moves(all_moves, board)
        expect(potential_moves).not_to include(invalid_move)
      end
    end
  end
end

