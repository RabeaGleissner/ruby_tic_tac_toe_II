require 'spec_helper'
require_relative '../lib/views/view_helper'

class ViewHelperWrapper
  include ViewHelper
end

describe ViewHelperWrapper do
  it "converts a group of words into kebab case" do
    view_helper = ViewHelperWrapper.new
    expect(view_helper.convert_to_kebab_case("Human vs Human")).to eq "human-vs-human"
  end

   it "formats a Ruby symbol for front end display" do
    view_helper = ViewHelperWrapper.new
    expect(view_helper.format_game_options(:HumanVsHuman)).to eq "Human vs Human"
   end

   it "formats the board size for front end display" do
    view_helper = ViewHelperWrapper.new
    expect(view_helper.format_board_size(3)).to eq "3x3 board"
   end
end
