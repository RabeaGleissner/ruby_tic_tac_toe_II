require 'spec_helper'
require 'computer_player'
require 'board'

describe ComputerPlayer do
  let(:player) {ComputerPlayer.new(:O)}

  it "assigns a positive score if computer player wins" do
    board = Board.new([:O, :O, :O,
                        3,  4,  5,
                        6, :X, :X])
    expect(player.score_for_move(board, 2)).to eq 2
  end

  it "assigns a positive score if game is drawn" do
    board = Board.new([:O, :O, :X,
                       :X, :X, :O,
                       :O, :X, :X])
    expect(player.score_for_move(board, 0)).to eq 0
  end

  it "assigns a negatie score if opponent wins" do
    board = Board.new([:O, :O,  2,
                        3,  4,  5,
                        :X, :X, :X])
    expect(player.score_for_move(board, 4)).to eq -4
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
    new_board = player.make_move(Board.new([:X, 1,  2,
                                             3, :O, :O,
                                            :X,  7, :X]))
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
    expect(new_board.available_positions).not_to include [4, 2].any?
  end

  it "is always ready to make a move" do
    player = ComputerPlayer.new(:X)
    expect(player.ready?).to be true
  end
end
