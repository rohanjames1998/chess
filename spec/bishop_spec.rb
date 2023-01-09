require_relative '../lib/bishop'

describe Bishop do
  subject(:bishop) { described_class.new }

  describe '#white' do
    context 'When called' do
      it 'makes bishop white' do
        bishop.white
        expect(bishop.color).to eq('white')
        expect(bishop.unicode).to eq("\u2657")
      end
    end
  end

  describe '#black' do
    context 'When called' do
      it 'makes bishop black' do
        bishop.black
        expect(bishop.color).to eq('black')
        expect(bishop.unicode).to eq("\u265d")
      end
    end
  end
end
