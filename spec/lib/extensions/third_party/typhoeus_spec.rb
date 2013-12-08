require 'spec_helper'

describe Typhoeus do
  vcr_lesson_web
  
  describe '.go_to_url_then(url, &block)' do
    let(:url) { @url || 'http://www.something.com' }
    subject { Typhoeus.go_to_url_then(url, &@block)}
    
    it "returns the result of the block if the network call was successful" do
      @block = lambda { |response| response.code }
      should eql 200
    end
  end
  
end