require "rvm/capistrano"
require "bundler/capistrano"
set :rvm_type, :system
set :rvm_ruby_string, "ruby-1.9.3-p448@g" # Defaults to 'default'
set :bundle_dir, ''
set :bundle_flags, '--system --quiet'
set :application, "g"
set :scm, :git
set :branch, "master"
set :repository,  'git@github.com:fbrusatti/g.git'
set :deploy_to, '/var/www'
set :deploy_via, :remote_cache
server "192.168.0.32", :app, :web, :db, :primary => true

set :user, "gutierrez"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :scm_passphrase, "symbian86!"

# for CarrierWave
set :shared_children, shared_children + %w{public/uploads}
after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      sudo "/etc/init.d/unicorn #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/g"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
