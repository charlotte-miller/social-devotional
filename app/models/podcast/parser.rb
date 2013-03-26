# require 'rss/parser'
require 'rss/itunes'

class Podcast::Parser
  attr_accessor :xml_str, :current_podcast
  
  def initialize(xml_str)
    @xml_str = xml_str
    @current_podcast = RSS::Parser.parse(xml_str)
    # http://www.ruby-doc.org/stdlib-1.9.3/libdoc/rss/rdoc/RSS.html
  end
  
  def run!
    find_or_create_study
    find_or_create_lesson
  end
  
  private
  def sanitize(str)
    ActionController::Base.helpers.sanitize(str)
  end
  
  def find_or_create_study
    Study.find_or_create_by_id({
      
    })
  end
  
  def find_or_create_lesson
    
  end
end

##### IF YOU HAVE PARSING PROBLEMS BETWEEN FORMATS
#  Should probably use this gem instead of rolling your own
#  - https://github.com/pauldix/feedzirra
#  - this abstracts away the various podcast providers
#####