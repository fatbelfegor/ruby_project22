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