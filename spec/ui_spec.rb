require_relative 'spec_helper'
require 'stringio'
require_relative '../lib/ui'
require_relative '../lib/board'

describe Ui do
    let(:input_stream) {StringIO.new}
    let(:output_stream) {StringIO.new}
    let (:ui) {Ui.new(input_stream, output_stream)}

    it "creates an image of the board" do
        board = Board.new([nil, nil, :X, nil, nil, :O, nil, nil, :X])
        expect(ui.create_board_image(board)).to eq("\n 1 | 2 | X\n-----------\n 4 | 5 | O\n-----------\n 7 | 8 | X")
    end

    it "draws a board to the console" do
      board = Board.new
      expect(output_stream).to receive(:puts).with("\e[H\e[2J\n 1 | 2 | 3 |\n-----------\n 4 | 5 | 6 |\n-----------\n 7 | 8 | 9 |")

      ui.draw_board(board)
    end

    it "asks user for a position" do
        allow(ui.input).to receive(:gets).and_return("2")
        expect(output_stream).to receive(:puts).with("\nPlease enter a position:")
        expect(ui.request_position(Board.new)).to eq(1)
    end

    it "asks user for a position again if first input was invalid" do
        board = Board.new
        new_board = board.add_mark(1, :X)
        allow(ui.input).to receive(:gets).and_return("2", "3")
        expect(output_stream).to receive(:puts).with("\nPlease enter a position:").twice
        expect(ui.request_position(new_board)).to eq(2)
    end

    it "announces that the winner is X" do
      x_winner_board = Board.new([:X, :X, :X,
                         nil, nil, :O,
                         :O, nil, nil])
      expect(output_stream).to receive(:puts).with("\nGame over! Winner is X.")
      ui.announce_winner(x_winner_board)
    end

    it "announces a draw" do
      drawn_board = Board.new([:X, :O, :X,
                         :X, :O, :O,
                         :O, :X, :X])
      expect(output_stream).to receive(:puts).with("\nGame over! It's a draw.")
      ui.announce_winner(drawn_board)
    end

    it "finds out if user wants to play again" do
      allow(ui.input).to receive(:gets).and_return("n")
      expect(output_stream).to receive(:puts).with("\e[H\e[2JDo you want to play again?\n\n- Enter y for yes\n- Enter n for no")
      expect(ui.replay?).to be false
    end

    it "asks again for replay choice if unexpected input" do
      allow(ui.input).to receive(:gets).and_return("hello", "n")
      expect(output_stream).to receive(:puts).with("\e[H\e[2JDo you want to play again?\n\n- Enter y for yes\n- Enter n for no").twice
      ui.replay?
    end

    it "says goodbye to the user" do
      allow(output_stream).to receive(:puts).with("\e[H\e[2JByyyee!")
      ui.say_goodbye
    end

end
