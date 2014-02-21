# == Schema Information
#
# Table name: churches
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  homepage   :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Church < ActiveRecord::Base
  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :homepage, :name

  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_many :podcasts, :inverse_of => :church
    accepts_nested_attributes_for :podcasts
  has_many :studies, :through => :podcasts, :inverse_of => :church

  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :homepage, :name


  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------



  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def to_s
    name
  end
end
