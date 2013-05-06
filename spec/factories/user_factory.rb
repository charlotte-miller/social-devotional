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



FactoryGirl.define do
  factory :user, aliases: [:requester, :author, :member] do
    before(:create, :stub) do
      User.any_instance.stub({ save_attached_files: true })
    end
    
    first_name  'Fred'
    last_name   'Fredrickson'
    sequence(   :email)  {|n| "example@domain#{n}.com"}
    password    'super-secret'
    password_confirmation  {|me| me.password }
    profile_image File.open(File.join(Rails.root, 'spec/files/', 'user_profile_image.jpeg' ))
  end
end
