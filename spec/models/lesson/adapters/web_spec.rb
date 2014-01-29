require 'spec_helper'
require 'open-uri'
require 'spec/models/lesson/adapters/web_sites/dummy_klass'

describe Lesson::Adapters::Web do
  vcr_lesson_web
  
  let(:url) { @url || 'http://www.something.com' }
  let(:nokogiri_doc) { Nokogiri::HTML(open url) }
  subject { Lesson::Adapters::Web.new(url, nokogiri_doc) }
  
  it "loads the correct domain adapter class" do
    subject.domain_adapter.should be_kind_of Lesson::Adapters::WebSites::SomethingCom
  end
  
  it "raises AdapterNotFound if no domain adapter exist" do
    @url = 'http://example.com'
    lambda { subject }.should raise_error Lesson::Adapters::NotFound, "No adapter for: Lesson::Adapters::WebSites::ExampleCom"
  end
  
  Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
    it { should delegate_method(attr).to(:domain_adapter) }
  end

  describe '.new_from_url(url)' do    
    it "creates a Lesson::Adapters::Web" do
      Lesson::Adapters::Web.new_from_url(url).should be_an_instance_of Lesson::Adapters::Web
    end
  end

end