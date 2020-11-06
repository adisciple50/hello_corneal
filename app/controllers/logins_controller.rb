class LoginsController < ApplicationController

  get "/login" do
    erb :"login/login.html"
  end

  post '/login' do
    begin
      session[:token] = User(params['username']).authenticate! params['password']
      # issue and record session token
      # flash[:success] = "Login Successful" # A good Flash Test
      redirect '/'
    rescue
      # flash[:danger] = "Username or Password not found"
      redirect '/login'
    end
  end
end
