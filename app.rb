#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'haml'
require "active_record"
require "pg"

configure :development do
  ActiveRecord::Base.establish_connection(
	    :adapter => "postgresql",
	    :database  => "econ",
			:username => "postgres",
			:password => "123"
	)
end

configure :production do
	ActiveRecord::Base.establish_connection(
	    :adapter => "postgresql",
	    :database  => "econ",
			:username => "postgres"
	)
end

class Victim < ActiveRecord::Base
end

enable :sessions

get '/' do
	if session['name'].nil?
		haml :login
	else
		redirect :edit
	end
end

get '/edit' do
	if session['name'].nil?
		redirect '/'
	else
		@victim = Victim.first
		
		if @victim.free == true
			@victim.update_attributes :free => false
			
			haml :edit
		else
			haml :read
		end
	end
end

post '/edit' do
	@victim = Victim.first
	@victim.content = "#{params[:content]}"
	@victim.free = true
	@victim.save
	
	redirect '/edit'
end

post "/login" do
	if params[:name] == 'loki' && params[:pass] == 'pass'
		session['name'] = params[:name]
		redirect '/edit'
	else
		redirect '/'
	end
end

set :public_folder, File.dirname(__FILE__) + '/static'
