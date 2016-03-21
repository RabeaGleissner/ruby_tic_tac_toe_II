require 'spec_helper'
require 'game_runner.rb'
require 'player_factory'
require 'fake_ui'
require 'game_spy'

describe GameRunner do
  let (:fake_ui) {FakeUi.new}
  let (:player_factory) {PlayerFactory.new(fake_ui)}
  let (:game_spy) {GameSpy.new}

  it "calls the play method on game" do
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)
    game_runner.start
    expect(game_spy.called_play_method?).to be true
  end
end
