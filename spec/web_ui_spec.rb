require 'spec_helper'
require 'web_ui'
require 'board'
require 'marks'

describe WebUi do
  include Marks
  let (:web_ui) {WebUi.new}
  X = Marks::X
  O = Marks::O

  it "saves the current game state" do
    new_board = Board.new.add_mark(3, X)
    expect(web_ui.draw_board(new_board)).to eq([[0, 1, 2], [X, 4, 5], [6, 7, 8]])
  end

  it "returns an empty game state if the grid variable is not set" do
    expect(web_ui.game_state_rows).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it "returns the game state that was previously set" do
    new_board = Board.new.add_mark(3, X)
    web_ui.draw_board(new_board)
    expect(web_ui.game_state_rows).to eq([[0, 1, 2], [X, 4, 5], [6, 7, 8]])
  end

  it "returns the winner to display after it was set" do
    winning_board = Board.new([X, X, X, 3, 4, 5, 6, 7, 8])
    web_ui.announce_winner(winning_board)
    expect(web_ui.winner_to_announce).to eq X
  end

  it "announces a draw after it was set" do
    drawn_board = Board.new([X, X, O,
                             O, O, X,
                             X, O, X])
    web_ui.announce_winner(drawn_board)
    expect(web_ui.announce_draw?).to be true
  end
end
