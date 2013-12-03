require 'nokogiri'

# === Lesson::Adapters::Web
# Selects and delegates parsing to domain specific adapters
#
#   1) looks up a lib/site_adapter based on the domain
#   2) delegates ATTRIBUTES to SiteAdapters
#
module Lesson::Adapters
  class Web < Base
    attr_reader :domain_adapter
    delegate *Lesson::Adapters::Base::ATTRIBUTES, to: :domain_adapter
    
    # Builds from a url string
    def self.new_from_url(url)
      request = Typhoeus::Request.new(url, followlocation: true)
      request.on_complete do |response|
        return new(url, Nokogiri::HTML(response.response_body) )  if response.success?
        raise "Timeout: #{url}"                                      if response.timed_out?
        raise "#{response.return_message}: #{url}"                   if response.code == 0
        raise "HTTP request failed: #{response.code}"
      end
      request.run
    end

    def initialize( url, nokogiri_doc )      
      load_adapter( url, nokogiri_doc )
    end
    
  private
    
    # returns an instance of the adapter class
    def load_adapter(url, nokogiri_doc)
      uri = URI(url)
      domain_str = uri.host.gsub('.','_')
      require Rails.root.join('lib/site_adapters', domain_str)
      klass = "site_adapters/#{domain_str}".classify.constantize
      @domain_adapter = klass.new( uri_obj.path, nokogiri_doc )
    end
  end
end