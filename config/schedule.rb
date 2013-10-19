# Use this file to easily define all of your cron jobs. 
# Learn more: http://github.com/javan/whenever
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# # Many shortcuts available: :hour, :day, :month, :year, :reboot
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days, :at => '12pm' do
#   runner "AnotherModel.prune_old_records"
# end
#
#
# # run this task only on servers with the :app role in Capistrano
# # see Capistrano roles section below
# every :day, :at => '12:20am', :roles => [:app] do
#   rake "app_server:task"
# end

every :day, :at => '1am' do
  runner "Podcast.pull_updates"
end