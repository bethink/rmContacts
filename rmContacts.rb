require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'active_record'
require 'pg'

load 'rmContactFiles.rb'

class User < ActiveRecord::Base

end


get '/' do
  users = User.all
  "What the fuck... #{users.inspect}"
end

get '/contact' do
  'Hi this is karhti'
end

get 'contacts' do

end


