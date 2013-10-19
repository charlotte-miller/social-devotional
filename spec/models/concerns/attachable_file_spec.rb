require 'spec_helper'

describe AttachableFile do
  subject { DummyClass.new }
  
  describe '.has_attachable_file' do
    let(:paperclip_obj) { subject.wonderful_img }
    
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
    it "returns immediatly when assigned nil" do
      subject.wonderful_img_remote_url = nil
      subject.should_not respond_to(:after_save)
    end
    
    context "with an assigned url" do
      before(:each) do
        @img_location = 'http://foo.com/bar.jpg'
        subject.wonderful_img_remote_url = @img_location
      end

      it "stores the url as <attachment>_original_url " do
        expect(subject.wonderful_img_original_url).to eq @img_location
      end

      it "adds an after_save hook" do
        expect(subject).to respond_to(:after_save) 
      end
      
      context "on save - " do      
        it "queues a Sidekiq job to download the <attachment> (once)" do
          expect { subject.after_save }.to change(AttachmentDownloader.jobs, :size).by(1)
          expect { subject.after_save }.to change(AttachmentDownloader.jobs, :size).by(0)
        end
      end
    end
  end
end

class DummyClass < ActiveRecord::Base
  has_no_table
  
  include AttachableFile
  has_attachable_file :wonderful_img, path: '/path/of/wonder'
end