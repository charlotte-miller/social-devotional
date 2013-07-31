# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  admin_user_id :integer
#  source_id     :integer          not null
#  source_type   :string(255)      not null
#  text          :text
#  answers_count :integer          default(0)
#  blocked_count :integer          default(0)
#  stared_count  :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Question < ActiveRecord::Base
  include SourceableModels 

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :author, :source, :text
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :author,   :class_name => "User",      :foreign_key => "user_id"
  belongs_to :permanent_approver, :class_name => "AdminUser", :foreign_key => "admin_user_id"
  belongs_to :source,   polymorphic: true  # Meeting, Lesson, Group

  has_many   :answers, inverse_of: :question do
    def popular(n)
      order('stared_count DESC, answers_count DESC').limit(n)
    end
    
    def recent(n)
      order('updated_at DESC').limit(n)
    end
    
    def timeline(n)
      order('created_at ASC').limit(n)
    end
  end
    
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :author, :source, :text
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  default_scope joins(:author).recent

  # scope :recent,   reorder( 'created_at ASC')
  # scope :popular,  reorder( 'stared_count'  )
  # scope :timeline, reorder( 'created_at ASC')
  # scope :first_n,  lambda {|n=3| limit(n)   }
    
  # Admin and Reporting
  # scope :meetings,  where(source_type:'Meeting')
  # scope :lessons,   where(source_type:'Lesson')
  # scope :groups,    where(source_type:'Group')  
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
end
