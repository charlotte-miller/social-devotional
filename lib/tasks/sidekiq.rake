namespace :sidekiq do
  desc "Stop sidekiq"
  task :stop => :environment do
    system "if [ -f #{Rails.root}/tmp/pids/sidekiq.pid ]; then bundle exec sidekiqctl stop #{Rails.root}/tmp/pids/sidekiq.pid; fi"
  end

  desc "Start sidekiq"
  task :start => :environment do
    system "nohup bundle exec sidekiq -e #{Rails.env} -C #{Rails.root}/config/sidekiq.yml -P #{Rails.root}/tmp/pids/sidekiq.pid >> #{Rails.root}/log/sidekiq.log 2>&1 &"
  end
end