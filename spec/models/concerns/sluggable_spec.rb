require 'spec_helper'

describe Sluggable do
  subject { DummyClass.new }
  
  describe 'FriendlyId integration' do
    it "responds_to friendly_id" do
      DummyClass.should respond_to :friendly_id
    end
  end
  
  describe '.slug_candidates' do
    it "defines #slug_candidates AND return the arguments as an array" do
      should respond_to :slug_candidates
      subject.slug_candidates.should == [:title, [:title, :church_name]]
    end
  end
end

 
class DummyClass < ActiveRecord::Base
  has_no_table
  
  include Sluggable
  slug_candidates :title, [:title, :church_name]
end