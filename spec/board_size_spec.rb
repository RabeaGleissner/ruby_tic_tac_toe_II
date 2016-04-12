require 'spec_helper'
require 'board_size'

describe BoardSize do
  it "creates the display text for board size options" do
    board_size = BoardSize.new
    expect(board_size.display(3)).to eq "3x3 board"
  end
end
