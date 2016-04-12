require 'sinatra'
require 'game'
require 'players/player_factory'
require 'board_size'
require 'marks'
require 'game_options'
require 'views/view_helper'

class WebController < Sinatra::Base
  use Rack::Session::Pool
  include Marks
  include ViewHelper

  get '/' do
    session['game_option'] = nil
    @game_options = GameOptions::GAME_OPTIONS
    erb :menu
  end

  post '/menu' do
    session['board_rows'] = nil
    session['game_option'] = GameOptions.new.map(params[:option])
    redirect '/board-size'
  end

  get '/board-size' do
    @board_size_options = BoardSize::SIZES
    erb :board_size_menu
  end

  post '/board-size' do
    session['board_size'] = BoardSize.new.map(params[:option])
    redirect '/game'
  end

  get '/game' do
    if no_game_option_chosen || no_board_size_chosen
      redirect '/'
    else
      session['board_rows'] ||= Board.new(session['board_size']).rows
      current_player_move
      set_template_variables
      erb :game
    end
  end

  post '/move' do
    players = current_game_players
    game.current_player(players, current_board).add_move(params[:position])
    session['board_rows'] = game.play_one_round(players, current_board).rows
    redirect '/game'
  end

  get '/styles.css' do
    scss :styles
  end

  private

  def no_game_option_chosen
    session['game_option'] == nil
  end

  def no_board_size_chosen
    session['board_size'] == nil
  end

  def current_player_move
    unless human_vs_human
      if game_in_progress && player_ready
        session['board_rows'] = make_move
      end
    end
  end

  def player_ready
    game.current_player(current_game_players, current_board).ready?
  end

  def game_in_progress
    !current_board.game_over?
  end

  def human_vs_human
    session['game_option'] == :HumanVsHuman
  end

  def set_template_variables
    @game_option = session['game_option']
    @board = current_board
    @winner_mark = @board.winner_mark
    @draw = @board.draw?
  end

  def make_move
    game.play_one_round(current_game_players, current_board).rows
  end

  def current_game_players
    PlayerFactory.new(:web).create_players(session['game_option'])
  end

  def current_board
    Board.new(session['board_size'], session['board_rows'].flatten)
  end

  def game
    Game.new
  end
end
