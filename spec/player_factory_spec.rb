require 'spec_helper'
require 'player_factory'
require 'computer_player'
require 'marks'
require 'human_console_player'
require 'ui'

describe PlayerFactory do
  include Marks
  let (:ui) {Ui.new(nil, nil)}

  HUMAN_VS_HUMAN = "1"
  HUMAN_VS_COMPUTER = "2"
  COMPUTER_VS_HUMAN = "3"

  it "creates a computer player and a human player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(COMPUTER_VS_HUMAN)[Marks::X]).to be_a ComputerPlayer
    expect(factory.create_players(COMPUTER_VS_HUMAN)[Marks::O]).to be_a HumanConsolePlayer
  end

  it "creates a human player and a computer player" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(HUMAN_VS_COMPUTER)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(HUMAN_VS_COMPUTER)[Marks::O]).to be_a ComputerPlayer
  end

  it "creates two human players" do
    factory = PlayerFactory.new(ui)
    expect(factory.create_players(HUMAN_VS_HUMAN)[Marks::X]).to be_a HumanConsolePlayer
    expect(factory.create_players(HUMAN_VS_HUMAN)[Marks::O]).to be_a HumanConsolePlayer
   end
end
