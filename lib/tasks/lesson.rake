require 'sidekiq/testing/inline'

namespace :lesson do
  desc "Parse a url into a lesson"
  task :from_url, [:url, :environment] do |task, args|
    adapter = Lesson::Adapters::Web.new_from_url(args[:url])
    lesson  = Lesson.new_from_adapter(adapter)
    lesson.study = Study.first
    lesson.save!
  end
end