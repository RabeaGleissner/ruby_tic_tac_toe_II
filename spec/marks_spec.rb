require 'spec_helper'
require 'marks'

describe Marks do
  include Marks

  it "switches current mark to O" do
    expect(switch_mark(Marks::X)).to eq Marks::O
  end

  it "switches current mark to X" do
    expect(switch_mark(Marks::O)).to eq Marks::X
  end
end
