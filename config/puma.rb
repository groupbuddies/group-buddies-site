workers Integer(ENV['PUMA_WORKERS'] || 2)
threads Integer(ENV['MIN_THREADS'] || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

environment ENV['RACK_ENV'] || 'development'

if %w(production staging).include?(ENV['RACK_ENV'])
  bind "unix:///var/www/#{ENV['APP_NAME']}/shared/sockets/puma.sock"
else
  port ENV['PORT'] || 3000
end
