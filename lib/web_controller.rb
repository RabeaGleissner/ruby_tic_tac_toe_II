require 'sinatra'
require 'haml'
require 'web_ui'
require 'game'
require 'human_web_player.rb'
require 'marks'

class WebController < Sinatra::Base
  include Marks
  use Rack::Session::Pool

  get '/' do
    session['ui'] ||= WebUi.new
    session['game'] ||= Game.new(session['ui'])
    session['board'] ||= Board.new
    puts @winner_mark
    @board = session['board']
    @winner_mark = session['ui'].winner_to_announce
    @draw = session['ui'].announce_draw?
    erb :index
  end

  get '/move' do
    session['players'] ||= [HumanWebPlayer.new(X), HumanWebPlayer.new(O)]
    session['players'].first.add_move(params[:move])
    current_board = session['board']
    session['board'] = session['game'].play(session['players'], current_board)
    redirect '/'
  end

  get '/styles.css' do
    scss :styles
  end
end
