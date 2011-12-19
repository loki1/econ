#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'haml'

get('/') {haml :index}