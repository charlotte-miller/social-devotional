require 'spec_helper'

module Lesson::SimilarityHeuristic
  describe Base do
    it "provides initialize(context, other_lesson)" do
      lambda { Base.new }.should raise_error(ArgumentError)
      lambda do
        _new = Base.new('foo', 'bar')
        _new.context.should eql 'foo'
        _new.other_lesson.should eql 'bar'
      end.should_not raise_error
    end

    it "enforces the #matches? interface" do
      lambda { DummyClass.new('foo', 'bar').matches? }.should raise_error(NotImplementedError)
    end
  end
  
  class DummyClass < Base ;end
end
