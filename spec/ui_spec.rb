require_relative 'spec_helper'
require_relative '../lib/ui'

describe Ui do
  let (:ui) {Ui.new}

  it "prints the board to the console" do
    board = Board.new([:E, :E, :X, :E, :E, :O, :E, :E, :X])
    expect(ui.create_board_image(board)).to eq(" 1 | 2 | X\n----------\n 4 | 5 | O\n----------\n 7 | 8 | X")
  end

end
