require 'spec_helper'
require 'open-uri'

describe Lesson::Adapters::Web do
  describe '.new_from_url(url)' do
    after(:each) { VCR.eject_cassette }
    before(:each) do
      VCR.insert_cassette('lesson_adapters_web', :record => :new_episodes) #:new_episodes
    end

    it "has tests" do
      raise NotImplementedError
    end
  end

  let(:nokogiri_doc) { Nokogiri::HTML(open 'http://www.something.com') }
  subject { Lesson::Adapters::Web.new(nokogiri_doc) }

  it "builds from a Nokogiri::HTML doc" do
    nokogiri_doc.should be_an_instance_of Nokogiri::HTML
    subject.should be_an_instance_of Lesson::Adapters::Web
  end

  # it "assigns data to every attribute in the interface" do
  #   Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
  #     subject.send(attr).should_not be_nil
  #   end
  # end
end