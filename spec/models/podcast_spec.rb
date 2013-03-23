# == Schema Information
#
# Table name: podcasts
#
#  id           :integer          not null, primary key
#  church_id    :integer          not null
#  title        :string(100)
#  url          :string(255)      not null
#  last_checked :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Podcast do
  it { should belong_to :church }
  it { should have_many :studies }
  
  it "should build from factory" do
    lambda { create(:podcast) }.should_not raise_error
  end
  
  describe '.pull_updates()' do
    
    it "should create lessons from the podcast" do
      
    end
  end
end
