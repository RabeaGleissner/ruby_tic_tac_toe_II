require 'spec_helper'
require 'human_console_player'
require 'fake_ui'
require 'board'
require 'marks'

describe HumanConsolePlayer do
  it "makes a move" do
    replay = [false]
    player = HumanConsolePlayer.new(Marks::X, FakeUi.new(replay))
    new_board = player.make_move(Board.new)
    expect(new_board.available_positions).not_to include 3
  end

  it "is always ready to make a move" do
    player = HumanConsolePlayer.new(Marks::X, FakeUi.new(nil))
    expect(player.ready?).to be true
  end
end
