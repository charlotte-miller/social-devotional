require 'spec_helper'

describe Paperclip::Attachment do
  let(:normal) { create(:lesson) }
  let(:trusted_third_party) { create(:lesson, video:nil, video_remote_url:'https://www.youtube.com/watch?v=0JR6xt9S02o&t=3') }
  let(:non_trusted_third_party) { create(:lesson, video:nil, video_remote_url:'https://www.foo.com/watch?v=0JR6xt9S02o&t=3') }
  let(:empty) { create(:lesson, video:nil, video_original_url:nil) }
  
  describe '#url' do
    it "returns the S3 url when present?" do
      normal.video.url('foo').should match %r{http://s3.amazonaws.com/social-devotional/test/lessons/\d{0,4}/videos/foo/video.m4v}
    end
    
    it "returns the instance.original_url if trusted_third_party?" do
      trusted_third_party.video.url(:foo).should eq 'https://www.youtube.com/watch?v=0JR6xt9S02o&t=3'
    end
    
    it "returns the 'missing' url otherwise" do
      non_trusted_third_party.video.url(:foo).should eq '/videos/foo/missing.png'
      empty.video.url(:foo).should eq '/videos/foo/missing.png'
    end
  end
  
  describe '#trusted_third_party?' do
    it "returns true only when <attachment>_original_url is trusted" do
      normal.video.trusted_third_party?.should be_false
      empty.video.trusted_third_party?.should be_false
      non_trusted_third_party.video.trusted_third_party?.should be_false
      trusted_third_party.video.trusted_third_party?.should be_true
    end
  end
  
end