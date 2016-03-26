ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'rack/test'
require 'web_controller'
require 'web_ui'
require 'board'

describe WebController do
  include Rack::Test::Methods

  def app
    WebController.new
  end

  it "displays an empty board on the root route template" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).not_to include 'class="cell, full-cell"'
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

  it "displays the winning mark when a winner is available" do
    ui = WebUi.new
    ui.announce_winner(Board.new([:X, :X, :X, 3, 4, 5, 6, 7, 8]))
    get '/', {}, {'rack.session' => {'ui' => ui}}
    expect(last_response.body).to include('Game over! Winner is X.')
  end

  def set_up_game
    get '/'
  end
end
