# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  first_name             :string(60)
#  last_name              :string(60)
#  email                  :string(80)       default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  password_salt          :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class AdminUser < ActiveRecord::Base
  # Authentication Layer
  devise :database_authenticatable, :trackable, :validatable, :recoverable, :confirmable, :lockable, :timeoutable, 
         :lock_strategy => :failed_attempts, :maximum_attempts => 5, :unlock_strategy => :email,        # :lockable
         :timeout_in => 12.hours,                                                                       # :timeoutable
         :stretches => 20                                                                               # :database_authenticatable


  
  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
    
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :email
  
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def self.from_user()
    # TODO
    
    
  end
end
