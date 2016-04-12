require 'spec_helper'
require 'players/human_web_player'
require 'board'
require 'marks'

describe HumanWebPlayer do
  it "is ready when it has a move" do
    player = HumanWebPlayer.new(Marks::X)
    player.add_move(1)
    expect(player.ready?).to be true
  end

  it "is not ready after it has made its move" do
    player = HumanWebPlayer.new(Marks::X)
    player.add_move(1)
    player.make_move(Board.new)
    expect(player.ready?).to be false
  end

  it "returns a new board with a new move" do
    player = HumanWebPlayer.new(Marks::X)
    player.add_move(1)
    new_board = player.make_move(Board.new)
    expect(new_board.available_positions).not_to include 1
  end
end
