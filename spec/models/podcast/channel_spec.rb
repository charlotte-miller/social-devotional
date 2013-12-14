# == Schema Information
#
# Table name: studies
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  podcast_id    :integer          not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Podcast::Channel do
  before(:all) { @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) }
  subject { Podcast::Channel.new(@podcast_xml) }
  let(:spamy) { Podcast::Channel.new(@spamy_content) }
  
  describe '.new(xml_str)' do
    it "requires an xml string" do
      lambda { Podcast::Channel.new }.should raise_error(ArgumentError)
      lambda { Podcast::Channel.new('') }.should raise_error(ArgumentError)
      lambda { Podcast::Channel.new('<not xml>')}.should raise_error(RSS::NotWellFormedError)
      lambda { Podcast::Channel.new(@podcast_xml) }.should_not raise_error
    end
  end
  
  describe '#title' do
    it "is the channel's title" do
      subject.title.should == 'Mars Hill Bible Church'
    end
    
    it "returns plain text" do
      @spamy_content = @podcast_xml.gsub('<title>Mars Hill Bible Church', '<title><![CDATA[<h1>Mars Hill</h1><script>alert("spam")</script>]]>')
      spamy.title.should == 'Mars Hill'
    end
  end
  
  describe '#description' do
    let(:full_description) {'This publication contains the weekly teaching from Mars Hill Bible Church in Grandville, Michigan. In addition to an mp3 file of the teaching, a pdf of supplementary material is often provided.'}
    
    it "is the channel's summary" do
      subject.description.should == full_description
    end
    
    it "returns plain text" do
      @spamy_content = @podcast_xml.gsub(full_description, '<![CDATA[<h1>Big Description</h1>]]>')
      spamy.description.should == 'Big Description'
    end
  end
  
  describe '#homepage' do
    it "is the channel's link" do
      subject.homepage.should == 'http://www.marshill.org'
    end
    
    it "ignores javascript urls" do
      @spamy_content = @podcast_xml.gsub('<link>http://www.marshill.org', '<link>javascript://alert("spam")')
      spamy.homepage.should == nil
    end
  end
  
  describe '#last_updated' do
    it "returns a Time obj" do
      subject.last_updated.should be_a Time
    end
    
    it "returns the channel's lastBuildDate" do
      subject.last_updated.should == Time.parse('Tue, 26 Mar 2013 21:10:35 +0000')
    end
  end
  
  describe '#poster_img' do
    it "is the channel's image" do
      subject.poster_img.should == 'http://marshill.org/teaching/files/powerpress/marslogo.png'
    end

    it "ignores javascript urls" do
      @spamy_content = @podcast_xml.gsub('<url>http://marshill.org/teaching/files/powerpress/marslogo.png', '<url>javascript://alert("spam")')
      spamy.poster_img.should == nil
    end
  end
  
  describe '#keywords' do
    it "returns an array" do
      subject.keywords.should be_a Array
    end
    
    it "returns the channels itunes:keywords" do
      subject.keywords.should == %w{Mars Grand Rapids Grandville Christianity Rob Bell Bell Grandville Shane Hipps}
    end
    
    it "returns plain text keywords" do
      @spamy_content = @podcast_xml.gsub("Mars,Grand,Rapids,Grandville,Christianity,Rob,Bell,Bell,Grandville,Shane,Hipps", "<![CDATA[Mars</h1>]]>,Grand,Rapids,Grandville")
      spamy.keywords.should == %w{Mars Grand Rapids Grandville}
    end
  end
  
  describe 'items' do
    it "is an array of Podcast::Item" do
      subject.items.should be_a Array
      subject.items.first.should be_a Podcast::Item
    end
  end
  
  describe '#method_missing', :internal do
    it "delegates to podcast_obj" do
      [:channel, :image, :rss_version].each do |sample_podcast_method|
        subject.should_not respond_to sample_podcast_method   # we didn't overwrite the method
        subject.send(sample_podcast_method).should_not be_nil # it works!
      end
    end
    
    it "calls super when no method is found" do
      lambda { subject.some_other_method }.should raise_error(NoMethodError)
    end
  end
end