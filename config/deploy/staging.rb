set :deploy_to, "/var/www/#{application}-staging"
set :rails_env, "staging"

set :scm, :git
set :repository, "git@github.com:innozon/Locamotiv.git"
set :branch, "sprint2"
#set :deploy_via, :remote_cache

location = "67.23.27.24"

role :app, location
role :web, location
role :db, location, :primary => true

set :user, 'deploy'
set :password, "test123"
set :ssh_options, {:forward_agent => true}