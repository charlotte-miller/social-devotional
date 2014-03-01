def video_file
  (@_opened_files << File.new(Rails.root.join('spec/files', 'video.m4v'), 'rb')).last
end

def audio_file
  (@_opened_files << File.new(Rails.root.join('spec/files', 'audio.m4a'), 'rb')).last
end

def img_file
  (@_opened_files << File.new(Rails.root.join('spec/files', 'pixel.gif'), 'rb')).last
end

def video_upload
  Rack::Test::UploadedFile.new(video_file.path, 'video/x-m4v')
end

def audio_upload
  Rack::Test::UploadedFile.new(audio_file.path, 'audio/x-m4a')
end

def url_to_regex(url_str)
  Regexp.new Regexp.quote(url_str)
end

RSpec.configure do |config|
  config.before(:each) { @_opened_files = [] }
  config.after( :each) do
    @_opened_files.each do |file|
      file.close unless file.closed?
    end
  end
end