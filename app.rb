#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb 'Welcome to our shop'
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

get '/about' do
	erb :about
end


post '/visit' do 
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	@title = 'Thank You'
	@message = "Дорогой #{@username} с нетерпением ждем  вас #{@datetime}, для окраски в: #{@color}"

	f = File.open './public/users.txt', 'a'
	f.write "User: #{@username}, Phone: #{@phone}, Date and time: #{@datetime}, Barber: #{@barber}"
	f.close

	erb :message
end

	post '/contacts' do 
	@email = params[:email]
	@feedback = params[:feedback]
	

	@title = 'Thank You'
	@message = "Спасибо за ваш отзыв. Он очень важен для нас (на самом деле нет)"

	f = File.open './public/contacts.txt', 'a'
	f.write "Email: #{@email}, Feedback: #{@feedback}"
	f.close

	erb :message
end