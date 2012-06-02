require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'active_record'
require 'pg'

load 'config/db.rb'
load 'model/user.rb'
load 'model/contact.rb'