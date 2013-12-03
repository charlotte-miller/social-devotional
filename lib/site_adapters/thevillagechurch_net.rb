module SiteAdapters
  class ThevillagechurchNet

    attr_accessor :path, :page
    def initialize(path, nokogiri_doc)
      @path = path
      @page = nokogiri_doc
    end
  
    def title
      # @page.css('').text
    end
  
    def description
      # @page.css('').text
    end
  
    def backlink
      # @page.css('').text
    end
  
    def published_at
      # @page.css('').text
    end
  
    def duration
      # @page.css('').text
    end
  
    def audio_remote_url
      # @page.css('').text
    end
  
    def video_remote_url
      # @page.css('').text
    end
  end
end