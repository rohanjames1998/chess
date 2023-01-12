require_relative '../lib/player'

describe Player do

  before do
    allow(STDOUT).to receive(:puts)
  end

  subject(:player) { described_class.new }

  describe "#white" do
    context "When called" do
      it "sets color to white" do
        player.white
        expect(player.color).to eq('white')
      end
      it "sets king_loc to '1e'" do
        player.white
        expect(player.king_loc).to eq('1e')
      end
    end
  end

  describe "#black" do
    context "When called" do
      it "sets color to black" do
        player.black
        expect(player.color).to eq('black')
      end
      it "sets king_loc to '1e'" do
        player.black
        expect(player.king_loc).to eq('8e')
      end
    end
  end


  describe '#get_name' do
    context 'When name is longer than 10 characters' do
      it 'restarts the loop until valid name is given' do
        invalid_name = 'fyodor dostoyevsky'
        valid_name = 'charlie'
        allow(player).to receive(:gets).and_return(invalid_name, valid_name)
        expect(player).to receive(:gets).twice
        player.get_name
      end
    end

    context 'When valid name is given' do
      it 'sets player.name to the name given' do
        valid_name = 'Charles'
        allow(player).to receive(:gets).and_return(valid_name)
        player.get_name
        expect(player.name).to eq(valid_name)
      end
    end
  end
end
