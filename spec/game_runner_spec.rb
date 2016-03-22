require 'spec_helper'
require 'game_runner.rb'
require 'player_factory'
require 'fake_ui'
require 'game_spy'

describe GameRunner do
  let (:game_spy) {GameSpy.new}

  it "starts application and plays game once" do
    replay_choice = [false]
    fake_ui = FakeUi.new(replay_choice)
    player_factory = PlayerFactory.new(fake_ui)
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)
    game_runner.start
    expect(game_spy.play_method_calls_count).to be 1
  end

  it "starts application and plays game twice if user wants to replay" do
    replay_choices = [true, false]
    fake_ui = FakeUi.new(replay_choices)
    player_factory = PlayerFactory.new(fake_ui)
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)
    game_runner.start
    expect(game_spy.play_method_calls_count).to be 2
  end
end
