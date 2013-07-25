require 'puma/capistrano'


set :application, "group-buddies-site"
set :repository,  "git@github.com:groupbuddies/group-buddies-site.git"
set :branch, "capistrano"
set :scm, :git
set :deploy_via, :remote_cache

server '37.139.7.70', :app, :web

after 'deploy:setup', 'create_sockets_folder'

desc "Creates sockets folder"
task :create_sockets_folder do
  run "mkdir #{shared_path}/sockets"
end
