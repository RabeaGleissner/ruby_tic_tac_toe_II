ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'rack/test'
require 'web_controller'
require 'board'

describe WebController do
  include Rack::Test::Methods

  def app
    WebController.new
  end

  it "displays an empty board on the root route template" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('0', '1', '2',
                                          '3', '4', '5',
                                          '6', '7', '8')
    expect(last_response.body).not_to include 'X'
  end

  it "redirects a get request to /move to root" do
    set_up_game
    get '/move'
    expect(last_response).to be_redirect
  end

  it "updates board with move from params" do
    set_up_game
    get '/move?move=2'
    board = last_request.env['rack.session']['board']
    expect(board.rows).to eql([[0, 1, :X], [3, 4, 5], [6, 7, 8]])
  end

  def set_up_game
    get '/'
  end
end
