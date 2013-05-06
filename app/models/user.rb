# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  first_name                 :string(60)
#  last_name                  :string(60)
#  email                      :string(80)       default(""), not null
#  encrypted_password         :string(255)      default(""), not null
#  password_salt              :string(255)
#  reset_password_token       :string(255)
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  sign_in_count              :integer          default(0)
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :string(255)
#  last_sign_in_ip            :string(255)
#  confirmation_token         :string(255)
#  confirmed_at               :datetime
#  confirmation_sent_at       :datetime
#  unconfirmed_email          :string(255)
#  failed_attempts            :integer          default(0)
#  locked_at                  :datetime
#  profile_image_file_name    :string(255)
#  profile_image_content_type :string(255)
#  profile_image_file_size    :integer
#  profile_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class User < ActiveRecord::Base
  # Authentication Layer
  devise  :database_authenticatable, :trackable, :validatable, :lockable,
          :registerable, :recoverable, :confirmable, :rememberable, #:omniauthable,
          :lock_strategy => :failed_attempts, :unlock_strategy => :time, :maximum_attempts => 5, :unlock_in => 5.seconds,   # lockable
          :remember_for => 1.week, :extend_remember_period => true,                                                         # rememberable
          :allow_unconfirmed_access_for => 3.days                                                                          # confirmable
          # :omniauth_providers => []                                                                                         # omniauth
         
         

  # ---------------------------------------------------------------------------------
  # Attributes
  # ---------------------------------------------------------------------------------
  attr_accessible   :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  has_attached_file :profile_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
    :storage => :s3,
    :bucket => AppConfig.s3.bucket,
    :s3_credentials => AppConfig.s3.credentials,
    :path => ':rails_env/:class/:attachment/:id/:updated_at.:extension'
    # :url  => AppConfig.cloudfront.url

  
  
  # ---------------------------------------------------------------------------------
  # Associations
  # ---------------------------------------------------------------------------------
  has_many :group_memberships, :dependent => :destroy# ,        inverse_of: 'member'
  has_many :groups,            :through => :group_memberships#, inverse_of: 'member'
  has_many :block_requests# ,                                   inverse_of: 'requester'
    
  
  # ---------------------------------------------------------------------------------
  # Validations
  # ---------------------------------------------------------------------------------
  validates_presence_of :email#, :first_name, :last_name
  validates_length_of   :first_name, :last_name, :within => 0..60, :message => "is too long"
  validates_length_of   :email, :within => 0..80, :message => "is too long"
  validates_attachment :profile_image, :size => { :in => 0..10.megabytes }
    #, :presence => true,
    # :content_type => { :content_type => "image/jpg" }
    
  
  
  # ---------------------------------------------------------------------------------
  # Scopes
  # ---------------------------------------------------------------------------------
  
  
  
  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def name
    "#{first_name} #{last_name}"
  end
end
