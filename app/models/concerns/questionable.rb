module Questionable
  extend ActiveSupport::Concern
  
  included do
    has_many :questions, as: 'source' do  # , inverse_of: 'source'
      def popular(n=5)
        order('stared_count DESC, answers_count DESC').limit(n)
      end
      
      def recent(n=5)
        order('updated_at DESC').limit(n)
      end
      
      def timeline(n=5)
        order('created_at ASC').limit(n)
      end
    end
    
    
    scope :w_questions, includes(:questions)
  end
  
end