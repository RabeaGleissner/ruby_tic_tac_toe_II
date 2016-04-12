require 'spec_helper'
require 'board'

describe Board do
  X = Marks::X
  O = Marks::O
  let(:board) {Board.new}

  it "is empty when initialised" do
    expect(board.empty?).to be true
  end

  it "is full when all cells are in use" do
    full_board = Board.new(3, [X, O, X,
                            O, X, O,
                            X, O, X])
    expect(full_board.full?).to be true
  end

  it "has a winner X" do
    winning_board = Board.new(3, [X, X, X,
                               O, O, 5,
                               6, 7, 8])
    expect(winning_board.winner_mark).to eq(X)
  end

  it "has a winner O" do
    winning_board = Board.new(3, [0, X, X,
                               O, O, O,
                               6, 7, 8])
    expect(winning_board.winner_mark).to eq(O)
  end

  it "has no winner" do
    winning_board = Board.new(3, [0, X, X,
                               O, X, O,
                               6, 7, 8])
    expect(winning_board.winner_mark).to eq(nil)
  end

  it "lists all rows, columns and diagonals of the current game state" do
    board = Board.new(3, [X, O, 2,
                       O, X, O,
                       6, 7, 8])
    expect(board.lines).to eq([[X, O, 2], [O, X, O], [6, 7, 8], [X, O, 6], [O, X, 7], [2, O, 8], [X, X, 8], [2, X, 6]])
  end

  it "knows that game is over" do
    winning_board = Board.new(3, [X, O, X,
                               O, X, O,
                               X, O, X])
    expect(winning_board.game_over?).to be true
  end

  it "knows that game is not over" do
    board = Board.new(3, [O, O, X,
                       O, X, O,
                       6, 7, 8])
    expect(board.game_over?).to be false
  end

  it "adds adds a mark on a new board" do
    new_board = board.add_mark(1, X)
    expect(new_board.available_positions).to eq([0,2,3,4,5,6,7,8])
  end

  it "doesn't change the existing board if a move is made" do
    board.add_mark(1, X)
    expect(board.available_positions.length).to eq (9)
  end

  it "has a winner" do
    winning_board = Board.new(3, [X, X, X, O, O, 5,6,7,8])
    expect(winning_board.winner?).to be true
  end

  it "is a draw" do
    drawn_board = Board.new(3, [X, X, O,
                             O, O, X,
                             X, O, X])
    expect(drawn_board.draw?).to be true
  end

  it "has three X marks" do
    board = Board.new(3, [X, X, O,
                       O, O, X,
                       6, O, 8])
    expect(board.count_for(X)).to eq 3
  end

  it "has four O marks" do
    board = Board.new(3, [X, X, O,
                       O, O, X,
                       6, O, 8])
    expect(board.count_for(O)).to eq 4
  end

  it "is a 3x3 board when it is initialised without any arguments" do
    expect(Board.new.dimension).to eq 3
  end

  it "is a 4x4 board when it is passed a 4 when it is created" do
    expect(Board.new(4).dimension).to eq 4
  end
end
