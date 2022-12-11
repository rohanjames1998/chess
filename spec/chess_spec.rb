require_relative '../lib/chess'

describe Chess do

  subject(:chess_game) { described_class.new }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:dummy_piece) { instance_double(Pawn) }
  let(:king) { instance_double(King) }
  let(:board) { instance_double(Board) }

  before do
    # Removing all output statements from console.
    allow(STDOUT).to receive(:puts)
    chess_game.board.add_new_pieces_to_board
    allow(player1).to receive(:name).and_return('podrick')
    allow(player1).to receive(:color).and_return('white')
    allow(player1).to receive(:king_loc).and_return('1c')
    allow(player2).to receive(:name).and_return('brienne')
    allow(player2).to receive(:color).and_return('black')
    allow(player2).to receive(:king_loc).and_return('8c')
    allow(dummy_piece).to receive(:color).and_return('white')
    allow(board).to receive(:grid).and_return(Hash.new)
  end

  describe "#valid_input?" do
    context "When given valid input" do
      it "returns true" do
        valid_loc = '3c'
        allow(chess_game).to receive(:valid_format?).and_return(true)
        allow(chess_game).to receive(:valid_choice?).and_return(true)
        result = chess_game.valid_input?(valid_loc, player1)
        expect(result).to eq(true)
      end
    end
    context "When format is invalid" do
      it "returns false" do
        invalid_format = "a6"
        allow(chess_game).to receive(:valid_format?).and_return(false)
        allow(chess_game).to receive(:valid_choice?).and_return(false)
        result = chess_game.valid_input?(invalid_format, player1)
        expect(result).to eq(false)
      end
    end
    context "When format is valid but color doesn't match" do
      it "returns false" do
        invalid_choice = '7c'
        allow(chess_game).to receive(:valid_format?).and_return(true)
        allow(chess_game).to receive(:valid_choice?).and_return(false)
        result = chess_game.valid_input?(invalid_choice, player1)
        expect(result).to eq(false)
      end
    end
  end


  describe "#valid_format?" do
    context "When given location's format is valid" do
      it "returns true" do
        valid_loc = "2b"
        returned_val = chess_game.valid_format?(valid_loc)
        expect(returned_val).to eq(true)
      end
    end
    context "When given location conforms to game standard but doesn't exist on the board" do
      it "returns false when location is too high" do
        high_loc = "1l"
        returned_val = chess_game.valid_format?(high_loc)
        expect(returned_val).to eq(false)
      end

      it "returns false when location is too low" do
        low_loc = "0c"
        returned_val = chess_game.valid_format?(low_loc)
        expect(returned_val).to eq(false)
      end
    end
    context "When location format is invalid" do
      it "returns false" do
      invalid_loc = "12a"
      returned_val = chess_game.valid_format?(invalid_loc)
      expect(returned_val).to eq(false)
      end
    end
  end

  describe "valid_choice?" do
    context "When player's color match the color of piece" do
      it "returns true" do
        input = '1b'
        allow(player1).to receive(:color).and_return('white')
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('white')
        returned_val = chess_game.valid_choice?(input, player1)
        expect(returned_val).to eq(true)
      end
    end
    context "When player's color don't match the color of piece" do
      it "returns false" do
        input = '1b'
        allow(player1).to receive(:color).and_return('white')
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(dummy_piece).to receive(:color).and_return('black')
        returned_val = chess_game.valid_choice?(input, player1)
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
        chess_game.get_player_piece(player1)
      end
    end
    context "When given invalid input" do
      it "restarts the loop until valid input is given" do
        invalid_input = "5p"
        valid_input = "7b"
        allow(chess_game.board).to receive(:[]).and_return(dummy_piece)
        allow(chess_game).to receive(:gets).and_return(invalid_input, valid_input)
        expect(chess_game).to receive(:gets).twice
        chess_game.get_player_piece(player1)
      end
    end
    context "When player wants to quit the game" do
      it "returns 'quit'" do
        input = 'quit'
        allow(chess_game).to receive(:gets).and_return(input)
        result = chess_game.get_player_piece(player1)
        expect(result).to eq(input)
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
        chess_game.get_player_move(player1, piece_to_move)
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
        allow(chess_game).to receive(:remove_potential_moves_indicator)
        expect(chess_game).to receive(:round).once
        chess_game.get_player_move(player1, piece_to_move)
      end
    end
    context "When given invalid move" do
      it "restarts the loop until valid move is given" do
        piece_to_move = '1h'
        allow(chess_game).to receive(:valid_move?).and_return(false, false, true)
        expect(chess_game).to receive(:get_input).exactly(3).times
        chess_game.get_player_move(player1, piece_to_move)
      end
    end
    context "When player wants to quit the game" do
      it "doesn't run this function" do
        piece_to_move = 'quit'
        expect(chess_game).not_to receive(:get_input)
        chess_game.get_player_move(player1, piece_to_move)
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
        potential_moves = ['3a', '4a']
        invalid_move = '9i'
        allow(chess_game).to receive(:valid_format?).and_return(false)
        returned_val = chess_game.valid_move?(invalid_move, piece, potential_moves)
        expect(returned_val).to eq(false)
      end
    end
    context "When given move is not included in potential moves" do
      it "returns false" do
      piece = '2a'
      move = '5a'
      potential_moves = ['3a', '4a']
      returned_val = chess_game.valid_move?(move, piece, potential_moves)
      expect(returned_val).to eq(false)
      end
    end
    context "When given input is valid and included in potential moves" do
      it "returns true" do
        piece = '7a'
        valid_move = '6a'
        potential_moves = ['6a', '5a']
        returned_val = chess_game.valid_move?(valid_move, piece, potential_moves)
        expect(returned_val).to eq(true)
      end
    end
  end

  describe "#move_piece" do

    before do
      allow(chess_game.board).to receive(:is_a?).and_return(false)
    end

    context "When called" do
      it "places the piece to given location" do
        piece = "2a"
        move = "3a"
        chess_game.board[piece] = dummy_piece
        chess_game.move_piece(piece, move, player1)
        expect(chess_game.board['3a']).to eq(dummy_piece)
      end
      it "removes piece from its previous location" do
        piece = "6c"
        move = "5c"
        chess_game.move_piece(piece, move, player1)
        expect(chess_game.board[move]).to eq('')
      end
    end
    context "When player chooses to move the king" do
      it "sets player's king_loc to move location" do
        piece = '1e'
        move = '2e'
        allow(chess_game.board).to receive(:is_a?).and_return(true)
        expect(player1).to receive(:king_loc=).with(move).once
        chess_game.move_piece(piece, move, player1)
      end
    end
  end

  describe "#remove_potential_moves_indicator" do
    context "When called" do
      it "removes all potential move indicators from the board" do
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
      it "only removes indicators from the board and nothing else" do
        potential_moves = ['3a', '3b', '3c']
        board = chess_game.board
        expected_result = ['', dummy_piece, '']
        result = []
        indicator ="\u2718"
        board['3a'] = indicator
        board['3b'] = dummy_piece
        board['3c'] = indicator
        chess_game.remove_potential_moves_indicator(potential_moves)
        potential_moves.each { |move| result << board[move] }
        expect(result).to eq(expected_result)
      end
    end
  end

  describe "#play_game" do
    context "When game has ended" do
      it "calls round on both player and breaks the loop" do
        allow(chess_game).to receive(:get_player_move)
        allow(chess_game).to receive(:check?)
        allow(chess_game).to receive(:checkmate)
        allow(chess_game).to receive(:get_player_piece)
        allow(chess_game).to receive(:game_end).and_return(false, false, true)
        expect(chess_game).to receive(:round).twice
        chess_game.play_game
      end
    end
  end

  describe "#check?" do
    context "When player's king is under immediate threat" do
      it "returns true" do
        board = chess_game.board
        allow(player1).to receive(:king_loc).and_return('1e')
        allow(board).to receive(:[]).and_return(king)
        allow(king).to receive(:clear?).and_return(false)
        result = chess_game.check?(player1, board)
        expect(result).to eq(true)
      end
    end
    context "When player's king is not under immediate threat" do
      it "returns false" do
        board = chess_game.board
        allow(player1).to receive(:king_loc).and_return('1e')
        allow(board).to receive(:[]).and_return(king)
        allow(king).to receive(:clear?).and_return(true)
        result = chess_game.check?(player1, board)
        expect(result).to eq(false)
      end
    end
  end

  describe "#checkmate" do
    context "When player failed to save their king after their round" do
      it "changes game_end to true" do
        loser = player1
        winner = player2
        allow(player2).to receive(:name)
        allow(chess_game).to receive(:check?).and_return(true)
        chess_game.checkmate(loser, winner)
        expect(chess_game.game_end).to eq(true)
      end
    end
    context "When the king is safe after round is over" do
      it "doesn't change game_end at all" do
        loser = player1
        winner = player2
        allow(chess_game).to receive(:check?).and_return(false)
        expect(chess_game).not_to receive(:game_end=)
        chess_game.checkmate(loser, winner)
      end
    end
  end

  describe "#change_turns" do
    context "When called with first player's turn" do
      it "changes turn to second player" do
        # When we initialize chess @turn is set to p1
        p2 = chess_game.p2
        chess_game.change_turns
        expect(chess_game.turn).to eq(p2)
      end
    end
    context "When potential winner is the second player" do
      it "changes potential winner to first player" do
        # When we initialize chess @potential_winner is set to p2.
        p1 = chess_game.p1
        chess_game.change_turns
        expect(chess_game.potential_winner).to eq(p1)
      end
    end
  end

  describe "#save_game" do
    context "When saved_games directory doesn't exist" do
      it "creates saved_games directory" do
        file_name = 'my_game'
        path = './saved_games'
        allow(File).to receive(:open)
        chess_game.save_game
        file_exist = File.exist?(path)
        expect(file_exist).to eq(true)
      end
    end
    context "When file with the same name exists" do
      it "asks for another file name" do
        dup_name = 'my_game'
        alt_name = 'our_game'
        allow(chess_game).to receive(:get_input).and_return(dup_name, alt_name)
        allow(File).to receive(:exist?).and_return(true, true, false) #First true is for directory.
        expect(chess_game).to receive(:get_input).twice
        chess_game.save_game
      end
    end
    context "When given unique file name" do
      it "saves the game" do
        file_name = 'game1'
        complete_file_name = './saved_games/game1.json'
        allow(File).to receive(:exists?).and_return(true, false)
        allow(chess_game).to receive(:get_input).and_return(file_name)
        expect(File).to receive(:open).with(complete_file_name, 'w')
        chess_game.save_game
      end
    end
  end

  describe "#convert_to_json" do
    context "When called" do
      it "converts given data to a JSON hash" do
        turn = player1
        potential_winner = player2
        returned_val = chess_game.convert_to_json(player1, player2, board, turn, potential_winner)
        result = returned_val.is_a?(String)
        expect(result).to eq(true)
      end
    end
  end

  describe "#load_game" do

    let(:dummy_board) { {1 => ['', '', '', '', '', 'k']} }
    let(:saved_data) { {'p1_name' => 'jon',
      'p1_color' => 'white',
      'p1_king_loc' => '1e',
      'p2_name' => 'snow',
      'p2_color' => 'black',
      'p2_king_loc' => '8e',
      'board' => dummy_board,
      'turn' => 'p2',
      'potential_winner' => 'p1'} }
    before do
      # Passing a dummy hash so we can check it loads ok in the game.
      allow(chess_game).to receive(:convert_json_hash).and_return(dummy_board)
      allow(chess_game).to receive(:get_saved_file).and_return(saved_data)
    end

    context "When called" do
      it "sets p1's name to saved name" do
        expect(chess_game.p1).to receive(:name=).with('jon')
        chess_game.load_game
      end
      it "sets p1's color to saved color" do
        expect(chess_game.p1).to receive(:color=).with('white')
        chess_game.load_game
      end
      it "sets p1's king_loc to saved location" do
        expect(chess_game.p1).to receive(:king_loc=).with('1e')
        chess_game.load_game
      end
      it "sets p2's name to saved name" do
        expect(chess_game.p2).to receive(:name=).with('snow')
        chess_game.load_game
      end
      it "sets p2's color to saved color" do
        expect(chess_game.p2).to receive(:color=).with('black')
        chess_game.load_game
      end
      it "sets p2's king_loc to saved location" do
        expect(chess_game.p2).to receive(:king_loc=).with('8e')
        chess_game.load_game
      end
      it "sets board's grid to saved grid" do
        expect(chess_game.board).to receive(:grid=).with(dummy_board)
        chess_game.load_game
      end
      it "sets turn to saved turn" do
        chess_game.load_game
        expect(chess_game.turn).to eq('p2')
      end
      it "sets potential_winner to saved potential_winner" do
        chess_game.load_game
        expect(chess_game.potential_winner).to eq('p1')
      end
    end
  end

  describe "#get_saved_file" do

    before do
      allow(File).to receive(:read)
      allow(JSON).to receive(:parse)
      allow(chess_game).to receive(:get_file_name).and_return('./saved_games/my_game.json')
      allow(Dir).to receive(:each_child)
    end

    context "When called" do
      it "shows all the files in the saved_games directory" do
        path = './saved_games'
        expect(Dir).to receive(:each_child).with(path)
        chess_game.get_saved_file
      end
      it "reads the saved file" do
        saved_file = './saved_games/my_game.json'
        expect(File).to receive(:read).with(saved_file)
        chess_game.get_saved_file
      end
      it "parses the saved file" do
        # For the sake of test we are gonna pass a string rather than a json file as we only want to
        # test whether or not it is passed to JSON's #parse method.
        # We will not be testing #parse's functionality.
        test_data = 'my_saved_data_file'
        allow(File).to receive(:read).and_return(test_data)
        expect(JSON).to receive(:parse).with(test_data)
        chess_game.get_saved_file
      end
      it "returns the saved data" do
        test_data = 'my_saved_data_file'
        allow(JSON).to receive(:parse).and_return(test_data)
        result = chess_game.get_saved_file
        expect(result).to eq(test_data)
      end
    end
  end

  describe "#convert_json_hash" do
    context "When called" do
      it "returns a new hash with saved data that we can use as our board" do
        # What we need is a hash whose rows are int rather than string that we get when we parse a JSON hash.
        saved_hash = { '1' => [''],
                       '2' => [''],
                       '3' => [''],
                       '4' => [''],
                       '5' => [''],
                       '6' => [''],
                       '7' => [''],
                       '8' => [''] }
        expected_result = { 1 => [''],
                            2 => [''],
                            3 => [''],
                            4 => [''],
                            5 => [''],
                            6 => [''],
                            7 => [''],
                            8 => [''] }
        result = chess_game.convert_json_hash(saved_hash)
        expect(result).to eq(expected_result)
      end
    end
  end

  describe "#get_file_name" do
    context "When file exists" do
      it "returns file name with full path" do
        file_name = 'my_game'
        full_path = './saved_games/my_game.json'
        allow(chess_game).to receive(:get_input).and_return(file)
        allow(File).to receive(:exists?).and_return(true)
        result = chess_game.get_file_name
        expect(result).to eq(full_path)
      end
    end
    context "When file chosen by user doesn't exist" do
      it "asks user to enter valid file name until given" do
        allow(File).to receive(:exists?).and_return(false, true)
        expect(chess_game).to receive(:get_input).twice
        chess_game.get_file_name
      end
    end
  end
end


