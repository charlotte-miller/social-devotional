require 'spec_helper'
require Rails.root.join('lib/paperclip_processors/video_to_audio')

module Paperclip
  describe VideoToAudio do
    subject { VideoToAudio.new(nil) }

    it { should be_kind_of( ::Paperclip::Processor) }

    context "when passed an audio file" do
      subject { VideoToAudio.new(audio_file) }
      
      it "creates a video file" do
        raise NotImplemented
      end
    end

    context "when passed a video file" do
      subject { VideoToAudio.new(video_file) }

      it "returns the file untouched" do
        raise NotImplemented
      end
    end
  end
end