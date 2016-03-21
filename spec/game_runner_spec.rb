require 'spec_helper'
require 'game_runner.rb'

describe GameRunner do
  it "plays game again if user chooses to" do
    player1 = PlayerWithPresetData.new(:X, [0,1,2,0,1,2], [true, false])
    player2 = PlayerWithPresetData.new(:O, [3,4,3,4], [false])
    fake_ui = FakeUi.new
    game_runner = GameRunner.new(fake_ui, player1, player2)
    game_runner.set_up_game
    expect(fake_ui.announce_winner_called).to eq 2
  end

end
