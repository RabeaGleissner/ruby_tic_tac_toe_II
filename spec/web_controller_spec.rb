ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'rack/test'
require 'web_controller'
require 'board'
require 'marks'

describe WebController do
  include Marks
  include Rack::Test::Methods
  HUMAN_VS_HUMAN = '1'
  X_WINNING_ROWS = [Marks::X, Marks::X, Marks::X, 3, 4, 5, 6, 7, 8]
  GAME_IN_PROGRESS_ROWS = [0, Marks::X, Marks::O, 3, 4, 5, 6, 7, 8]

  def app
    WebController.new
  end

  it "displays menu options on the root route template" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include 'form class="game-options-form" method="post"', 'game option'
  end

  it "clears board on post request to /menu" do
    post '/menu', {'option' => HUMAN_VS_HUMAN}, {'rack.session' => {'board_rows' => 'some value'}}
    expect(last_request.env['rack.session']['board_rows']).to eql(nil)
  end

  it "redirects to game route after a post request to /menu" do
    post '/menu', 'option' => HUMAN_VS_HUMAN
    expect(last_response).to be_redirect
  end

  it "adds game options choice from params into session" do
    post '/menu', 'option' => HUMAN_VS_HUMAN
    expect(last_request.env['rack.session']['game_option']).to eql(:HumanVsHuman)
  end

  it "displays empty board on game route template for a Human vs Human game" do
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsHuman}}
    expect(last_response).to be_ok
    expect(last_response.body).not_to include "class='cell full'"
  end

  it "gets and displays computer's first move for Computer vs Human game", slow: true do
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsHuman, 'first_move' => true}}
    rows = last_request.env['rack.session']['board_rows'].flatten
    expect(rows).to include :X
    expect(Board.new(rows).available_positions.length).to be 8
  end

  it "plays first move of Computer vs Computer game", slow: true do
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsComputer}}
    rows = last_request.env['rack.session']['board_rows'].flatten
    expect(rows).to include :X
    expect(Board.new(rows).available_positions.length).to be 8
  end

  it "redirects a post request to /move to game" do
    post '/move', {'position' => '1'}, {'rack.session' => {'game_option' => :HumanVsHuman, 'board_rows' => GAME_IN_PROGRESS_ROWS}}
    expect(last_response).to be_redirect
    expect(last_response.location).to include '/game'
  end

  it "updates board with move from params" do
    post '/move', {'position' => '8'}, {'rack.session' => {'game_option' => :HumanVsHuman, 'board_rows' => GAME_IN_PROGRESS_ROWS}}
    board_rows = last_request.env['rack.session']['board_rows']
    expect(board_rows).to eql([[0, Marks::X, Marks::O], [3, 4, 5], [6, 7, Marks::X]])
  end

  it "displays game over message with winning mark when winner is available" do
    get '/game', {}, {'rack.session' => {'board_rows' => X_WINNING_ROWS, 'game_option' => :HumanVsComputer}}
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
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsComputer, 'board_rows' => X_WINNING_ROWS}}
    expect(last_response.body).to include("class='board disabled'")
  end

  it "disables board during computer vs computer game", slow: true do
    get '/game', {}, {'rack.session' => {'game_option' => :ComputerVsComputer, 'board_rows' => GAME_IN_PROGRESS_ROWS}}
    expect(last_response.body).to include("class='board disabled'")
  end

  it "plays move for computer after human move for Human vs Computer game" do
    post '/move', {'position' => '8'}, {'rack.session' => {'game_option' => :HumanVsComputer, 'board_rows' => GAME_IN_PROGRESS_ROWS}}
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsComputer}}
    board_rows = last_request.env['rack.session']['board_rows'].flatten
    expect(Board.new(board_rows).available_positions.length).to eq 5
  end

  it "plays move for random player after human move for Human vs Random game" do
    post '/move', {'position' => '8'}, {'rack.session' => {'game_option' => :HumanVsRandom, 'board_rows' => GAME_IN_PROGRESS_ROWS}}
    get '/game', {}, {'rack.session' => {'game_option' => :HumanVsRandom}}
    board_rows = last_request.env['rack.session']['board_rows'].flatten
    expect(Board.new(board_rows).available_positions.length).to eq 5
  end
end
