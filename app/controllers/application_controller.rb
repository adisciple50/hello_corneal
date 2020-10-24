require './config/environment'
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
      author = Author.find_by({:username => username}).take

      puts author.to_s
      # check login exists

      if author.username == username
        # check password salt
        # https://github.com/codahale/bcrypt-ruby
        storedpassword = author.password.to_s
        hashedpassword = BCrypt::Password.new storedpassword
        if hashedpassword == password
          # generate and store login token
          token = SecureRandom.base64
          author.update({token:token})
          session[:token] = token
          # flash[:success] = "Login Successful" # A good Flash Test
          redirect '/'
        else
          flash[:danger] = "Username or Password not found"
          redirect '/login'
        end
      else
        flash[:danger] = "Username or Password not found"
        redirect '/login'
      end
    rescue Mongoid::Errors::DocumentNotFound => e
      flash[:danger] = "Username or Password not found"
      redirect '/login'
    end

    # puts user
    # puts login
    # puts password


    # issue and record session token
  end

  


end
