class Admin < ActiveRecord::Base
  # Authentication Layer
  devise :database_authenticatable, :encryptable, :trackable, :validatable, :recoverable, :confirmable, :lockable, :timeoutable, 
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
  
  
end