class Lesson < ActiveRecord::Base
  attr_accessible :audio_url, :backlink, :description, :position, :series_id, :title, :video_url
end
