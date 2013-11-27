require 'spec_helper'
require Rails.root.join('lib/paperclip_processors/video_to_audio')

module Paperclip
  describe VideoToAudio do
    subject { VideoToAudio.new(nil) }
    let(:run_make){ subject.make }
    let(:result)  { run_make }

    it { should be_kind_of( ::Paperclip::Processor) }

    context "when passed a video file:" do
      subject { VideoToAudio.new(video_file, (@options || {})) }
      
      it "creates an audio file" do
        result.extname.should eql '.mp3'
      end
      
      describe 'the command line' do
        let(:input_file) { video_file }
        let(:output_file) { subject.instance_variable_get('@destination_file') }
        let(:command_line_runner) { subject.instance_variable_get('@command_line').runner }
        
        it "uses ffmpeg to convert the file" do
          run_make
          command_line_runner.ran?("ffmpeg -i '#{input_file.path}' -vn -ar 44100 -ac '2' -ab '128k' -f 'mp3' '#{output_file.path}'").should be_true
        end

        it "passes the processor's options to ffmpeg" do
          @options = { audio_bitrate: 'FOO',
                              format: 'BAR',
                           is_stereo: false }         
          run_make
          command_line_runner.ran?("ffmpeg -i '#{input_file.path}' -vn -ar 44100 -ac '1' -ab 'FOO' -f 'BAR' '#{output_file.path}'").should be_true
        end
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