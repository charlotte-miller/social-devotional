# == Schema Information
#
# Table name: podcasts
#
#  id           :integer          not null, primary key
#  church_id    :integer          not null
#  title        :string(100)
#  url          :string(255)      not null
#  last_checked :datetime
#  last_updated :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Podcast do
  let(:podcast) { create(:podcast) }
  
  it { should belong_to :church }
  it { should have_many :studies }
  
  it "should build from factory" do
    lambda { create(:podcast) }.should_not raise_error
  end
  
  describe '.update_from_feed(podcast_parser_obj)' do
    let(:feed_obj) { Podcast::Parser.new(File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml'))) }
    
    it "requires a podcast_parser_obj" do
      lambda { podcast.update_from_feed('') }.should raise_error(ArgumentError)
      lambda { podcast.update_from_feed(feed_obj)}.should_not raise_error
    end
    
    it "should create lessons from the podcast" do
      
    end
  end
end
