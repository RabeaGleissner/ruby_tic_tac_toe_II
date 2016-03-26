require 'sinatra'
require 'haml'
require 'web_ui'
require 'game'
require 'human_web_player.rb'

class WebController < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    session['ui'] ||= WebUi.new
    session['board'] ||= Board.new
    @game_state_rows = session['board'].rows
    haml :index
  end

  get '/move' do
    session['game'] ||= Game.new(session['ui'])
    session['players'] ||= [HumanWebPlayer.new(:X), HumanWebPlayer.new(:O)]
    session['players'].first.add_move(params[:move])
    current_board = session['board']
    session['board'] = session['game'].play(session['players'], current_board)
    redirect '/'
  end
end
