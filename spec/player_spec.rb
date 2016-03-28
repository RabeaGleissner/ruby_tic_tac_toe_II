require 'spec_helper'
require 'player'

describe Player do
  it "is ready" do
    player = Player.new
    expect(player.ready?).to be true
  end
end
