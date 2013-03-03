class Question < ActiveRecord::Base
  attr_accessible :source, :text, :answers_count
  
  belongs_to :meeting, polymorphic: true, as: 'source'
  belongs_to :lesson,  polymorphic: true, as: 'source'
end
