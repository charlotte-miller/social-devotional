def video_file
  File.new(Rails.root.join('spec/files', 'video.m4v'), 'r')
end

def audio_file
  File.new(Rails.root.join('spec/files', 'audio.m4a'), 'r')
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