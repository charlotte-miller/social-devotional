require 'spec_helper'

describe Lesson::AttachedMedia do
  subject { build(:lesson) }
  
  it { should respond_to :audio }
  it { should respond_to :video }
  it { should respond_to :poster_img }
  
  it "has better tests" do
    pending
  end
  
  
end