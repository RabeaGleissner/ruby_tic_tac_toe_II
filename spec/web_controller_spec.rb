ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'rack/test'
require 'web_controller'

describe WebController do
  include Rack::Test::Methods

  def app
    WebController.new
  end

  it "displays the board" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include 'Tic Tac Toe'
  end
end
