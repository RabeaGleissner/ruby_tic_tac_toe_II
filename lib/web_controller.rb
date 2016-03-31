require 'sinatra'
require 'web_ui'
require 'game'
require 'player_factory'
require 'marks'

class WebController < Sinatra::Base
  include Marks
  use Rack::Session::Pool

  get '/' do
    erb :menu
  end

  post '/menu' do
    session['game_option'] = params[:option]
    session['first_move'] = true
    redirect '/game'
  end

  get '/game' do
    session['board_rows'] ||= Board.new.rows
    if first_computer_move
      players = PlayerFactory.new(WebUi.new).create_web_players(session['game_option'])
      session['board_rows'] = Game.new(WebUi.new).play(players, Board.new).rows
      session['first_move'] = false
    end
    @board = Board.new(session['board_rows'].flatten)
    @winner_mark = @board.winner_mark
    @draw = @board.draw?
    erb :game
  end

  get '/move' do
    players = PlayerFactory.new(WebUi.new).create_web_players(session['game_option'])
    game = Game.new(WebUi.new)
    current_board = Board.new(session['board_rows'].flatten)
    player = game.current_player(players, current_board)
    player.add_move(params[:move])
    session['board_rows'] = game.play(players,current_board).rows
    redirect '/game'
  end

  get '/styles.css' do
    scss :styles
  end

  def first_computer_move
    session['game_option'] == "3" && session['first_move'] == true
  end
end
