require_relative 'spec_helper'
require_relative '../lib/board'


describe Board do
  let(:board) {Board.new}

  it "is empty when initialised" do
    expect(board.empty?).to be true
  end

  it "is full when all cells are in use" do
    full_board = Board.new([:X, :O, :X,
                            :O, :X, :O,
                            :X, :O, :X])
    expect(full_board.full?).to be true
  end

  it "has a winner X" do
    winning_board = Board.new([:X, :X, :X,
                               :O, :O, :E,
                               :E, :E, :E])
    expect(winning_board.winner).to eq(:X)
  end

  it "has a winner O" do
    winning_board = Board.new([:E, :X, :X,
                               :O, :O, :O,
                               :E, :E, :E])
    expect(winning_board.winner).to eq(:O)
  end

  it "has no winner" do
    winning_board = Board.new([:E, :X, :X,
                               :O, :X, :O,
                               :E, :E, :E])
    expect(winning_board.winner).to eq(false)
  end

  it "lists all rows" do
    full_board = Board.new([:X, :O, :X,
                            :O, :X, :O,
                            :X, :O, :X])
    expect(full_board.rows).to eq([[:X, :O, :X], [:O, :X, :O], [:X, :O, :X]])
  end

  it "lists all columns" do
    board = Board.new([:X, :O, :E,
                       :O, :X, :O,
                       :E, :E, :E])
    expect(board.columns).to eq([[:X, :O, :E], [:O, :X, :E], [:E, :O, :E]])
  end

  it "lists all diagonals" do
    board = Board.new([:X, :O, :E,
                       :O, :X, :O,
                       :E, :E, :E])
    expect(board.diagonals).to eq([[:X, :X, :E], [:E, :X, :E]])
  end

  it "lists all lines of the current game state" do
    board = Board.new([:X, :O, :E,
                       :O, :X, :O,
                       :E, :E, :E])
    expect(board.lines).to eq([[:X, :O, :E], [:O, :X, :O], [:E, :E, :E], [:X, :O, :E], [:O, :X, :E], [:E, :O, :E], [:X, :X, :E], [:E, :X, :E]])
  end

  it "knows that all all marks are x in line" do
    expect(board.all_x([:X, :X, :X])).to be true
  end

  it "knows that all all marks are o in line" do
    expect(board.all_o([:O, :O, :O])).to be true
  end
end

