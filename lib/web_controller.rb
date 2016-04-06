require 'sinatra'
require 'game'
require 'player_factory'
require 'marks'
require 'game_options'

class WebController < Sinatra::Base
  use Rack::Session::Pool
  include Marks

  get '/' do
    session['game_option'] = nil
    erb :menu
  end

  post '/menu' do
    session['board_rows'] = nil
    session['game_option'] = GameOptions.new.map(params[:option])
    redirect '/game'
  end

  get '/game' do
    session['board_rows'] ||= Board.new.rows
    if no_game_option_chosen
      erb :error
    else
      play_game_with_computer
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

  def play_game_with_computer
    if human_vs_computer_option
      human_vs_computer_game
    elsif computer_vs_human_option
      computer_vs_human_game
    elsif computer_vs_computer_option
      computer_vs_computer_game
    end
  end

  def computer_vs_human_option
    session['game_option'] == :ComputerVsHuman
  end

  def computer_vs_computer_option
    session['game_option'] == :ComputerVsComputer
  end

  def human_vs_computer_option
    session['game_option'] == :HumanVsComputer
  end

  def human_vs_computer_game
    if current_board.next_player_mark == Marks::O
      make_move
    end
  end

  def computer_vs_human_game
    if current_board.next_player_mark == Marks::X
      make_move
    end
  end

  def computer_vs_computer_game
    unless current_board.game_over?
      session['board_rows'] =
        game.current_player(current_game_players, current_board).make_move(current_board).rows
      sleep 1
    end
  end

  def set_template_variables
    @game_option = session["game_option"]
    @board = current_board
    @winner_mark = @board.winner_mark
    @draw = @board.draw?
  end

  def make_move
    session['board_rows'] = game.play_one_round(current_game_players, current_board).rows
  end

  def current_game_players
    PlayerFactory.new.create_web_players(session['game_option'])
  end

  def current_board
    Board.new(session['board_rows'].flatten)
  end

  def game
    Game.new
  end
end
