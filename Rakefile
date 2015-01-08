require 'rubygems'
require 'bundler'

Bundler.require

unless ENV['RACK_ENV'] == 'production'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  Rake::Task['rubocop'].invoke
  task default: [:rubocop]
end

APP_FILE = 'app.rb'
APP_CLASS = 'GbSite'
require 'sinatra/assetpack/rake'
