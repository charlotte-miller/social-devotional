require 'spec_helper'
require 'set'

shared_examples 'a Lesson::Adapter' do |attr_hash|
    
  Lesson::Adapters::Base::ATTRIBUTES.each do |attr|
    it "assigns data to EVERY attribute in the interface [#{attr}]" do
      subject.should respond_to(attr)
      subject.send(attr).should_not be_nil
    end
  end
  
  (attr_hash || {}).each_pair do |attr, value|
    it "parses the correct #{attr}" do
      subject.send(attr).should eql value
    end
  end
   
end