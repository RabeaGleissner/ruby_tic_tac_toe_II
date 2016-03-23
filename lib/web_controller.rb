require 'sinatra'
require 'haml'

class WebController < Sinatra::Base
  get '/' do
    haml :index
  end
end
