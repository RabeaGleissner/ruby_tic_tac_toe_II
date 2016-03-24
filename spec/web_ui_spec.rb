require 'spec_helper'
require 'web_ui'
require 'board'

describe WebUi do
  let (:web_ui) {WebUi.new}

  it "saves the current game state" do
    new_board = Board.new.add_mark(3, :X)
    expect(web_ui.draw_board(new_board)).to eq([[0, 1, 2], [:X, 4, 5], [6, 7, 8]])
  end

  it "returns an empty game state if the grid variable is not set" do
    expect(web_ui.game_state_rows).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it "returns the game state that was previously set" do
    new_board = Board.new.add_mark(3, :X)
    web_ui.draw_board(new_board)
    expect(web_ui.game_state_rows).to eq([[0, 1, 2], [:X, 4, 5], [6, 7, 8]])
  end
end
