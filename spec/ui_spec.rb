require_relative 'spec_helper'
require 'stringio'
require_relative '../lib/ui'

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
        expect(ui.request_position(Board.new)).to eq(2)
    end

end
