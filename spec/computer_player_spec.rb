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

  it "switches the mark to O" do
    expect(player.switch_mark(:X)).to eq :O
  end

  it "switches the mark to X" do
    expect(player.switch_mark(:O)).to eq :X
  end

  it "makes a winning move for a diagonal win" do
    new_board = player.make_move(Board.new([:O, :X, 2,
                                            :X, :O, 5,
                                             6, :X, 8]))
    expect(new_board.winner).to eq(:O)
  end

  it "makes a winning move for a horizontal win" do
    new_board = player.make_move(Board.new([:O, :X,  2,
                                            3, :O, :O,
                                            6, :X, :X]))
    expect(new_board.winner).to eq(:O)
  end

  it "makes a winning move for a vertical win" do
    new_board = player.make_move(Board.new([:O, :X,  2,
                                            3, :O, :O,
                                           :X, :O, :X]))
    expect(new_board.winner).to eq(:O)
  end

  it "blocks an opponents winning move" do
    new_board = player.make_move(Board.new([:X, :O,  2,
                                           :X,  4,  5,
                                           :O,  7, :X]))
    expect(new_board.available_positions).not_to include 4
  end

  it "creates a trap if possible" do
    new_board = player.make_move(Board.new([0, :O,  2,
                                           :X,  4,  5,
                                           :O,  7, :X]))
    expect(new_board.available_positions).not_to include 4
  end
end
