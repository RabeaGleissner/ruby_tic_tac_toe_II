require 'spec_helper'
require 'human_player'
require 'fake_ui'
require 'board'

describe HumanPlayer do
  it "makes a move" do
    replay = [false]
    player = HumanPlayer.new(:X, FakeUi.new(replay))
    new_board = player.make_move(Board.new)
    expect(new_board.available_positions).not_to include 3
  end
end
