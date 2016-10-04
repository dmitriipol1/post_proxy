require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'uri'

get '/' do
	erb :index
end

post '/zapros' do
    @data = params

	erb :show
end

get '/zapros' do
    @data = params

	erb :show
end

