# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

[
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
  
].each {|attrs| FactoryGirl.create(:podcast, attrs)}
