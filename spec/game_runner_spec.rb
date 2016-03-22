require 'spec_helper'
require 'game_runner.rb'
require 'player_factory'
require 'fake_ui'
require 'game_spy'

describe GameRunner do
  let (:game_spy) {GameSpy.new}

  it "kicks of the playing of the game" do
    replay = [false]
    fake_ui = FakeUi.new(replay)
    player_factory = PlayerFactory.new(fake_ui)
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)
    game_runner.start
    expect(game_spy.play_method_calls_count).to be 1
  end

  it "starts the game again if user wants to replay" do
    replay = [true, false]
    fake_ui = FakeUi.new(replay)
    player_factory = PlayerFactory.new(fake_ui)
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)
    game_runner.start
    expect(game_spy.play_method_calls_count).to be 2
  end
end
