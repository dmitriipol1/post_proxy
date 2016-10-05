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
	
	# preparing and send POST request
	# uri = URI.parse("https://wl.walletone.com/checkout/checkout/Index")
	uri = URI.parse("http://31.31.203.234/test")

	response = Net::HTTP.post_form(uri, {
		"WMI_MERCHANT_ID" => "191554294939",
		"WMI_PAYMENT_AMOUNT" => "#{params[:deliveryOrderCost]}.00",
		"WMI_CURRENCY_ID" => "634",
		"WMI_PAYMENT_NO" => "#{params[:orderId]}", 
		"WMI_DESCRIPTION" => "оплата заказа №#{params[:orderId]}",
		"WMI_SUCCESS_URL" => "http://31.31.203.234/good",
		"WMI_FAIL_URL" => "http://31.31.203.234/bad",
		# "WMI_EXPIRED_DATE" => "логин", 
		# "WMI_PTENABLED" => "логин",
		# "WMI_PTDISABLED" => "логин",  
		# "WMI_RECIPIENT_LOGIN" => "логин", 
		"WMI_CUSTOMER_PHONE" => "#{params[:clientPhone]}",
		"WMI_CUSTOMER_FIRSTNAME" => "#{params[:clientFIO]}",
		# "WMI_CUSTOMER_LASTNAME" => "логин", 
		"WMI_CUSTOMER_EMAIL" => "#{params[:clientEmail]}",
		# "WMI_CULTURE_ID" => "логин", 
		"WMI_AUTO_LOCATION" => "1",
		"WMI_SIGNATURE" => "логин"
		# "WMI_PSP_MERCHANT_ID" => "логин" 
		# some additional fields w/o WMI prefix 
		# "логин" => "логин", 
		})

	# erb :show
end

post '/zapros' do
	messageFile = File.open("./public/send.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close
end

post '/send' do
	uri = URI.parse("https://wl.walletone.com/checkout/checkout/Index")
	response = Net::HTTP.post_form(uri, {
		"WMI_MERCHANT_ID" => "191554294939",
		"WMI_PAYMENT_AMOUNT" => "#{params[:deliveryOrderCost]}.00",
		"WMI_CURRENCY_ID" => "634",
		"WMI_PAYMENT_NO" => "#{params[:orderId]}", 
		"WMI_DESCRIPTION" => "оплата заказа №#{params[:orderId]}",
		"WMI_SUCCESS_URL" => "http://31.31.203.234/good",
		"WMI_FAIL_URL" => "http://31.31.203.234/bad",
		"WMI_CUSTOMER_PHONE" => "#{params[:clientPhone]}",
		"WMI_CUSTOMER_FIRSTNAME" => "#{params[:clientFIO]}",
		"WMI_CUSTOMER_EMAIL" => "#{params[:clientEmail]}",
		"WMI_AUTO_LOCATION" => "1"
		# "WMI_SIGNATURE" => "логин"
		})
	 erb response.body()

end

post '/good' do
	messageFile = File.open("./public/good.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close
end

post '/bad' do
	messageFile = File.open("./public/bad.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close
end

