require 'spec_helper'

describe Lesson::AttachedMedia do
  subject { build(:lesson) }
  
  it { should respond_to :audio }
  it { should respond_to :video }
  it { should respond_to :poster_img }
  
  it "has better tests" do
    raise NotImplementedError
  end
    
  describe 'attached audio -' do
    it "runs the audio_to_video processor" do
      pending
      AudioToVideo.should_receive(:new)
    end
  end
  
  describe 'attached video -' do
    it "runs the video_to_audio processor" do
      pending
      VideoToAudio.should_receive(:new)
    end
    
    it "runs the ffmpeg processor" do
      pending
      Ffmpeg.should_receive(:new)
    end
    
    it "runs the qtfaststart processor" do
      pending
      QtFastStart.should_receive(:new)
    end
  end
  
  describe 'attached poster_img -' do
    it "runs the :thumbnail processor" do
      pending
      Thumbnail.should_receive(:new)
    end
    
    it "runs the :pngquant processor" do
      pending
      PngQuant.should_receive(:new)
    end
  end
end