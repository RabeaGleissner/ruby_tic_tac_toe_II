require 'spec_helper'
require 'computer_player'
require 'board'
require 'marks'

describe ComputerPlayer do
  include Marks
  let(:player) {ComputerPlayer.new(Marks::O)}

  it "assigns positive score if computer player wins" do
    board = Board.new([Marks::O, Marks::O, Marks::O,
                       3, 4, 5,
                       6, Marks::X, Marks::X])
    expect(player.score_for_move(board, 2)).to eq 2
  end

  it "assigns positive score if game is drawn" do
    board = Board.new([Marks::O, Marks::O, Marks::X,
                       Marks::X, Marks::X, Marks::O,
                       Marks::O, Marks::X, Marks::X])
    expect(player.score_for_move(board, 0)).to eq 0
  end

  it "assigns negative score if opponent wins" do
    board = Board.new([Marks::O, Marks::O, 2,
                       3, 4, 5,
                       Marks::X, Marks::X, Marks::X])
    expect(player.score_for_move(board, 4)).to eq -4
  end

  it "makes a winning move for a diagonal win" do
    new_board = player.make_move(Board.new([Marks::O, Marks::X, 2,
                                            Marks::X, Marks::O, 5,
                                            6, Marks::X, 8]))
    expect(new_board.winner_mark).to eq(Marks::O)
  end

  it "makes a winning move for a horizontal win" do
    new_board = player.make_move(Board.new([Marks::X, 1, 2,
                                            3, Marks::O, Marks::O,
                                            Marks::X, 7, Marks::X]))
    expect(new_board.winner_mark).to eq(Marks::O)
  end

  it "makes a winning move for a vertical win" do
    new_board = player.make_move(Board.new([Marks::O, Marks::X, 2,
                                            3, Marks::O, Marks::O,
                                            Marks::X, Marks::O, Marks::X]))
    expect(new_board.winner_mark).to eq(Marks::O)
  end

  it "blocks an opponents winning move" do
    new_board = player.make_move(Board.new([Marks::X, Marks::O, 2,
                                            Marks::X, 4, 5,
                                            Marks::O, 7, Marks::X]))
    expect(new_board.available_positions).not_to include 4
  end

  it "creates a trap if possible" do
    new_board = player.make_move(Board.new([0, Marks::O, 2,
                                            Marks::X, 4, 5,
                                            Marks::O, 7, Marks::X]))
    expect(new_board.available_positions).not_to include [4, 2].any?
  end

  it "is always ready to make a move" do
    player = ComputerPlayer.new(Marks::X)
    expect(player.ready?).to be true
  end

  it "makes the first move in under 2 seconds", slow: true do
    start_time = Time.now
    player.make_move(Board.new)
    end_time = Time.now
    expect(end_time - start_time).to be <= 2
  end
end
