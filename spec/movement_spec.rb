require_relative '../lib/movement'

describe Movement do
  let (:dummy_class) { Class.new { extend Movement } }

  describe '#gen_pawn_moves' do
    context 'When its the first move' do
      xit 'returns 2 normal moves' do
        first_move = true
        initial_loc = '2a'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(2)
      end
      xit 'first move is two steps front and second is one step front' do
        first_move = true
        initial_loc = '2c'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[0][0]
        second_suggested_move = moves[0][1]
        expect(first_suggested_move).to eq('4c')
        expect(second_suggested_move).to eq('3c')
      end
    end
    context 'When its not the first move' do
      xit 'returns only 1 normal move' do
        first_move = false
        initial_loc = '4g'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        normal_moves_length = moves[0].length
        expect(normal_moves_length).to eq(1)
      end
    end
    context 'When called' do
      xit 'returns two kill moves when first_move is true' do
        first_move = true
        initial_loc = '2g'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[0].length
        expect(kill_moves_length).to eq(2)
      end
      xit 'returns two kill moves when first_move is false' do
        first_move = false
        initial_loc = '6g'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        kill_moves_length = moves[0].length
        expect(kill_moves_length).to eq(2)
      end
      xit 'first kill move is right and the second is left' do
        first_move = false
        initial_loc = '4d'
        moves = dummy_class.gen_pawn_moves(initial_loc, first_move)
        first_suggested_move = moves[1][0]
        second_suggested_move = moves[1][1]
        expect(first_suggested_move).to eq('5e')
        expect(second_suggested_move).to eq('5c')
      end
    end


