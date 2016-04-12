require 'spec_helper'
require 'players/random_player'
require 'board'

describe RandomPlayer do
  it "makes a random move" do
    player = RandomPlayer.new(:X)
    board = Board.new
    new_board = player.make_move(board)
    expect(new_board.available_positions.length).to eq 8
  end

  it "is always ready" do
    player = RandomPlayer.new(:X)
    expect(player.ready?).to eq true
  end
end
