gb::ruby { 'ruby-2.1.5': }

gb::capistrano { 'gb-site': }

gb::nginx_conf { 'gb-site':
  path => 'config/nginx.conf'
}
