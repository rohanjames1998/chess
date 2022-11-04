require_relative '../lib/chess'

describe Chess do

  before do
    # This line is to clear out any puts statement that might clutter
    # our test result in console.
    allow(STDOUT).to receive(:puts)
  end

  describe "#valid_location?" do
    subject(:chess_location_check) { described_class.new }
    context "When given location's format is valid" do
      it "returns true" do
        valid_loc = "2b"
        returned_val = chess_location_check.valid_location?(valid_loc)
        expect(returned_val).to eq(true)
      end
    end
    context "When given location conforms to game standard but doesn't exist on the board" do
      it "returns false when location is too high" do
        high_loc = "1l"
        returned_val = chess_location_check.valid_location?(high_loc)
        expect(returned_val).to eq(false)
      end

      it "returns false when location is too low" do
        low_loc = "0c"
        returned_val = chess_location_check.valid_location?(low_loc)
        expect(returned_val).to eq(false)
      end
    end
    context "When location format is invalid" do
      it "returns false" do
      invalid_loc = "12a"
      returned_val = chess_location_check.valid_location?(invalid_loc)
      expect(returned_val).to eq(false)
      end
    end
  end

  describe "#get_player_piece" do
    subject(:choosing_piece_chess) { described_class.new }
    let(:player) { instance_double(Player) }
    before do
      choosing_piece_chess.board.add_new_pieces_to_board
    end

    context "When given valid input" do
      xit "sets player.chosen_piece to unicode at given location" do
        valid_input = "1a"
        unicode_at_loc = "\u2656"
        allow(choosing_piece_chess).to receive(:gets).and_return(valid_input)
        choosing_piece_chess.get_player_piece(player)
        expect(player.chosen_piece).to eq(unicode_at_loc)
      end
    end

    context "When given invalid input" do
      xit "restarts the loop until valid input is given" do
        invalid_input = "5p"
        valid_input = "7b"
        allow(choosing_piece_chess).to receive(:gets).and_return(invalid_input, valid_input)
        expect(choosing_piece_chess).to receive(:gets).twice
      end
    end
  end
end


