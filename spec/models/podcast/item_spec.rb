# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  study_id    :integer          not null
#  position    :integer          default(0)
#  title       :string(255)      not null
#  description :text
#  backlink    :string(255)
#  video_url   :string(255)
#  audio_url   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Podcast::Item do
  before(:all) { @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) }
  let!(:parent_channel) { Podcast::Channel.new(@podcast_xml) }
  let(:spamy) { Podcast::Channel.new(@spamy_content).items.first }
  subject { parent_channel.items.first }
  
  describe '.new(parent_channel, rss_item_obj)' do
    it "requires a Podcast::Channel" do
      lambda { Podcast::Item.new(nil, nil) }.should raise_error(ArgumentError, 'Podcast::Channel required')
      lambda { Podcast::Item.new('NOT Podcast::Channel', nil)}.should raise_error(ArgumentError, 'Podcast::Channel required')
    end
    
    it "requires a RSS::Rss::Channel::Item" do
      lambda { Podcast::Item.new( parent_channel, nil ) }.should raise_error(ArgumentError, 'RSS::Rss::Channel::Item required')
      lambda { Podcast::Item.new( parent_channel, 'NOT RSS::Rss::Channel::Item')}.should raise_error(ArgumentError, 'RSS::Rss::Channel::Item required')
    end
    
    it "builds from proper arguments" do
      lambda { Podcast::Item.new( parent_channel, parent_channel.native_rss_items.first ) }.should_not raise_error
    end
  end
  
  describe '#parent_channel' do
    it "returns the parent_channel" do
      subject.parent_channel.should eql parent_channel
    end
  end
  
  describe '#title' do
    it "returns the item's title" do
      subject.title.should == 'Seven Deadly Sins: Wrath'
    end
    
    it "returns plain text" do
      @spamy_content = @podcast_xml.gsub('<title>Seven Deadly Sins: Wrath', '<title><![CDATA[<h1>Seven Deadly Sins: Wrath</h1><script>alert("spam")</script>]]>')
      spamy.title.should == 'Seven Deadly Sins: Wrath'
    end
  end
  
  describe '#author' do
    it "returns a description of the item" do
      subject.author.should == 'Mars Hill'
    end
    
    it "returns plain text" do
      @spamy_content = @podcast_xml.gsub('<itunes:author>Mars Hill', '<itunes:author><![CDATA[<h1>Mars Hill</h1><script>alert("spam")</script>]]>')
      spamy.author.should == 'Mars Hill'
    end
  end
  
  describe '#description' do
    it "returns a description of the item" do
      subject.description.should == 'Michael Hidalgo'
    end
    
    it "returns plain text" do
      @spamy_content = @podcast_xml.gsub('<description>Michael Hidalgo', '<description><![CDATA[<h1>Michael Hidalgo</h1><script>alert("spam")</script>]]>')
      spamy.description.should == 'Michael Hidalgo'
    end
  end
  
  describe '#homepage' do
    it "is the item's link" do
      subject.homepage.should == 'http://feedproxy.google.com/~r/marshill/podcast/~3/btjS4Py6TOI/'
    end
    
    it "ignores javascript urls" do
      @spamy_content = @podcast_xml.gsub('<link>http://feedproxy.google.com/~r/marshill/podcast/~3/btjS4Py6TOI/', '<link>javascript://alert("spam")')
      spamy.homepage.should == nil
    end
    
    # it "uses the original link feedburner:origLink" do
    #   pending
    # end
  end
  
  describe '#published_at' do
    it "returns a Time obj" do
      subject.published_at.should be_a Time
    end
    
    it "returns the items pubDate" do
      subject.published_at.should == Time.parse('Sun, 24 Mar 2013 15:00:14 +0000')
    end
  end
  
  describe '#duration' do  
    it "is the itunes:duration in seconds" do
      subject.duration.should == 2194 #36:34
    end
  end
  
  describe '#media_link' do
    it "is a link to the enclosed media" do
      subject.media_link.should == 'http://feedproxy.google.com/~r/marshill/podcast/~5/0t1oQ0T4nGc/032413.mp3'
    end
    
    # it "uses the original link feedburner:origEnclosureLink" do
    #   pending
    # end
  end
  
  describe '#media_length' do
    it "is the byte length of the media" do
      subject.media_length.should == 17689826
    end
  end
  
  describe '#media_type' do
    it "is a string describing the file format" do
      subject.media_type.should == 'audio/mpeg'
    end
  end
  
  describe '#poster_img' do
    it "returns the parent_channel's poster_img" do
      subject.poster_img.should eql 'http://marshill.org/teaching/files/powerpress/marslogo.png'
    end
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
  
  describe '#method_missing', :internal do
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