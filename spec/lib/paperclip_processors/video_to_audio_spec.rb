require 'spec_helper'
require Rails.root.join('lib/paperclip_processors/video_to_audio')

module Paperclip
  describe VideoToAudio do
    subject { VideoToAudio.new(nil) }
    let(:result) { subject.make }

    it { should be_kind_of( ::Paperclip::Processor) }

    context "when passed an video file:" do
      subject { VideoToAudio.new(video_file) }
      
      it "creates an audio file" do
        result.extname.should eql 'mp3'
      end
    end

    context "when passed an audio file:" do
      subject { VideoToAudio.new(audio_file) }

      it "returns the file untouched" do
        result.should be_the_same_file_as audio_file 
      end
    end
  end
end