require 'spec_helper'

describe AttachableFile do
  subject { DummyClass.new }
  let(:paperclip_obj) { subject.wonderful_img }
  
  describe '.has_attachable_file' do
    it "adds paperclip for <attribute>" do
      should respond_to :wonderful_img
      subject.wonderful_img.should be_a Paperclip::Attachment
    end
    
    it "configures paperclip for S3" do
      paperclip_obj.bucket_name.should_not be_nil
    end
    
    it "merges options w/ defaults" do
      paperclip_obj.options.should include_hash({
        :path     => '/path/of/wonder',  # merged
        :storage  => :s3 })              # default
    end
    
    it "adds accessors for <attribute>_remote_url" do
      should respond_to :wonderful_img_remote_url
      should respond_to :wonderful_img_remote_url=
    end
  end
  
  describe '#<attachment>_remote_url=' do
    it "stores the url as <attachment>_original_url " do
      raise NotImplementedError
    end
    
    it "queues a Sidekiq job to download the <attachment>" do
      raise NotImplementedError
    end
  end
end

class DummyClass < ActiveRecord::Base
  has_no_table
  
  include AttachableFile
  has_attachable_file :wonderful_img, path: '/path/of/wonder'
end