require 'spec_helper'
require 'set'

shared_examples 'it has_public_id' do |options|
  options = {
    public_id_column: :public_id,
    prefix: nil,
    length: 20
  }.merge(options || {})
  
  describe do
    before(:each) do
      subject.stub(:generate_missing_public_id)
    end

    it { should validate_presence_of options[:public_id_column]}
    it { should validate_uniqueness_of options[:public_id_column]}
    it { should ensure_length_of(options[:public_id_column]).is_at_least(1).is_at_most(options[:length]) }  
  end
  
  it "generates a missing public id" do
    subject.save!
    subject.send(options[:public_id_column]).should_not be_nil
  end
  
  it "uses the prefix option" do
    subject.save!
    subject.send(options[:public_id_column]).should match /^#{options[:prefix]}-/
  end
end