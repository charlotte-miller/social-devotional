module SourceableModels
  
  def self.included(base)
    base.class_eval do
      
      # Admin and Reporting
      scope :meetings,  where(source_type:'Meeting')
      scope :lessons,   where(source_type:'Lesson')
      scope :groups,    where(source_type:'Group')
      
    end    
  end
  
end