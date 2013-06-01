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

require 'spec_helper'

describe User do
  it "builds from factory", internal:true do
    expect { create(:user) }.to_not raise_error
  end
  
  it { should have_many(:group_memberships) }
  it { should have_many(:groups) }
  it { should have_many(:block_requests) }
  
  it { should validate_presence_of(:email) }
  it { should ensure_length_of(:email).is_at_most(80) }
  it { should ensure_length_of(:first_name).is_at_most(60) }
  it { should ensure_length_of(:last_name).is_at_most(60) }
  it "validates :email format" do
    should allow_value('chip@mail.com').for(:email)
    ['chip.com', 'chip@mail', 'chipmail'].each do |bad_value|
      should_not allow_value(bad_value).for(:email)
    end
  end
  
  describe 'mass_assignment' do
    describe 'blocks protected attributes' do
      [:id, :encrypted_password, :password_salt, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :locked_at, :encrypted_password].each do |attr|
        it "- #{attr}" do
          should_not allow_mass_assignment_of(attr)
        end
      end
    end
    
    describe 'allows public attributes' do
      [:email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :profile_image].each do |attr|
        it "- #{attr}" do
          should allow_mass_assignment_of(attr)
        end
      end
    end
  end
  
  describe '#name' do
    it "should combine first_name and last_name" do
      build_stubbed(:user, first_name:'Billy', last_name:'Bob').name.should eql 'Billy Bob'
    end
  end
end
    