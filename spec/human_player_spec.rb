require_relative 'spec_helper'
require_relative '../lib/human_player'

describe HumanPlayer do

  it "makes a move" do
    player = HumanPlayer.new(:X, FakeUi.new)
    new_board = player.make_move(Board.new)
    expect(new_board.available_positions).not_to include 3
  end

  class FakeUi
    def request_position(board)
      3
    end

  end
end
