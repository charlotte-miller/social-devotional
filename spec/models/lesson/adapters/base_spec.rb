require 'spec_helper'

describe Lesson::Adapters::Base do
  let(:klass) { DummyKlass.new }
  let(:attrs) { Lesson::Adapters::Base::ATTRIBUTES }

  it "is an abstract class" do
    lambda { subject }.should raise_error NotImplementedError
  end

  it "provides attr_accessors" do
    attrs.each {|attr| klass.should have_attr_accessor attr}
  end

  it "validates_presense_of attribtues" do
    attrs.each do |attr|
      klass.should validate_presence_of attr
    end
  end

  describe '#to_hash' do
    it "returns a hash of it's attributes" do
      attrs.each {|attr| klass.send("#{attr}=", 'foo')}
      klass.to_hash.symbolize_keys.should eql({
        title:'foo',
        description:'foo',
        backlink:'foo',
        published_at:'foo',
        duration:'foo',
        audio_remote_url:'foo',
        video_remote_url:'foo',
      })
    end
  end
end

class DummyKlass < Lesson::Adapters::Base
  def initialize;  end
end