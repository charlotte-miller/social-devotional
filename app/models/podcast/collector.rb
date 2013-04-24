class Podcast::Collector
  attr_reader :hydra, :queue
  
  
  # Accepts an array of Podcast objects
  # Pulls the current podcast XML
  # Executes the &block on_complete passing the podcast_obj and podcast_xml
  def initialize( podcasts, &on_complete )
    valid_arguments = podcasts.is_a?( Array ) && podcasts.all? {|p| p.is_a? Podcast }
    raise ArgumentError.new('@podcast collection required') unless valid_arguments

    @hydra = Typhoeus::Hydra.new
    @queue = @hydra.queued_requests
    podcasts.map do |podcast| 
      request = Typhoeus::Request.new(podcast.url)
      request.on_complete do |response|
        on_complete.call(podcast, response.body)
      end if block_given?
      
      @hydra.queue request
    end
  end
  
  def run!
    hydra.run
  end
  
end