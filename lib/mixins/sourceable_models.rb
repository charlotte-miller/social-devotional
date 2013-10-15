# TODO migrate to models/concerns

module SourceableModels
  
  def self.included(base)
    base.class_eval do
      scope :recent,   reorder( 'created_at ASC')
      scope :popular,  reorder( 'stared_count DESC, answers_count ASC'  )
      scope :timeline, reorder( 'created_at ASC')
      scope :first_n,  lambda {|n=3| limit(n)   }
      
      # Admin and Reporting
      scope :meetings,  where(source_type:'Meeting' )
      scope :lessons,   where(source_type:'Lesson'  )
      scope :groups,    where(source_type:'Group'   )
      
    end    
  end
  
end