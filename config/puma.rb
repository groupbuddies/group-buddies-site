#!/usr/bin/env puma

app = "group-buddies-site"
shared_path = "/home/deploy/group-buddies-site/shared"

environment 'production'

daemonize true

pidfile "#{shared_path}/pids/puma.pid"

state_path "#{shared_path}/pids/puma.state"

threads 4, 16

bind "unix://#{shared_path}/sockets/puma.sock"

activate_control_app "unix://#{shared_path}/sockets/pumactl.sock"
