require 'spec_helper'
require 'open-uri'

describe Lesson::Adapters::Web, :focus do
  vcr_lesson_web
  
  let(:url) { 'http://www.something.com' }
  let(:nokogiri_doc) { Nokogiri::HTML(open url) }
  subject { Lesson::Adapters::Web.new(url, nokogiri_doc) }
  
  describe '.new_from_url(url)' do    
    it "creates a Lesson::Adapters::Web" do
      Lesson::Adapters::Web.new_from_url(url).should be_an_instance_of Lesson::Adapters::Web
    end
  end
  
  it "loads the correct SiteAdapters class" do
    pending
  end
  
  Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
    it { should delegate_method(attr).to(:domain_adapter) }
  end

end