# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  first_name             :string(60)
#  last_name              :string(60)
#  user_id                :integer
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



FactoryGirl.define do
  factory :admin_user, aliases: [:approver] do
    first_name  'Fred'
    last_name   'Fredrickson'
    user        { FactoryGirl.build_stubbed(:user) } 
    sequence(   :email)  {|n| "example@domain#{n}.com"}
    password    'super-secret'
    password_confirmation  {|me| me.password }
    confirmed_at Time.now - 1.minute
  end
end
