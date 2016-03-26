require 'sinatra'
require 'haml'
require 'web_ui'
require 'game'
require 'human_web_player.rb'

class WebController < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    session['ui'] ||= WebUi.new
    session['game'] ||= Game.new(session['ui'])
    session['board'] ||= Board.new
    @game_state_rows = session['board'].rows
    haml :index
  end

  get '/move' do
    player1 = HumanWebPlayer.new(:X)
    player2 = HumanWebPlayer.new(:O)
    player1.add_move(params[:move])
    game = session['game']
    board = session['board']
    session['board'] = game.play(player1, player2, board)
    redirect '/'
  end
end
