set :stages, %w(staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require "bundler/capistrano"

set :application, "cruisecontrol"


# If you aren't using Subversion to manage your source code, specify
# your SCM below:

#set :people, 'root'
#set :ssh_options, { :forward_agent => true }

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do
      ;
    end
  end

  # Avoid keeping the database.yml configuration in git.
  desc "task to create a symlink for the database files."
  task :copy_database_yml do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"

#    run "chmod 0666 #{release_path}/Gemfile.lock"
#    run "cd #{release_path}; rake db:migrate RAILS_ENV=#{configuration[:current_stage]}"
#    run "cd #{release_path}/ & rake db:migrate RAILS_ENV=staging"
  end

end

after "deploy:symlink", "deploy:copy_database_yml"
