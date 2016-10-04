require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'uri'

get '/' do
	erb :index
end

get '/zapros' do
	@data = params
	erb :show
end

post '/zapros' do
	messageFile = File.open("./public/log.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close
	
	erb :show

end
