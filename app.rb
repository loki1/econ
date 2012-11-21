#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'haml'
#require 'sass'

enable :sessions

get('/') {haml :login}

post "/login" do
	session['name'] = params[:name]

	redirect '/index'
end

get('/index') {haml :index}