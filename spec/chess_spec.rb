require_relative '../lib/chess'

describe Chess do

  describe "#valid_location?" do
    subject(:chess_location_check) { described_class.new }
    context "When given location's format is valid" do
      xit "returns true" do
        valid_loc = "2b"
        returned_val = chess_location_check.valid_location?(valid_loc)
        expect(returned_val).to eq(true)
      end
    end
    context "When given location conforms to game standard but doesn't exist on the board" do
      xit "returns false when location is too high" do
        high_loc = "9l"
        returned_val = chess_location_check.valid_location?(high_loc)
        expect(returned_val).to eq(false)
      end
    end
    context "When location format is invalid" do
      xit "returns false" do
      invalid_loc = "12a"
      returned_val = chess_location_check.valid_location?(invalid_loc)
      expect(returned_val).to eq(false)
      end
    end
  end
end


