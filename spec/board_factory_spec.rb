require 'spec_helper'
require 'board_factory'

describe BoardFactory do
  it "creates a 3x3 board" do
    factory = BoardFactory.new
    board = factory.create_board(3)
    expect(board.dimension).to eq 3
  end

  it "creates a 4x4 board" do
    factory = BoardFactory.new
    board = factory.create_board(4)
    expect(board.dimension).to eq 4
  end
end
