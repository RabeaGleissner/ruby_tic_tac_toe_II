require_relative 'spec_helper'
require_relative '../lib/computer_player'
require_relative '../lib/board'

describe ComputerPlayer do
  let(:player) {ComputerPlayer.new(:O)}

  it "assigns a score of 10 if computer player wins" do
    board = Board.new([:O, :O, :O,
                        3,  4,  5,
                        6, :X, :X])
    expect(player.score(board)).to eq 10
  end

  it "assigns a score of 0 if game is drawn" do
    board = Board.new([:O, :O, :X,
                       :X, :X, :O,
                       :O, :X, :X])
    expect(player.score(board)).to eq 0
  end

  it "assigns a score of -10 if opponent wins" do
    board = Board.new([:O, :O,  2,
                        3,  4,  5,
                        :X, :X, :X])
    expect(player.score(board)).to eq -10
  end

  it "makes a move" do
    new_board = player.make_move(Board.new)
    expect(new_board.available_positions).not_to eq 0
  end
end
