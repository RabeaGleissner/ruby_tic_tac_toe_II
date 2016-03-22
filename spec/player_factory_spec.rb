require 'spec_helper'
require 'player_factory'
require 'ui'

describe PlayerFactory do
  let (:ui) {Ui.new(nil, nil)}

  HUMAN_VS_HUMAN = "1"
  HUMAN_VS_COMPUTER = "2"
  COMPUTER_VS_HUMAN = "3"

  it "creates a computer player as player1" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player1(COMPUTER_VS_HUMAN)).to be_a ComputerPlayer
  end

  it "creates a human player as player1 for a Human vs Human game" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player1(HUMAN_VS_HUMAN)).to be_a HumanPlayer
  end

  it "creates a human player as player1 for a Human vs Computer game" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player1(HUMAN_VS_COMPUTER)).to be_a HumanPlayer
  end

  it "creates a human player as player2" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player2(HUMAN_VS_HUMAN)).to be_a HumanPlayer

  end

  it "creates a computer player as player2" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player2(HUMAN_VS_COMPUTER)).to be_a ComputerPlayer 
  end

  it "creates a human player as player2" do
    factory = PlayerFactory.new(ui)

    expect(factory.create_player2(COMPUTER_VS_HUMAN)).to be_a HumanPlayer 
  end
end
