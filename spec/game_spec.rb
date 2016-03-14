require_relative 'spec_helper'
require_relative '../lib/game.rb'

describe Game do

  it "plays game once" do
    player1 = PlayerWithSetMoves.new(:X, [0,1,2])
    player2 = PlayerWithSetMoves.new(:X, [3,4])
    fake_ui = FakeUi.new
    game = Game.new(player1, player2, fake_ui)
    game.play
    expect(fake_ui.announce_winner_called).to eq 1

  end

  class PlayerWithSetMoves
    attr_reader :mark

    def initialize(mark, moves)
      @mark = mark
      @moves = moves
    end

    def make_move(board)
      board.add_mark(@moves.shift, mark)
    end
  end

  class FakeUi
    def initialize
      @announce_winner_called = 0
    end

    def announce_winner(board)
      @announce_winner_called += 1
    end

    def announce_winner_called
      @announce_winner_called
    end

    def draw_board(board)
    end
  end

end
