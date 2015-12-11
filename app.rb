#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "mail"

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
	@error = 'Something wrong!'
	erb :about
end


post '/visit' do 
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = { :username => 'Введите имя', :phone => 'Укажите телефон', :datetime => 'Ввведите дату и время' }

	# For each field check value
	@error = hh.select {|key,_| params[key] == ''}.values.join(",  ")

	if @error != ''
		return erb :visit
	end


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

	Mail.defaults do
		delivery_method :smtp, {
			:address 							=> 'smtp.gmail.com',
			:port  		 						=>'587',
			:enable_starttls_auto => true,
			:user_name 						=> 'jewelgatorstv@gmail.com',
			:password 						=> 'templar1975',
			:authentication 			=> :plain,
			:domain								=> 'gmail.com'
		}
	end

	mail = Mail.new do
		from 		 'BarberShop <jewelgatorstv@gmail.com>'
		to 			 'jewelgatorstv@gmail.com'
		subject  'New feedback has been recieved'
		body	 	 'Please check back your contacts file to see it!'
	end

	con_err = { :email => 'Введите адрес электронной почты', :feedback => 'Оставьте отзыв' }

	# For each field check value
	@error = con_err.select {|key,_| params[key] == ''}.values.join(",  ")

	if @error != ''
		return erb :contacts
	else
		mail.deliver!
	end
	

	@title = 'Thank You'
	@message = "Спасибо за ваш отзыв. Он очень важен для нас (на самом деле нет)"


	f = File.open './public/contacts.txt', 'a'
	f.write "Email: #{@email}, Feedback: #{@feedback}"
	f.close
	erb :message
end



