require 'spec_helper'

describe Lesson::Adapters::Podcast do
  before(:all) { @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) }
  let(:channel) { Podcast::Normalize::Channel.new(@podcast_xml) }
  let(:podcast_item) { channel.items.first }
  subject { Lesson::Adapters::Podcast.new podcast_item }

  it "builds from a Podcast::Normalize::Item" do
    podcast_item.should be_an_instance_of Podcast::Normalize::Item
    subject.should be_an_instance_of Lesson::Adapters::Podcast
  end

  it "assigns data to every attribute in the interface" do
    Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
      subject.send(attr).should_not be_nil
    end
  end
end