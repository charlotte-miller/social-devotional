module Lesson::Adapters::WebSites
  class ThevillagechurchNet

    attr_accessor :url, :path, :page
    def initialize(url, nokogiri_doc)
      @url  = url
      @path = URI(url).path
      @page = nokogiri_doc
    end
  
    def study_title
      lesson_meta[:topic]
    end
    
    def title
      @page.xpath("#{lesson_xpath_base}/header/h3[@class='realtitle']").text  # .displaytitle
    end
  
    def description
      @page.xpath("#{lesson_xpath_base}/div[@class='text']").text
    end
    
    def author
      lesson_meta[:author]
    end
  
    def backlink
      url
    end
  
    def published_at
      Time.parse(@page.xpath("#{lesson_xpath_base}/header/time").text)
    end
  
    def duration
      vimeo_page.xpath('//script').text.match(/"duration":(\d+)/)[1].to_i
    end
    
    def poster_img_remote_url
      thumbs_hash = JSON.parse vimeo_page.xpath('//script').text.match(/"thumbs":({[^}]*})/)[1].to_s
      thumbs_hash["1280"] #1280, 960, 640
    end
  
    def audio_remote_url
      # @page.xpath("//#{lesson_xpath_base}/div[@class='media']/div[@class='download']//a").attr('href').value.match(/url=(.*)&/)[1]
      @page.xpath("//script").text.match(/jPlayer\('setMedia',\s*{mp3:\s*'(.*)'\s*}/)[1]
    end
  
    def video_remote_url
      url = @page.xpath("#{lesson_xpath_base}/header/div[@class='embed-video']/iframe").attr('src').value
      URI(url).without_query_or_fragment
    end
    
  private
    
    def lesson_xpath_base
      "//article[@class='detail sermons']"
    end
    
    def lesson_meta
      meta  = @page.xpath("#{lesson_xpath_base}/header/p[@class='meta']").inner_html
      match = lambda { |key| meta.match(%r{#{key}</span>:([^<]*)})[1].strip  }
      { category: match['Category'],
        topic:    match['Topic'],
        author:   match['Author'] }
    end
    
    def vimeo_page
      @vimeo_page ||= Typhoeus.go_to_url_then(video_remote_url) do |response|
        Nokogiri::HTML(response.response_body)
      end
    end
  end
end