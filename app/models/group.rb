class Group < ActiveRecord::Base
  attr_accessible :desription, :name, :series_id, :public
  
  validates_presence_of :name, :desription, :series_id, :on => :save, :message => "can't be blank"
  
  scope :public, where(public: true) 
  
end
