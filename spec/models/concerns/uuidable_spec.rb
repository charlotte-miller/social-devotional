require 'spec_helper'

describe Uuidable do
  subject { UuidableWithoutPublicIdDummyKlass.new }
  
  describe '#create_uuid(prefix=nil)' do
    it "creates a unique id" do
      1000.times.map {subject.create_uuid}.uniq.length.should eql 1000 #tested up to 10_000_000
    end
    
    it "accepts a prefix" do
      subject.create_uuid('FOO').should match /^FOO-/
    end
    
    it "creates a key <= 16 characters" do
      subject.create_uuid.length.should be <= 16
    end
  end
  
  describe '.has_public_id' do
    subject { UuidableDummyKlass.new }
    
    # Use the shared_example to test model integration: 
    # it_behaves_like 'it has_public_id'
    
    it "generates a missing public id" do
      subject.generate_missing_public_id
      subject.foo.should_not be_nil
    end
    
    it "uses the prefix option" do
      subject.generate_missing_public_id
      subject.foo.should match /^BAR-/
    end
  end
end

class UuidableDummyKlass < ActiveRecord::Base
 has_no_table
 column :foo
 
 include Uuidable
 has_public_id :foo, prefix:'BAR'
end

class UuidableWithoutPublicIdDummyKlass
  include Uuidable
end