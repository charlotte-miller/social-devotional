module Typhoeus
  
  # Creates a Typhoeus request (w/ error handling)
  # Executes the block (passing response )
  def go_to_url_then( url, &on_success )
    raise ArgumentError.new('Block Required') unless block_given?
    
    request = Typhoeus::Request.new(url, followlocation: true)
    request.on_complete do |response|
      return on_success.call(response)                if response.success?
      raise "Timeout: #{url}"                         if response.timed_out?
      raise "#{response.return_message}: #{url}"      if response.code == 0
      raise "HTTP request failed: #{response.code}"
    end
    request.run
  end
  
end