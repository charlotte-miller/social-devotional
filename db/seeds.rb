# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

require 'sunspot_test'
require Rails.root.join('spec/support/initializers/quickerclip.rb')
AWS.stub!

puts "Building - Churces"
churches = [
  {
    church: FactoryGirl.create(:church, name:'Mars Hill', homepage:'http://marshill.com/'),
    title: 'Mars Hill Sermons',
    url: 'http://feeds.feedburner.com/marshill/podcast'
  },
  {
    church: FactoryGirl.create(:church, name:'The Village Church', homepage:'http://www.thevillagechurch.net/'),
    title: 'The Village Church Sermons',
    url: 'http://feeds.feedburner.com/TVCSermonAudio'
  }
  
]
podcasts = churches.map {|attrs| FactoryGirl.create(:podcast, attrs)}

################################
# Quickly Fake Data for local UI
######
podcasts.each do |podcast|
  puts "Building - Stuidies for #{podcast.church.name}"
  10.times do
    study = FactoryGirl.create(:study_with_n_lessons,  n: rand(3..14), podcast: podcast)
    
    # lessons
    lessons = study.lessons.each do |lesson| 
      user = User.order("RAND()").first if rand(9) > 6
      user ||= FactoryGirl.create(:user, profile_image: nil)
      
      questions = 6.times.map do
        FactoryGirl.build(:question, source: lesson, author: user, permanent_approver:nil)
      end
      Question.import questions
      
      answers = Question.last(6).map do |question|
        rand(7).times.map { FactoryGirl.build(:answer, author: user, question: question) }
      end.flatten
      Answer.import answers
    end
    
  end
end

