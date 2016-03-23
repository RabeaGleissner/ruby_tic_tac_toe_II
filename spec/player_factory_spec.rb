require 'spec_helper'
require 'player_factory'
require 'computer_player'
require 'human_player'
require 'ui'

describe PlayerFactory do
  let (:ui) {Ui.new(nil, nil)}

  HUMAN_VS_HUMAN = "1"
  HUMAN_VS_COMPUTER = "2"
  COMPUTER_VS_HUMAN = "3"

  it "creates a computer player and a human player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(COMPUTER_VS_HUMAN).first).to be_a ComputerPlayer
    expect(factory.create_players(COMPUTER_VS_HUMAN).last).to be_a HumanPlayer
  end

  it "creates a human player and a computer player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(HUMAN_VS_COMPUTER).first).to be_a HumanPlayer
    expect(factory.create_players(HUMAN_VS_COMPUTER).last).to be_a ComputerPlayer
  end

  it "creates two human players" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(HUMAN_VS_HUMAN).first).to be_a HumanPlayer
    expect(factory.create_players(HUMAN_VS_HUMAN).last).to be_a HumanPlayer
   end
end
