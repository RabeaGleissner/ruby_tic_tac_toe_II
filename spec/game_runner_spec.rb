require 'spec_helper'
require 'game_runner.rb'
require 'player_factory'
require 'fake_ui'
require 'game_spy'

describe GameRunner do
  let (:game_spy) {GameSpy.new}

  it "starts application and plays game twice if user wants to replay" do
    replay_choices = [true, false]
    fake_ui = FakeUi.new(replay_choices)
    player_factory = PlayerFactory.new(fake_ui)
    game_runner = GameRunner.new(fake_ui, game_spy, player_factory)

    game_runner.start

    expect(game_spy.play_method_calls_count).to be 2
  end

  it "catches exception if a user interrupts with ctrl + c" do
    disruptive_ui = InterruptingUi.new
    player_factory = PlayerFactory.new(disruptive_ui)
    game_runner = GameRunner.new(disruptive_ui, game_spy, player_factory)
    game_runner.start
    expect(disruptive_ui.displayed_interruption_message?).to be true
  end

  class InterruptingUi
    def initialize
      @says_goodbye = false
    end

    def menu(placeholder)
      raise Interrupt
    end

    def displayed_interruption_message?
      @says_goodbye
    end

    def interruption_message
      @says_goodbye = true
    end
  end
end
