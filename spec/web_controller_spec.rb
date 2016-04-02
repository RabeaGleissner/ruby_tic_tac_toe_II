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

  it "displays menu options on the root route template" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include 'form class="game-options-form" method="post"', 'game option'
  end

  it "clears board on post request to /menu" do
    post '/menu', {'option' => '1'}, {'rack.session' => {'board_rows' => ['grid']}}
    expect(last_request.env['rack.session']['board_rows']).to eql(nil)
  end

  it "redirects to game route after a post request to /menu" do
    post '/menu', 'option' => '1'
    expect(last_response).to be_redirect
  end

  it "adds game options choice from params into session" do
    post '/menu', 'option' => '1'
    expect(last_request.env['rack.session']['game_option']).to eql(:HumanVsHuman)
  end

  it "displays empty board on game route template for a Human vs Human game" do
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsHuman}}
    expect(last_response).to be_ok
    expect(last_response.body).not_to include "class='cell full'"
  end

  it "gets and displays computer's first move for Computer vs Human game", slow: true do
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsHuman, 'first_move' => true}}
    rows = last_request.env['rack.session']['board_rows']
    expect(rows.flatten).to include :X
    expect(Board.new(rows.flatten).available_positions.length).to be 8
  end

  it "plays first move of Computer vs Computer game", slow: true do
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsComputer}}
    rows = last_request.env['rack.session']['board_rows']
    expect(rows.flatten).to include :X
    expect(Board.new(rows.flatten).available_positions.length).to be 8
  end

  it "redirects a get request to /move to game" do
    rows = [Marks::X, Marks::X, Marks::X, 3, 4, 5, 6, 7, 8]
    get '/move', {}, {'rack.session' => {'game_option' => :HumanVsHuman, 'board_rows' => rows}}
    expect(last_response).to be_redirect
    expect(last_response.location).to include '/game'
  end

  it "updates board with move from params" do
    board_rows = [0, Marks::X, Marks::X, 3, 4, 5, 6, 7, 8]
    get '/move?move=8', {}, {'rack.session' => {'game_option' => :HumanVsHuman, 'board_rows' => board_rows}}
    board_rows = last_request.env['rack.session']['board_rows']
    expect(board_rows).to eql([[0, Marks::X, Marks::X], [3, 4, 5], [6, 7, Marks::O]])
  end

  it "displays game over message with winning mark when winner is available" do
    ui = WebUi.new
    rows = [Marks::X, Marks::X, Marks::X, 3, 4, 5, 6, 7, 8]
    get '/game', {}, {'rack.session' => {'board_rows' => rows, 'game_option' => '2'}}
    expect(last_response.body).to include('Game over! Winner is X.')
  end

  it "displays error when trying to acces game page without a game option" do
    get '/game'
    expect(last_response.body).to include('Something went wrong')
  end

  it "resets the game option when the root route is requested" do
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsComputer}}
    get '/'
    expect(last_request.env['rack.session']['game_option']).to eql(nil)
  end

  it "displays styling when the route /styles.css is requested" do
    get '/styles.css'
    expect(last_response.body).to include('box-sizing: border-box;')
  end

  it "disables board when game is over" do
    board_rows = [Marks::X, Marks::X, Marks::X, Marks::O, Marks::O, 5, 6, 7, 8]
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsComputer, 'board_rows' => board_rows}}
    expect(last_response.body).to include("class='board disabled'")
  end

  it "disables board during computer vs computer game", slow: true do
    board_rows = [Marks::X, 1, Marks::X, Marks::O, Marks::O, Marks::X, Marks::O, 7, 8]
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsComputer, 'board_rows' => board_rows}}
    expect(last_response.body).to include("class='board disabled'")
  end
end
