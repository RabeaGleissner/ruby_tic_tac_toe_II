require 'spec_helper'
require 'game_options'

describe GameOptions do
  let(:game_options) {GameOptions.new}

  it "maps option 1 to Human vs Human" do
    expect(game_options.map("1")).to eq :HumanVsHuman
  end

  it "maps option 2 to Human vs Computer" do
    expect(game_options.map("2")).to eq :HumanVsComputer
  end

  it "maps option 3 to Computer vs Human" do
    expect(game_options.map("3")).to eq :ComputerVsHuman
  end

  it "maps option 4 to Computer vs Computer" do
    expect(game_options.map("4")).to eq :ComputerVsComputer
  end
end
