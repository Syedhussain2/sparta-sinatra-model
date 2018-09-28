require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require 'pg'
require_relative './models/people.rb'
require_relative './controllers/people_controller.rb'
use Rack::Reloader
use Rack::MethodOverride
run App
