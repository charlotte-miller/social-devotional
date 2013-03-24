class Podcast::Collector
  REQUEST_QUEUE= Typhoeus::Hydra.new
  attr_reader :podcast, :request, :response_str
  
  def self.all
    collector = new
    Podcast.all.each do |podcast|
      new(podcast)
    end
    
  end
  
  def initialize(podcast_obj)
    @podcast = podcast_obj
    @request = Typhoeus::Request.new(podcast.url)
    @request.on_complete do |response|
      Ox.parse(response.body)
      
    #   post = JSON.parse(response.body)
    #   third_request = Typhoeus::Request.new(post.links.first) # get the first url in the post
    #   third_request.on_complete do |response|
    #     # do something with that
    #   end
    #   hydra.queue third_request
    #   return post
    end
    
    REQUEST_QUEUE.queue @request
  end
  
  def pull
    REQUEST_QUEUE.run
  end
  
end

# # Generally, you should be running requests through hydra. Here is how that looks
# hydra = Typhoeus::Hydra.new
#  
# first_request = Typhoeus::Request.new("http://localhost:3000/posts/1.json")
# first_request.on_complete do |response|
#   post = JSON.parse(response.body)
#   third_request = Typhoeus::Request.new(post.links.first) # get the first url in the post
#   third_request.on_complete do |response|
#     # do something with that
#   end
#   hydra.queue third_request
#   return post
# end
# second_request = Typhoeus::Request.new("http://localhost:3000/users/1.json")
# second_request.on_complete do |response|
#   JSON.parse(response.body)
# end
# hydra.queue first_request
# hydra.queue second_request
# hydra.run # this is a blocking call that returns once all requests are complete
#  
# first_request.handled_response # the value returned from the on_complete block
# second_request.handled_response # the value returned from the on_complete block (parsed JSON)