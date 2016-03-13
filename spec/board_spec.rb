require_relative 'spec_helper'
require_relative '../lib/board'

describe Board do
  let(:board) {Board.new}

  it "is empty when initialised" do
    expect(board.empty?).to be true
  end

  it "is full when all cells are in use" do
    full_board = Board.new([:X, :O, :X, :O, :X, :O, :X, :O, :X])
    expect(full_board.full?).to be true
  end

end

