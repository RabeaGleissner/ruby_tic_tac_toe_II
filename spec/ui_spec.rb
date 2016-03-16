require_relative 'spec_helper'
require 'stringio'
require_relative '../lib/ui'
require_relative '../lib/board'
describe Ui do
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let (:ui) {Ui.new(input, output)}

  it "creates an image of the board" do
    board = Board.new([:X, 1, :X, :O, 4, :O, :O, 7, :X])
    expect(ui.create_board_image(board)).to eq("\n-----------\n X | 2 | X\n-----------\n O | 5 | O\n-----------\n O | 8 | X\n-----------\n")
  end

  it "draws a board to the console" do
    board = Board.new
    ui = Ui.new(StringIO.new, output)
    ui.draw_board(board)
    expect(output.string).to eq("\e[H\e[2J\n-----------\n 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n-----------\n")
  end

  it "asks user for position" do
    output = StringIO.new
    ui = Ui.new(StringIO.new("2"), output)
    ui.request_position(Board.new)
    expect(output.string).to eq("\nPlease enter a position:\n")
  end

  it "returns user's position" do
    ui = Ui.new(StringIO.new("2"), StringIO.new)
    expect(ui.request_position(Board.new)).to eq(1)
  end

  it "asks user for a position again if first input was invalid" do
    board = Board.new
    new_board = board.add_mark(1, :X)
    allow(ui.input).to receive(:gets).and_return("2", "3")
    expect(output).to receive(:puts).with("\nPlease enter a position:").twice
    expect(ui.request_position(new_board)).to eq(2)
  end

  it "announces that the winner is X" do
    x_winner_board = Board.new([:X, :X, :X,
                                3, 4, :O,
                                :O, 7, 8])
    ui.announce_winner(x_winner_board)
    expect(output.string).to eq("\nGame over! Winner is X.\n")
  end

  it "announces a draw" do
    drawn_board = Board.new([:X, :O, :X,
                             :X, :O, :O,
                             :O, :X, :X])
    ui.announce_winner(drawn_board)
    expect(output.string).to eq("\nGame over! It's a draw.\n")
  end

  it "asks if user wants to play again" do
    allow(ui.input).to receive(:gets).and_return("n")
    ui.replay?
    expect(output.string).to eq("\nDo you want to play again?\n\n- Enter y for yes\n- Enter n for no\n")
  end

  it "knows that the user does not want to play again" do
    ui = Ui.new(StringIO.new("n"), output)
    expect(ui.replay?).to be false
  end

  it "asks again for replay choice if unexpected input" do
    allow(ui.input).to receive(:gets).and_return("hello", "n")
    expect(output).to receive(:puts).with("\nDo you want to play again?\n\n- Enter y for yes\n- Enter n for no").twice
    ui.replay?
  end

  it "says goodbye to the user" do
    CLEAR = "\e[H\e[2J"
    ui.say_goodbye
    expect(output.string).to eq(CLEAR + "Byyyee!\n\n")
  end
end
