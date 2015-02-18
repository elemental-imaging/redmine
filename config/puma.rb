threads     2,8
workers     2
bind        "unix:/usr/share/nginx/html/ei-redmine/tmp/sockets/puma.sock"
pidfile     "/usr/share/nginx/html/ei-redmine/tmp/pids/puma.pid"
state_path  "/usr/share/nginx/html/ei-redmine/tmp/pids/puma.state"
preload_app!
