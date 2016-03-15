require_relative 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/player_marks'


describe Board do
  X = PlayerMarks::X
  O = PlayerMarks::O

  let(:board) {Board.new}

  it "is empty when initialised" do
    expect(board.empty?).to be true
  end

  it "is full when all cells are in use" do
    full_board = Board.new([X, O, X,
                            O, X, O,
                            X, O, X])
    expect(full_board.full?).to be true
  end

  it "has a winner X" do
    winning_board = Board.new([X, X, X,
                               O, O, nil,
                               nil, nil, nil])
    expect(winning_board.winner).to eq(X)
  end

  it "has a winner O" do
    winning_board = Board.new([nil, X, X,
                               O, O, O,
                               nil, nil, nil])
    expect(winning_board.winner).to eq(O)
  end

  it "has no winner" do
    winning_board = Board.new([nil, X, X,
                               O, X, O,
                               nil, nil, nil])
    expect(winning_board.winner).to eq(false)
  end

  it "lists all rows" do
    full_board = Board.new([X, O, X,
                            O, X, O,
                            X, O, X])
    expect(full_board.rows).to eq([[X, O, X], [O, X, O], [X, O, X]])
  end

  it "lists all columns" do
    board = Board.new([X, O, nil,
                       O, X, O,
                       nil, nil, nil])
    expect(board.columns).to eq([[X, O, nil], [O, X, nil], [nil, O, nil]])
  end


  it "lists all diagonals" do
    board = Board.new([X, O, nil,
                       O, X, O,
                       nil, nil, nil])
    expect(board.diagonals).to eq([[X, X, nil], [nil, X, nil]])
  end

  it "lists all lines of the current game state" do
    board = Board.new([X, O, nil,
                       O, X, O,
                       nil, nil, nil])
    expect(board.lines).to eq([[X, O, nil],
                               [O, X, O],
                               [nil, nil, nil],
                               [X, O, nil],
                               [O, X, nil],
                               [nil, O, nil],
                               [X, X, nil],
                               [nil, X, nil]])
  end

  it "knows that all all marks are x in line" do
    expect(board.all_x([X, X, X])).to be true
  end

  it "knows that all all marks are o in line" do
    expect(board.all_o([O, O, O])).to be true
  end

  it "knows that game is over" do
    full_board = Board.new([X, O, X,
                            O, X, O,
                            X, O, X])
    expect(full_board.game_over?).to be true
  end

  it "knows that game is not over" do
    full_board = Board.new([O, O, X,
                            O, X, O,
                            nil, nil, nil])
    expect(full_board.game_over?).to be false
  end

  it "adds adds a mark on a new board" do
    new_board = board.add_mark(1, X)
    expect(new_board.available_positions).to eq([0,2,3,4,5,6,7,8])
  end

  it "doesn't change the existing board if a move is made" do
    board.add_mark(1, X)
    expect(board.available_positions.length).to eq (9)
  end
end

