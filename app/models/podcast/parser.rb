class Podcast::Parser
  attr_accessor :xml_str
  
  def initialize(xml_str)
    @xml_str = xml_str
    
  end
  
  def find_or_create_study
    Study.find_or_create_by_id({
      
    })
  end
  
end