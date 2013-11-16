module Lesson::Adapters
  class Podcast < Base

    # Builds from a Podcast::Normalize::Item
    def initialize(podcast_item)
      @title            = podcast_item.title
      @description      = podcast_item.description
      @backlink         = podcast_item.homepage
      @published_at     = podcast_item.published_at
      @duration         = podcast_item.media_length
      @audio_remote_url = podcast_item.media_audio
      @video_remote_url = podcast_item.media_video
    end

  end
end