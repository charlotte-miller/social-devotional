require 'spec_helper'

module Lesson::Adapters::WebSites
  describe ThevillagechurchNet do
    vcr_lesson_web
    
    let(:url) { @url || 'http://www.thevillagechurch.net/sermon/the-promise-of-a-savior/' }
    let(:nokogiri_doc) { Nokogiri::HTML(open url) }
    subject { ThevillagechurchNet.new(url, nokogiri_doc) }
  
    it_behaves_like 'a Lesson::Adapter', {
      title: 'The Promise of a Savior',
      description: '',
      author:'Matt Chandler',
      backlink: 'http://www.thevillagechurch.net/sermon/the-promise-of-a-savior/',
      published_at: Time.parse('Dec 01, 2013'),
      duration: 2851,
      poster_img_remote_url: 'http://b.vimeocdn.com/ts/456/926/456926173_1280.jpg',
      audio_remote_url: 'http://media.thevillagechurch.net/sermons/audio/201312011115FMWC21ASAAA_MattChandler_AdventPt1-ThePromiseOfASavior.mp3',
      video_remote_url: 'http://player.vimeo.com/video/80900234', }
  end
end