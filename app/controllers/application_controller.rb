require 'pry'
require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    # binding.pry
    erb :index
  end

  post '/login' do
    # binding.pry
    if User.find_by(username: params["username"]) != nil
      @user = User.find_by(username: params["username"])
      session[:user_id] = @user.id
      redirect '/account'
    else
      redirect '/error'
    end
  end

  get '/account' do
    # binding.pry
    if User.find(session[:user_id]) != nil
      @user = User.find(session[:user_id])
      erb :account
    else
      redirect '/error'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/error' do
    erb :error
  end
end
