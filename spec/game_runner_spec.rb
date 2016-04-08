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
    game_runner = GameRunner.new(fake_ui, game_spy, PlayerFactory.new(:console))

    game_runner.start

    expect(game_spy.play_method_calls_count).to be 2
  end

  it "catches exception if a user interrupts with ctrl + c" do
    interrupting_ui = InterruptingUi.new
    game_runner = GameRunner.new(interrupting_ui, game_spy, PlayerFactory.new(:console))

    game_runner.start

    expect(interrupting_ui.displayed_interruption_message?).to be true
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
