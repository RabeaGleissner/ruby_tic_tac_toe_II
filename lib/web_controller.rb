require 'sinatra'
require 'haml'
require 'web_ui'
require 'game'
require 'human_web_player.rb'

class WebController < Sinatra::Base
  use Rack::Session::Pool

  get '/' do
    session['ui'] ||= WebUi.new
    ui = session['ui']
    session['game'] ||= Game.new(session['ui'])
    session['board'] ||= Board.new
    board = session['board']
    @game_state_rows = board.rows
    @winner = ui.winner_to_display if ui.winner_to_display != nil
    haml :index
  end

  get '/move' do
    session['players'] ||= [HumanWebPlayer.new(:X), HumanWebPlayer.new(:O)]
    session['players'].first.add_move(params[:move])
    current_board = session['board']
    session['board'] = session['game'].play(session['players'], current_board)
    redirect '/'
  end

  get '/styles.css' do
    scss :styles
  end
end
