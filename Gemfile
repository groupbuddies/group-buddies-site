source 'https://rubygems.org'

gem 'gibbon', '0.3.5'
gem 'pony'
gem 'puma'
gem 'sass'
gem 'sinatra'
gem 'rake'
gem 'sinatra-assetpack', require: 'sinatra/assetpack'
gem 'foreman'
gem 'dotenv'
gem 'newrelic_rpm'

group :test do
  gem 'rubocop', require: false
end

group :deploy do
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-foreman', github: 'groupbuddies/capistrano-foreman', branch: :master
end
