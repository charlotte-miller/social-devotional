class Podcast::Collector
  attr_reader :hydra, :queue
  
  def initialize(podcasts = Podcast.all)
    podcasts = Array.wrap(podcasts)
    
    @hydra = Typhoeus::Hydra.new
    @queue = @hydra.queued_requests
    podcasts.map do |podcast| 
      request = Typhoeus::Request.new(podcast.url)
      request.on_complete do |response|
        feed = Podcast::Parser.new(response.body)
        if feed.last_updated > podcast.last_updated
          podcast.update_from_feed( feed )
        end
      end
      @hydra.queue request
    end
  end
  
  def run!
    hydra.run
  end
  
end