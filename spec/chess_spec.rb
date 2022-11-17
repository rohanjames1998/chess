require_relative '../lib/chess'

describe Chess do

  subject(:chess_game) { described_class.new }
  let(:player) { instance_double(Player) }
  let(:dummy_piece) { instance_double(Pawn) }

  before do
    # Removing all output statements from console.
    allow(STDOUT).to receive(:puts)
    chess_game.board.add_new_pieces_to_board
    allow(player).to receive(:color).and_return('white')
    allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
    allow(dummy_piece).to receive(:color).and_return('white')
  end

  describe "#valid_input?" do
    context "When given location's format is valid" do
      it "returns true" do
        valid_loc = "2b"
        returned_val = chess_game.valid_input?(valid_loc, player)
        expect(returned_val).to eq(true)
      end
    end
    context "When given location conforms to game standard but doesn't exist on the board" do
      it "returns false when location is too high" do
        high_loc = "1l"
        returned_val = chess_game.valid_input?(high_loc, player)
        expect(returned_val).to eq(false)
      end

      it "returns false when location is too low" do
        low_loc = "0c"
        returned_val = chess_game.valid_input?(low_loc, player)
        expect(returned_val).to eq(false)
      end
    end
    context "When location format is invalid" do
      it "returns false" do
      invalid_loc = "12a"
      returned_val = chess_game.valid_input?(invalid_loc, player)
      expect(returned_val).to eq(false)
      end
    end
    context "When player's color match the color of piece" do
      it "returns true" do
        input = '1b'
        allow(player).to receive(:color).and_return('white')
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        returned_val = chess_game.valid_input?(input, player)
        expect(returned_val).to eq(true)
      end
    end
    context "When player's color don't match the color of piece" do
      it "returns false" do
        input = '1b'
        allow(player).to receive(:color).and_return('white')
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        returned_val = chess_game.valid_input?(input, player)
        expect(returned_val).to eq(false)
      end
    end
  end

  describe "#get_player_piece" do
    context "When given valid input" do
      it "breaks the loop" do
        valid_input = "1a"
        allow(chess_game).to receive(:gets).and_return(valid_input)
        expect(chess_game).to receive(:gets).once
        chess_game.get_player_piece(player)
      end
    end
    context "When given invalid input" do
      it "restarts the loop until valid input is given" do
        invalid_input = "5p"
        valid_input = "7b"
        allow(chess_game).to receive(:gets).and_return(invalid_input, valid_input)
        expect(chess_game).to receive(:gets).twice
        chess_game.get_player_piece(player)
      end
    end
  end

  describe "#get_input" do

    RSpec::Matchers.define :have_any_upcase_letters do
      match do |string|
        string.each do |letter|
          if letter == letter.upcase
            return true
          end
        end
        return false
      end

    context "When players enters a string with some space in it" do
      xit "returns a string without any space" do
        player_input = '1 f '
        allow(chess_game).to receive(:gets).and_return(player_input)
        returned_val = chess_game.get_input
        expect(returned_val).not_to include(' ')
      end
    end
    context "When player enters a string with uppercase letters" do
      xit "returns a string with no upcase letters" do
        player_input = '7C'
        allow(chess_game).to receive(:gets).and_return(player_input)
        returned_val = chess_game.get_input
        expect(returned_val).not_to have_any_upcase_letters
      end
    end
  end

  # describe "#get_player_move" do
  #   context "When given valid move" do
  #     before do
  #       allow(dummy_piece).to receive(generate_possible_moves).and_return([])
  #       allow()
  #     xit "calls #move_piece" do
  #       valid_move =
end


