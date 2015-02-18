# config valid only for current version of Capistrano
lock "3.3.5"

set :application,    "ei-redmine"
set :repo_url,       "git@github.com:elemental-imaging/redmine.git"
set :branch,         "origin/ei"
set :deploy_to,      "/usr/share/nginx/html/#{fetch(:application)}"
set :puma_conf,      "#{release_path}/config/puma.rb"
