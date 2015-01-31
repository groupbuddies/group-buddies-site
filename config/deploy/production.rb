server 'groupbuddies.com', user: 'deploy', roles: %w(web app db), primary: true
set :deploy_to, '/var/www/gb-site'
set :ssh_options, forward_agent: true
