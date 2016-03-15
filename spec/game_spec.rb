require_relative 'spec_helper'
require_relative 'player_with_preset_data'
require_relative 'fake_ui'
require_relative '../lib/game.rb'

describe Game do

  it "plays game once" do
    player1 = PlayerWithPresetData.new(:X, [0,1,2], [false])
    player2 = PlayerWithPresetData.new(:O, [3,4], [false])
    fake_ui = FakeUi.new
    game = Game.new(player1, player2, fake_ui)
    game.play
    expect(fake_ui.announce_winner_called).to eq 1
  end

end