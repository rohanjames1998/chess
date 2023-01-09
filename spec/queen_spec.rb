require_relative '../lib/queen'

describe Queen do
  subject(:queen) { described_class.new }

  describe '#white' do
    context 'When called' do
      it 'makes queen white' do
        queen.white
        expect(queen.color).to eq('white')
        expect(queen.unicode).to eq("\u2655")
      end
    end
  end

  describe '#black' do
    context 'When called' do
      it 'makes queen black' do
        queen.black
        expect(queen.color).to eq('black')
        expect(queen.unicode).to eq("\u265b")
      end
    end
  end
end
