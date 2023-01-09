require_relative '../lib/rook'

describe Rook do
  subject(:rook) { described_class.new }

  describe '#white' do
    context 'When called' do
      it 'makes rook white' do
        rook.white
        expect(rook.color).to eq('white')
        expect(rook.unicode).to eq("\u2656")
      end
    end
  end

  describe '#black' do
    context 'When called' do
      it 'makes rook black' do
        rook.black
        expect(rook.color).to eq('black')
        expect(rook.unicode).to eq("\u265c")
      end
    end
  end
end
