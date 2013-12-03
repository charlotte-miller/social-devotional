require 'spec_helper'
require Rails.root.join('lib/site_adapters', 'thevillagechurch_net')

describe ThevillagechurchNet do
  vcr_lesson_web
  subject { TODO }
  
  {
    title: 'foo',
    description: 'bar',
    etc: '...'
  }.each do |value, attr|
    it "parses the correct #{attr}" do
      subject.send(attr).should eql value
    end
  end
  
  it "assigns data to EVERY attribute in the interface" do
    Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
      subject.send(attr).should_not be_nil
    end
  end
end