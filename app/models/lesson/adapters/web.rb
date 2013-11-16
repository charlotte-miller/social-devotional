require 'nokogiri'
module Lesson::Adapters
  class Web < Base

    # Builds from a url string
    def new_from_url(url)
      request = Typhoeus::Request.new(url, followlocation: true)
      request.on_complete do |response|
        return new( Nokogiri::HTML(response.response_body) )  if response.success?
        raise "Timeout: #{url}"                               if response.timed_out?
        raise "#{response.return_message}: #{url}"            if response.code == 0
        raise "HTTP request failed: #{response.code}"
      end
      request.run
    end

    # Builds from a Nokogiri::HTML doc
    def initialize(nokogiri_doc)

    end

  end
end