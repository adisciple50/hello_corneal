require_relative '../../config/environment'
require_relative '../../lib/user'
require 'bcrypt'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end
end
