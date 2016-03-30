ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'rack/test'
require 'web_controller'
require 'web_ui'
require 'board'
require 'marks'

describe WebController do
  include Marks
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
    rows = last_request.env['rack.session']['board_rows']
    expect(rows).to eql([[0, 1, Marks::X], [3, 4, 5], [6, 7, 8]])
  end

  it "displays the winning mark when a winner is available" do
    ui = WebUi.new
    rows = Board.new([Marks::X, Marks::X, Marks::X, 3, 4, 5, 6, 7, 8]).rows
    get '/', {}, {'rack.session' => {'board_rows' => rows}}
    expect(last_response.body).to include('Game over! Winner is X.')
  end

  it "displays the styling when the route /styles.css is requested" do
    get '/styles.css'
    expect(last_response.body).to include('box-sizing: border-box;')
  end

  def set_up_game
    get '/'
  end
end
