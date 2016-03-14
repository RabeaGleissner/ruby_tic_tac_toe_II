require_relative 'spec_helper'
require_relative '../lib/human_player'

describe HumanPlayer do
  let(:player) {HumanPlayer.new(:X)}


  it "makes a move" do
    new_board = player.make_move(3, Board.new)
    expect(new_board.available_positions).not_to include 3
  end

end
