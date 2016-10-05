require 'rubygems'
require 'sinatra'
require 'net/http'
require 'uri'

get '/' do
	erb :index
end

post '/zapros' do
	messageFile = File.open("./public/log.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________\n"
	messageFile.close

	uri = URI.parse("https://wl.walletone.com/checkout/checkout/Index")
	response = Net::HTTP.post_form(uri, {
		"WMI_MERCHANT_ID" => "191554294939",
		"WMI_PAYMENT_AMOUNT" => "#{params[:deliveryOrderCost]}.00",
		"WMI_CURRENCY_ID" => "643",
		"WMI_PAYMENT_NO" => "#{params[:orderId]}",
		"WMI_DESCRIPTION" => "Оплата заказа №#{params[:orderId]}",
		"WMI_SUCCESS_URL" => "http://31.31.203.234/good",
		"WMI_FAIL_URL" => "http://31.31.203.234/error",
		"WMI_CUSTOMER_PHONE" => "#{params[:clientPhone]}",
		"WMI_CUSTOMER_FIRSTNAME" => "#{params[:clientFIO]}",
		"WMI_CUSTOMER_EMAIL" => "#{params[:clientEmail]}",
		"WMI_AUTO_LOCATION" =>"1"
		})

	redirect "https://wl.walletone.com" + response['location'], 302
end

post '/good' do
	messageFile = File.open("./public/good.txt", "a") 
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close

	return "WMI_RESULT=OK"
	erb :good
end

post '/error' do
	messageFile = File.open("./public/bad.txt", "a")
	params.each do |key,value|
		messageFile.write "Key:#{key}, value:#{value}\n"
	end
	messageFile.write "___________________________________________"
	messageFile.close

	return "WMI_RESULT=RETRY&WMI_DESCRIPTION=Сервер временно недоступен"
	erb :error
end

