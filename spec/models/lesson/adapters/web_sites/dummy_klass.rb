class Lesson::Adapters::WebSites::SomethingCom
  def initialize(path, nokogiri_doc)  end
  
  { title:                 'Something.com',
    description:           'Dummy Lesson::Adapters::WebSites for something.com',
    author:                'Somebody',
    backlink:              'http://something.com',
    published_at:           Time.now,
    duration:               100,
    audio_remote_url:      'http://something.com/audio.mp3',
    video_remote_url:      'http://something.com/video.mp4',
    poster_img_remote_url: 'http://something.com/poster.jpg',
  }.each { |k,v| define_method(k) {v} }
end