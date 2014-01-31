require 'spec_helper'

describe AttachmentDownloader do
  it { should be_processed_in 'attachments' }
  it { should be_retryable true}
  it { should be_unique }
  
  describe '#perform(obj_hash, attachment_names=[])' do
    let(:any_model) { create(:study, poster_img: nil, poster_img_original_url:'http://foo.com/poster.jpg') }
    let(:obj_hash)  { any_model.to_findable_hash }
  
    it "finds the model from obj_hash" do
      Study.should_receive_and_execute( :find ).with(any_model.id)
      subject.perform( obj_hash, [] )
    end
    
    it "downloads and assigns the [attachments]" do
      expect(any_model.poster_img).not_to be_present
      subject.perform( obj_hash, :poster_img )
      expect(obj_hash.to_obj.poster_img).to be_present
    end
    
    it "skips attachments specified in :skip_processing_urls" do
      # Assumes Lesson#video skips YouTube
      picky_model = create(:lesson, video:nil, video_original_url:'https://www.youtube.com/watch?v=0JR6xt9S02o&t=3')
      subject.perform( picky_model.to_findable_hash, :video )
      expect(picky_model.reload.video).not_to be_present
    end
  end
  
  # Not really a unit test! More of a sanity check
  # describe '[private] #curl_to', :integration do
  #   it "downloads the url to a file" do
  #     Cocaine::CommandLine.unfake!
  #     subject.bypass.curl_to 'http://jasonlefkowitz.net/wp-content/uploads/2013/07/Cute-Cats-cats-33440930-1280-800.jpg', "#{`cd ~ && pwd`.chomp}/Desktop/all_creatures.jpg"
  #     Cocaine::CommandLine.fake!
  #   end
  # end
end