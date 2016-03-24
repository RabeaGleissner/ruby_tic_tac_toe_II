require 'sinatra'
require 'haml'
require 'web_ui'
require 'game'

class WebController < Sinatra::Base
  get '/' do
    ui = WebUi.new
    Game.new(ui)
    @game_state_rows = ui.game_state_rows
    haml :index
  end
end
