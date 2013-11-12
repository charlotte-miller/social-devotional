require 'spec_helper'
require Rails.root.join('lib/paperclip_processors/audio_to_video')

module Paperclip
  describe AudioToVideo do
    subject { AudioToVideo.new(nil) }
    let(:result) { subject.make }

    it { should be_kind_of( ::Paperclip::Processor) }

    context "when passed an audio file:" do
      subject { AudioToVideo.new(audio_file) }
      
      it "creates a video file" do
        result.extname.should eql '.mp4'
      end
    end

    context "when passed a video file:" do
      subject { AudioToVideo.new(video_file) }

      it "returns the file untouched" do
        result.should be_the_same_file_as video_file
      end
    end
  end
end