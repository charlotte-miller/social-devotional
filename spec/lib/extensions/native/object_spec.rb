require 'spec_helper'

describe Object do
  describe '#try_these(:method, :method)' do
    it "returns the first value that works (not nil)" do
      subject = double(foo:'foo', bar:nil)
      subject.try_these(:foo, :bar).should eql 'foo'
      
      subject = double(foo:nil, bar:'bar')
      subject.try_these(:foo, :bar).should eql 'bar'
    end
    
    it "returns nil if nothing works" do
      subject = double(foo:nil, bar:nil)
      subject.try_these(:foo, :bar).should be_nil
    end
    
    it "accepts method arguments as an array" do
      subject = double
      subject.should_receive(:foo).with('bar')
      subject.should_receive(:baz)
      subject.should_receive(:zip).with('zap')
      subject.try_these([:foo, 'bar'], :baz, [:zip,'zap'])
    end
  end
end