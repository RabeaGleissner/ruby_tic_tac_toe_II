require 'spec_helper'
require 'game_options_mapper'

describe GameOptionsMapper do
  let(:game_options_mapper) {GameOptionsMapper.new}

  it "maps the option 1 to HvH" do
    expect(game_options_mapper.map("1")).to eq :HumanVsHuman
  end

  it "maps the option 2 to HvC" do
    expect(game_options_mapper.map("2")).to eq :HumanVsComputer
  end

  it "maps the option 3 to CvH" do
    expect(game_options_mapper.map("3")).to eq :ComputerVsHuman
  end

  it "maps the option 4 to CvC" do
    expect(game_options_mapper.map("4")).to eq :ComputerVsComputer
  end
end
