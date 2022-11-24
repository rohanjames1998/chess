require_relative '../lib/king'
require_relative '../lib/board'
require_relative '../lib/movement'
require_relative '../lib/knight'

describe King do
  subject(:king) { described_class.new }
  let(:dummy_piece) { instance_double(Knight) }
  let(:enemy_rook) { instance_double(Rook) }
  let(:enemy_queen) { instance_double(Queen) }
  let(:enemy_bishop) { instance_double(Bishop) }
  let(:enemy_king) { instance_double(King) }

  let(:board) { instance_double(Board) }

  describe "#check_valid_moves" do
    context "When moves are clear" do
      # Clear means there is no immediate threat for king if
      # player decides to move their king to that location.
      it "returns all clear moves" do
        all_moves = ['1d', '1f']
        allow(king).to receive(:clear?).and_return(true)
        result = king.check_valid_moves(all_moves, board)
        expect(result).to eq(all_moves)
      end
    end
    context "When some moves are not clear" do
      it "returns only the clear moves" do
        all_moves = ['2d', '2f', '1e']
        expected_result = ['2d', '2f']
        allow(king).to receive(:clear?).and_return(true, true, false)
        result = king.check_valid_moves(all_moves, board)
        expect(result).to eq(expected_result)
      end
    end
  end

  describe  "#clear?" do
    before do
      allow(king).to receive(:diagonal_threat?).and_return(false)
      allow(king).to receive(:vertical_threat?).and_return(false)
      allow(king).to receive(:horizontal_threat?).and_return(false)
      allow(king).to receive(:knight_threat?).and_return(false)
      allow(king).to receive(:king_threat?).and_return(false)
      allow(king).to receive(:pawn_threat?).and_return(false)
    end

    context "When one of the threat method returns false" do
      it "it returns false of there is a diagonal threat" do
        move = "2a"
        allow(king).to receive(:diagonal_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
      it "returns false of there is a vertical threat" do
        move = "7d"
        allow(king).to receive(:vertical_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
      it "returns false if there is a horizontal threat" do
        move = "5c"
        allow(king).to receive(:horizontal_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
      it "returns false if there is a knight threatening the move" do
        move = "4f"
        allow(king).to receive(:knight_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
      it "returns false if there is a king threatening the move" do
        move = "3h"
        allow(king).to receive(:king_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
      it "returns false if there is a pawn threatening the move" do
        move = "6f"
        allow(king).to receive(:pawn_threat?).and_return(true)
        result = king.clear?(move, board)
        expect(result).to eq(false)
      end
    end
    context "When there is no threat to the move" do
      it "returns true" do
        move = "3a"
        result = king.clear?(move, board)
        expect(result).to eq(true)
      end
    end
  end

  describe "#diagonal_threat?" do
    before do
      allow(king).to receive(:generate_top_right_moves).and_return(['5e', '6f'])
      allow(king).to receive(:generate_top_left_moves).and_return(['5c', '6b'])
      allow(king).to receive(:generate_down_right_moves).and_return(['3e', '2f'])
      allow(king).to receive(:generate_down_left_moves).and_return(['3c', '2b'])
    end
    context "When there is a enemy bishop or queen posing a threat" do
      it "returns true when there is a queen" do
        move = '4d'
        allow(board).to receive(:[]).and_return('', enemy_queen)
        result = king.diagonal_threat?(move, board)
        expect(result).to eq(true)
      end
      it "returns true when there is a bishop" do
        move = '4d'
        allow(board).to receive(:[]).and_return('', enemy_bishop)
        result = king.diagonal_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy piece diagonal to the move who is not a queen or bishop" do
      it "returns false" do
        move = '4d'
        # dummy_piece is an instance double of knight.
        allow(board).to receive(:[]).and_return('', dummy_piece)
        result = king.diagonal_threat?(move, board)
        expect(result).to eq(false)
      end
    end
    context "When there is no diagonal threat" do
      it "returns false" do
        move = '4d'
        allow(board).to receive(:[]).and_return('')
        result = king.diagonal_threat?(move, board)
      end
    end
  end

  describe "#vertical_threat?" do
    let(:enemy_queen) { instance_double(Queen) }

    before do
      allow(king).to receive(:generate_down_moves).and_return('2e', '1e')
      allow(king).to receive(:generate_up_moves).and_return('4e', '5e')
    end

    context "When there is an enemy rook posing vertical threat" do
      it "returns true" do
        move = '4e'
        allow(king).to receive(:[]).and_return('', enemy_rook)
        result = king.vertical_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy queen posing vertical threat" do
      it "returns true" do
        move = "4e"
        allow(king).to receive(:[]).and_return('', enemy_queen)
        result = king.vertical_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy other than queen or rook vertical to the move" do
      it "returns false" do
        move = "4e"
        # dummy_piece is an instance of knight
        allow(king).to receive(:[]).and_return('', dummy_piece)
        result = king.vertical_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is no vertical threat" do
      it "returns false" do
        move = "4e"
        allow(king).to receive(:[]).and_return('')
        result = king.vertical_threat?(move, board)
        expect(result).to eq(false)
      end
    end
  end

  describe "#horizontal_threat?" do
    before do
      allow(king).to receive(:generate_right_moves).and_return(['5g', '5h'])
      allow(king).to receive(:generate_left_moves).and_return(['5e', '5d'])
    end

    context "When there is an enemy rook posing horizontal threat" do
      it "returns true" do
        move = '5f'
        allow(board).to receive(:[]).and_return('', enemy_rook)
        result = king.horizontal_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy queen posing horizontal threat" do
      it "returns true" do
        move = '5f'
        allow(board).to receive(:[]).and_return('', enemy_queen)
        result = king.horizontal_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy piece other than rook or queen horizontal to the move" do
      it "returns false" do
        move = '5f'
        allow(board).to receive(:[]).and_return('', dummy_piece)
        result = king.horizontal_threat?(move, board)
        expect(result).to eq(false)
      end
    end
    context "When there is no horizontal threat" do
      it "returns false" do
        move = '5f'
        allow(board).to receive(:[]).and_return('')
        result = king.horizontal_threat?(move, board)
        expect(result).to eq(false)
      end
    end
  end

  describe "#knight_threat?" do
    before do
      allow(king).to receive(:generate_knight_moves).and_return(['5e', '5c'])
    end
    context "When there is a knight posing a threat to the move" do
      it "returns true" do
        move = "3d"
        # Since dummy_piece is an instance of Knight we can use it for testing.
        allow(board).to receive(:[]).and_return('', dummy_piece)
        result = king.knight_threat?(move, board)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy piece on one of the moves generated by #generate_knight_moves" do
      it "returns false" do
        move = "3d"
        allow(board).to receive(:[]).and_return('', enemy_bishop)
        result = king.knight_threat?(move, board)
        expect(result).to eq(false)
      end
    end
    context "When there is no enemy piece on any of the moves generated by #generate_knight_moves" do
      it "return false" do
        move = "3d"
        allow(board).to receive(:[]).and_return('')
        result = king.knight_threat?(move, board)
        expect(result).to eq(false)
      end
    end
  end

  describe "#king_threat?" do
    before do
      allow(king).to receive(:generate_king_moves).and_return(['3f', '3e', '3g', '4e', '4g', '5f', '5e', '5g'])
    end
    context "When there is a king threatening the move" do
      it "returns true" do
        move = "4f"
        # Since #generate_king_moves requires color arg
        # we need to pass it through #king_threat?.
        color = 'white'
        allow(board).to receive(:[]).and_return('', enemy_king)
        result = king.king_threat?(move, board, color)
        expect(result).to eq(true)
      end
    end
    context "When there is an enemy piece other than enemy king near the move" do
      it "returns false" do
        move = "4f"
        color = 'white'
        allow(board).to receive(:[]).and_return('', dummy_piece)
        result = king.king_threat?(move, board, color)
        expect(result).to eq(false)
      end
    end
    context "When there is no king threat" do
      it "returns false" do
        move = "4f"
        color = 'white'
        allow(board).to receive(:[]).and_return('')
        result = king.king_threat?(move, board, color)
        expect(result).to eq(false)
      end
    end
  end
end

