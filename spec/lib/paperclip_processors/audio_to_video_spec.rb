require 'spec_helper'
require Rails.root.join('lib/paperclip_processors/audio_to_video')

module Paperclip
  describe AudioToVideo do
    subject { AudioToVideo.new(nil) }
    let(:run_make){ subject.make }
    let(:result)  { run_make }

    it { should be_kind_of( ::Paperclip::Processor) }

    context "when passed an audio file:" do
      subject { AudioToVideo.new(audio_file, (@options || { poster_img:img_file })) }
      
      it "creates a video file" do
        result.extname.should eql '.mp4'
      end
      
      describe 'the command line' do
        let(:input_img_file) { img_file }
        let(:input_audio_file) { audio_file }
        let(:output_file) { subject.instance_variable_get('@destination_file') }
        let(:command_line_runner) { subject.instance_variable_get('@command_line').runner }
        
        it "uses ffmpeg to combine the files" do
          run_make
          command_line_runner.ran?("ffmpeg -i '#{input_img_file.path}' -i '#{input_audio_file.path}' -vcodec libx264 '#{output_file.path}'").should be_true
        end        
      end
      
      describe 'options[:poster_img]' do
        let(:poster_img_path) { subject.bypass.poster_img_path }
        
        it "accepts a File" do
          @options = { poster_img:img_file }
          run_make
          poster_img_path.should eql img_file.path
        end
        
        it "accepts a Tempfile" do
          @options = { poster_img: temp = Tempfile.new(['foo', '.bar']) }
          run_make
          poster_img_path.should eql temp.path
        end
        
        it "accepts a '/path/to/file'" do
          @options = { poster_img:img_file.path }
          run_make
          poster_img_path.should eql img_file.path
        end
        
        it "defaults to the attachment's poster_img_w_study_backfill" do
          dummy = DummyKlass.new
          dummy.poster_img = img_file
          dummy.foo = audio_file
          dummy.foo.queued_for_write[:bar].extname.should eql '.mp4'
        end
      end
    end

    context "when passed a video file:" do
      subject { AudioToVideo.new(video_file) }

      it "returns the file untouched" do
        result.should be_the_same_file_as video_file
      end
    end
  end
  
  
  class DummyKlass < SimplePaperclip
    attr_accessor :foo_file_name, :poster_img_file_name
    has_attached_file :poster_img, url: ':rails_root/spec/files/:filename', path: ':rails_root/spec/files/:filename'
    has_attached_file :foo, :styles => {bar:'true'}, :processors => [:audio_to_video]

    alias_method :poster_img_w_study_backfill, :poster_img
  end
end