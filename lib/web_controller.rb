require 'sinatra'
require 'web_ui'
require 'game'
require 'player_factory'
require 'marks'

class WebController < Sinatra::Base
  include Marks
  use Rack::Session::Pool

  get '/' do
    session['game_option'] = nil
    erb :menu
  end

  post '/menu' do
    session['board_rows'] = nil
    session['game_option'] = GameOptionsMapper.new.map(params[:option])
    session['first_move'] = true
    redirect '/game'
  end

  get '/game' do
    session['board_rows'] ||= Board.new.rows
    if no_game_option_chosen
      erb :error
    else
      if session['game_option'] == :ComputerVsComputer
        play_computer_vs_computer_game
      elsif session['game_option'] == :ComputerVsHuman
        play_first_computer_move
      end
    set_template_variables
    erb :game
    end
  end

  def set_template_variables
    @game_option = session["game_option"]
    @board = current_board
    @winner_mark = @board.winner_mark
    @draw = @board.draw?
  end

  post '/move' do
    players = current_game_players
    game.current_player(players, current_board).add_move(params[:position])
    session['board_rows'] = game.play(players, current_board).rows
    redirect '/game'
  end

  get '/styles.css' do
    scss :styles
  end

  def no_game_option_chosen
    session['game_option'] == nil
  end

  def first_computer_move
    (session['game_option'] == :ComputerVsHuman) && session['first_move'] == true
  end

  def play_computer_vs_computer_game
    unless current_board.game_over?
      session['board_rows'] =
        game.current_player(current_game_players, current_board).make_move(current_board).rows
      sleep 1
    end
  end

  def play_first_computer_move
    if first_computer_move
      current_game_players
      session['board_rows'] = game.play(current_game_players, current_board).rows
      session['first_move'] = false
    end
  end

  def current_game_players
      PlayerFactory.new(WebUi.new).create_web_players(session['game_option'])
  end

  def current_board
    Board.new(session['board_rows'].flatten)
  end

  def game
    Game.new(WebUi.new)
  end
end
