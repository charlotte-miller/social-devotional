module Channels
  class Web < ::Channel
    
    def import_site(options={})
      options = {
        start_path: 'sermons/',
        lesson_matcher: /(sermon\/\D*\/$)/,
        pagination_matcher: /(\/resources\/sermons\/\?page=\d*)/,
      }
    
      link_matcher = /(sermons?\/\D*$)|(\/resources\/sermons\/\?page=\d*$)/
    
      Anemone.crawl(church.homepage + options[:start_path]) do |anemone|
        anemone.focus_crawl {|page| page.links.map{|link| (link_matcher =~ link.to_s) && link }.compact }
      
        anemone.on_pages_like options[:lesson_matcher] do |page|
          puts "#{page.code} - #{page.url}"
          # Study.find_or_create_by(name:"")
          # nokogiri_doc = page.doc
          # adapter = Lesson::Adapters::Web.new_from_url(url_str)
          # lesson  = Lesson.new_from_adapter(adapter)
        end
      
        # anemone.on_every_page do |page|
        #   puts "#{page.code} - #{page.url}"
        # end
      end
    end
    
    
  end
end