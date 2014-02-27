require "rvm/capistrano"
require "bundler/capistrano"
# require "whenever/capistrano"

server "origin.socialdevotional.com", :web, :app, :db, primary: true

set :application, "social_devotional"
set :repository,  "git@bitbucket.org:chip_miller/social-devotional.git"

set :user, "chip"
set :port, 55555
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, :git
set :branch, 'master'
set :rvm_type, :system

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases


role :web, "origin.socialdevotional.com" # NGINX
role :app, "origin.socialdevotional.com" # This may be the same as your `Web` server
role :db,  "origin.socialdevotional.com", :primary => true # This is where Rails migrations will run
role :db,  "origin.socialdevotional.com"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"


namespace :deploy do
  # after "deploy:setup",            "deploy:setup_config"
  # after "deploy:finalize_update",  "deploy:symlink_config"
  # before "deploy",                 "deploy:check_revision"
  # before "deploy:create_symlink",  "deploy:sidekiq_stop"
  # after  "deploy:create_symlink",  "deploy:sidekiq_start"
  
  # before "deploy:cold", "deploy:install_bundler"

  # task :install_bundler, :roles => :app do
  #   run "type -P bundle &>/dev/null || { gem install bundler --no-rdoc --no-ri; }"
  # end
  
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  # Sidekiq
  task :sidekiq_start do
    run "(test -e /etc/init.d/prebuy_sidekiq && /etc/init.d/prebuy_sidekiq start) || $(exit 0)"
    sleep 5
  end

  task :sidekiq_stop do
    run "(test -e /etc/init.d/prebuy_sidekiq && /etc/init.d/prebuy_sidekiq stop) || $(exit 0)"
    sleep 5
  end
  
  # Unicorn
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

end

# Sitemap
# https://github.com/kjvarga/sitemap_generator#deployments--capistrano