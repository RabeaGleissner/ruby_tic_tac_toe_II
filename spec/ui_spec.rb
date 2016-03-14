require_relative 'spec_helper'
require 'stringio'
require_relative '../lib/ui'
require_relative '../lib/board'

describe Ui do
    let(:input_stream) {StringIO.new}
    let(:output_stream) {StringIO.new}
    let (:ui) {Ui.new(input_stream, output_stream)}

    it "prints the board to the console" do
        board = Board.new([:E, :E, :X, :E, :E, :O, :E, :E, :X])
        expect(ui.create_board_image(board)).to eq(" 1 | 2 | X\n----------\n 4 | 5 | O\n----------\n 7 | 8 | X")
    end

    it "asks user for a position" do
        allow(ui.input).to receive(:gets).and_return("2")
        expect(output_stream).to receive(:puts).with("Please enter a position:")
        expect(ui.request_position(Board.new)).to eq(1)
    end

    it "asks user for a position again if first input was invalid" do
        board = Board.new
        new_board = board.add_mark(1, :X)
        allow(ui.input).to receive(:gets).and_return("2", "3")
        expect(output_stream).to receive(:puts).with("Please enter a position:").twice
        expect(ui.request_position(new_board)).to eq(2)
    end

    it "announces that the winner is X" do
      x_winner_board = Board.new([:X, :X, :X,
                         :E, :E, :O,
                         :O, :E, :E])
      expect(output_stream).to receive(:puts).with("Game over! Winner is X.")
      ui.announce_winner(x_winner_board)
    end

    it "announces a draw" do
      drawn_board = Board.new([:X, :O, :X,
                         :X, :O, :O,
                         :O, :X, :X])
      expect(output_stream).to receive(:puts).with("Game over! It's a draw.")
      ui.announce_winner(drawn_board)
    end

end
