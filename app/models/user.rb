class User < ActiveRecord::Base
  # Authentication Layer
  devise  :database_authenticatable, :encryptable, :trackable, :validatable, :lockable,
          :registerable, :recoverable, :confirmable, :rememberable, #:omniauthable,
          :lock_strategy => :failed_attempts, :unlock_strategy => :time, :maximum_attempts => 5, :unlock_in => 5.seconds,   # lockable
          :remember_for => 1.week, :extend_remember_period => true,                                                         # rememberable
          :allow_unconfirmed_access_for => 3.days                                                                          # confirmable
          # :omniauth_providers => []                                                                                         # omniauth
         
         

  # -----------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me

  
  
  # -------------
  # Associations
  # ---------------------------------------------------------------------------------
  
  
  
  # ------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :email, :first_name, :last_name
  validates_length_of   :first_name, :last_name, :within => 0..60, :message => "is too long"
  validates_length_of   :email, :within => 0..80, :message => "is too long"
  
  
  # -------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
  # --------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def name
    "#{first_name} #{last_name}"
  end
end
