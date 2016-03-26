require 'spec_helper'
require 'player_with_preset_data'
require 'fake_ui'
require 'game.rb'

describe Game do
  it "plays game once" do
    player1 = PlayerWithPresetData.new(:X, [0,1,2])
    player2 = PlayerWithPresetData.new(:O, [3,4])
    replay = [false]
    fake_ui = FakeUi.new(replay)
    game = Game.new(fake_ui)
    game.play([player1, player2], Board.new)
    expect(fake_ui.announce_winner_called).to eq 1
  end
end
