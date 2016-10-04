require 'rubygems'
require 'sinatra'

get '/' do
	erb :index
end

post '/post' do
		erb "Hello"
end
