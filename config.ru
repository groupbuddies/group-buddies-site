require 'rubygems'
require 'bundler'

Bundler.require

set :environment, (ENV['RACK_ENV'] || 'development').to_sym
set :app_file,     'app.rb'
# disable :run

require './app.rb'

if settings.environment == :production
  log = File.new('log/sinatra.log', 'a')
  STDOUT.reopen(log)
  STDERR.reopen(log)
end

run Sinatra::Application
