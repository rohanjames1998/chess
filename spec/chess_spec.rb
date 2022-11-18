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
    before do
      allow(chess_game).to receive(:get_player_move)
    end
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
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(chess_game).to receive(:gets).and_return(invalid_input, valid_input)
        expect(chess_game).to receive(:gets).twice
        chess_game.get_player_piece(player)
      end
    end
  end

  describe "#get_input" do

    RSpec::Matchers.define :have_any_upcase_letters do
      match do |string|
        string.each_char do |letter|
          return true if /[A-Z]/.match(letter)
        end
        return false
      end
    end

    context "When players enters a string with some space in it" do
      it "returns a string without any space" do
        player_input = '1 f '
        allow(chess_game).to receive(:gets).and_return(player_input)
        returned_val = chess_game.get_input
        expect(returned_val).not_to include(' ')
      end
    end
    context "When player enters a string with uppercase letters" do
      it "returns a string with no upcase letters" do
        player_input = '7C'
        allow(chess_game).to receive(:gets).and_return(player_input)
        returned_val = chess_game.get_input
        expect(returned_val).not_to have_any_upcase_letters
      end
    end
  end

  describe "#get_player_move" do
    # Since we will have another function (#valid_move?) which checks player move.
    # We will only test the functionality of the loop in this test.
    before do
      allow(chess_game).to receive(:display_potential_moves)
      allow(chess_game).to receive(:get_input)
      allow(chess_game).to receive(:move_piece)
      allow(chess_game).to receive(:remove_potential_moves)
    end
    context "When given valid move" do
      it "breaks the loop" do
        # This is the piece player previously choose.
        piece_to_move = '2a'
        allow(chess_game).to receive(:valid_move?).and_return(true)
        expect(chess_game).to receive(:get_input).once
        chess_game.get_player_move(player, piece_to_move)
      end
    end
    context "When player wants to choose another piece to move" do
      it "calls #get_player_piece and breaks the loop" do
        # In order to choose another piece player needs to enter 'x'.
        player_choice = 'x'
        piece_to_move = '7h'
        allow(chess_game).to receive(:get_input).and_return(player_choice)
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(dummy_piece).to receive(:generate_potential_moves)
        expect(chess_game).to receive(:get_player_piece).once
        chess_game.get_player_move(player, piece_to_move)
      end
    end
    context "When given invalid move" do
      it "restarts the loop until valid move is given" do
        piece_to_move = '1h'
        allow(chess_game).to receive(:valid_move?).and_return(false, false, true)
        expect(chess_game).to receive(:get_input).exactly(3).times
        chess_game.get_player_move(player, piece_to_move)
      end
    end
  end

  describe "#display_potential_moves" do

    context "When called" do
      it "adds potential move indicator symbol on board where player can their piece" do
        indicator ="\u2718"
        potential_moves = ['4a', '3a']
        board = chess_game.board
        chess_game.display_potential_moves(potential_moves)
        result = potential_moves.all? { |move| board[move] == indicator }
        expect(result).to eq(true)
      end
    end
  end

  describe "#valid_move?" do
    before do
    allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
    end
    context "When given move has invalid format" do
      it "returns false" do
        piece = '2a'
        invalid_move = '9i'
        allow(dummy_piece).to receive(:generate_potential_moves)
        returned_val = chess_game.valid_move?(invalid_move, piece)
        expect(returned_val).to eq(false)
      end
    end
    context "When given move is not included in possible moves" do
      it "returns false" do
      piece = '2a'
      move = '5a'
      possible_moves = ['3a', '4a']
      allow(dummy_piece).to receive(:generate_potential_moves).and_return(possible_moves)
      returned_val = chess_game.valid_move?(move, piece)
      expect(returned_val).to eq(false)
      end
    end
    context "When given input is valid and included in possible moves" do
      it "returns true" do
        piece = '7a'
        valid_move = '6a'
        possible_moves = ['6a', '5a']
        allow(dummy_piece).to receive(:generate_potential_moves).and_return(possible_moves)
        returned_val = chess_game.valid_move?(valid_move, piece)
        expect(returned_val).to eq(true)
      end
    end
  end

  describe "#move_piece" do
    context "When called" do
      it "places the piece to given location" do
        piece = "2a"
        move = "3a"
        chess_game.board[piece] = dummy_piece
        chess_game.move_piece(move, piece)
        expect(chess_game.board['3a']).to eq(dummy_piece)
      end
      it "removes piece from its previous location" do
        piece = "6c"
        move = "5c"
        chess_game.move_piece(move, piece)
        expect(chess_game.board[move]).to eq('')
      end
    end
  end

  describe "#remove_potential_moves_indicator" do
    context "When called" do
      xit "Removes all potential move indicators from the board" do
        potential_moves = ['4a', '5a', '6a']
        board = chess_game.board
        indicator ="\u2718"
        board['4a'] = indicator
        board['5a'] = indicator
        board['6a'] = indicator
        chess_game.remove_potential_moves_indicator(potential_moves)
        result = potential_moves.all? { |move| board[move] == '' }
        expect(result).to eq(true)
      end
    end
  end
end


