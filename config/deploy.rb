# Capistrano multistage
require 'capistrano/ext/multistage'

# Bundler integration
require "bundler/capistrano"

# Application setup
set :application, "mine.robinjam.net"
set :deploy_via, :remote_cache
set :user, "minecraft"
set :use_sudo, false

# SCM setup
set :scm, :git
set :repository, "file:///home/git/mine.robinjam.net.git"
set :local_repository, "git@mine.robinjam.net:mine.robinjam.net.git"
set :scm_username, "minecraft"
set :git_enable_submodules, 1

# Passenger setup
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code' do
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
end
