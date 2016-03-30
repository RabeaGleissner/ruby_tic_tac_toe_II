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
    session['board'] ||= Board.new
    @board = session['board']
    @winner_mark = WebUi.new.winner_to_announce(@board)
    @draw = WebUi.new.announce_draw?(@board)
    erb :index
  end

  get '/move' do
    session['players'] ||= [HumanWebPlayer.new(X), HumanWebPlayer.new(O)]
    session['players'].first.add_move(params[:move])
    current_board = session['board']
    session['board'] = Game.new(WebUi.new).play(session['players'], current_board)
    redirect '/'
  end

  get '/styles.css' do
    scss :styles
  end
end
