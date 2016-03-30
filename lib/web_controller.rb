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
    session['board_rows'] ||= Board.new.rows
    @board = Board.new(session['board_rows'].flatten(1))
    @winner_mark = @board.winner_mark
    @draw = @board.draw?
    erb :index
  end

  get '/move' do
    session['players'] ||= [HumanWebPlayer.new(X), HumanWebPlayer.new(O)]
    session['players'].first.add_move(params[:move])
    current_board = Board.new(session['board_rows'].flatten(1))
    session['board_rows'] = Game.new(WebUi.new).play(session['players'], current_board).rows
    redirect '/'
  end

  get '/styles.css' do
    scss :styles
  end
end
