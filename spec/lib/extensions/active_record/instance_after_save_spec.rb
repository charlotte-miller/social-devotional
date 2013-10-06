require 'spec_helper'

describe 'InstanceAfterSave' do
  let(:any_model) { build(:church) }
  
  describe Church, '#after_save' do
    it_should_run_callbacks :run_instance_after_save
  end
  
  context "with an #after_save instance method" do
    subject do
      model = any_model
      def model.after_save; end
      return model
    end
    
    it "runs #after_save on save" do
      subject.should_receive( :after_save ).once
      subject.save!
    end
  end
  
  context "with NO #after_save instance method" do
    subject { any_model }
    
    it "skips #after_save on save" do
      # should_receive gives a false positive
      lambda { subject.save! }.should_not raise_error
      lambda { subject.after_save }.should raise_error NoMethodError
    end
  end
end