# == Schema Information
#
# Table name: channels
#
#  id              :integer          not null, primary key
#  type            :string(255)      not null
#  church_id       :integer          not null
#  title           :string(100)      not null
#  build_options   :text
#  last_checked_at :datetime
#  last_updated_at :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Channel < ActiveRecord::Base
  attr_accessible :build_options, :church_id, :last_checked_at, :last_updated_at, :title, :type
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  serialize :build_options, Hash
  
  attr_accessible :title, :build_options
  attr_accessible :build_options, :church_id, :last_checked_at, :last_updated, :title, :type, :as => :factory_girl
  delegate :name, :homepage, :to => :church, :prefix => :church # church_name, church_homepage

  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  belongs_to :church#, :inverse_of => :channel
  has_many :studies,  :inverse_of => :channel do
    def most_recent(n=nil)
      except(:order).order('last_published_at DESC').first(n)
    end
  end


  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :church, :title, :type


  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------



  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------

  
end
