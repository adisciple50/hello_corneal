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

  get "/login" do
    erb :"login/login.html"
  end

  post '/login' do
    username = params['username']
    password = params['password']
    begin
      session[:token] = User(username).authenticate! password
      # issue and record session token
      # flash[:success] = "Login Successful" # A good Flash Test
      redirect '/'
    rescue
      # flash[:danger] = "Username or Password not found"
      redirect '/login'
    end
  end
end
