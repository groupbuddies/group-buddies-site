require "rvm/capistrano"
require "bundler/capistrano"
require 'puma/capistrano'

set :application, "group-buddies-site"
set :repository,  "git@github.com:groupbuddies/group-buddies-site.git"
set :branch, "master"
set :scm, :git
set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/#{application}"
set :use_sudo, false
set :user, "deploy"

server '37.139.7.70', :app, :web
