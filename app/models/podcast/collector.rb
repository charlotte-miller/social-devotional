class Podcast::Collector
  attr_reader :queue, :request, :response_str
  
  def initialize(podcasts = Podcast.all)
    @queue = Typhoeus::Hydra.new
    podcasts.map do |podcast| 
      request = Typhoeus::Request.new(podcast.url)
      request.on_complete do |response|
        Podcast::Parser.new(response.body).run!
      end
      @queue.queue request
    end
  end
  
  def run!
    queue.run
  end
  
end