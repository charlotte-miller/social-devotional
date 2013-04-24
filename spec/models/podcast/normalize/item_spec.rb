require 'spec_helper'

describe Podcast::Normalize::Item do
  before(:all) { @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) }
  let!(:channel) { Podcast::Normalize::Channel.new(@podcast_xml) }
  subject { channel.items.first }
  
  describe '.new(rss_item_obj)' do
    it "requires a RSS::Rss::Channel::Item" do
      lambda { Podcast::Normalize::Item.new }.should raise_error(ArgumentError)
      lambda { Podcast::Normalize::Item.new('NOT RSS::Rss::Channel::Item')}.should raise_error(ArgumentError)
      lambda { Podcast::Normalize::Item.new( channel.native_rss_items.first ) }.should_not raise_error
    end
  end
  
  describe '#title' do
    pending
  end
  
  # describe '#next' do
  #   it "returns the next item" do
  #     pending
  #   end
  #   
  #   it "returns nil at the end of the list" do
  #     pending
  #   end
  # end
  # 
  # describe '#previous' do
  #   it "returns the previous item" do
  #     pending
  #   end
  #   
  #   it "returns nil at the start of the list" do
  #     pending
  #   end
  # end
  
  describe '#method_missing', internal:true do
    it "delegates to podcast_obj" do
      [:valid?, :guid, :itunes_keywords].each do |sample_podcast_method|
        subject.should_not respond_to sample_podcast_method   # we didn't overwrite the method
        subject.send(sample_podcast_method).should_not be_nil # it works!
      end
    end
    
    it "calls super when no method is found" do
      lambda { subject.some_other_method }.should raise_error(NoMethodError)
    end
  end
end