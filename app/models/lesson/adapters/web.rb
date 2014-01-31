require 'nokogiri'

# === Lesson::Adapters::Web
# Selects and delegates parsing to a domain specific adapter
#
#   1) looks up an adapter based on the domain
#   2) delegates ATTRIBUTES to the domain-adapter (which handles the messiness of parsing the web_site)
#
module Lesson::Adapters
  class Web < Base
    attr_reader :url, :nokogiri_doc, :domain_adapter
    delegate *Lesson::Adapters::Base::ATTRIBUTES, to: :domain_adapter

    # Builds from a url string
    def self.new_from_url(url)
      Typhoeus.go_to_url_then(url) do |response|
        new(url, Nokogiri::HTML(response.response_body) )
      end
    end

    def initialize( url, nokogiri_doc )      
      @url, @nokogiri_doc = url, nokogiri_doc
      load_adapter
    end

  private

    # returns an instance of the adapter class
    def load_adapter
      klass = "lesson/adapters/web_sites/#{normalized_underscored_domain}".classify.constantize
      @domain_adapter = klass.new( uri_obj.to_s, nokogiri_doc )
    rescue NameError => e
      raise Lesson::Adapters::NotFound.new("No adapter for: #{e.missing_name}")
    end

    def uri_obj
      normalized_url = (url =~ %r{^https?://} ? url : "http://#{url}")
      @uri_obj ||= URI( normalized_url )
    end

    # www.foo-bar.com #=> foo_bar_com
    def normalized_underscored_domain
      base_domain = uri_obj.host_w_out_subdomains
      underscored = base_domain.gsub(/\.|-/,'_')
    end
  end
end