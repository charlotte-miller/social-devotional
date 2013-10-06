require 'spec_helper'

describe RequestStore::SidekiqMiddleware do
  
  subject(:sidekiq_middleware) do
    described_class.new
  end
  
  describe '#call' do
    before(:each) do
      @worker = AttachmentDownloader.new
      @message = {}
      @queue = "attachment"
    end
    
    it 'clears the RequestStore' do
      RequestStore.should_receive(:clear!)
      sidekiq_middleware.call(@worker, @message, @queue) {}
    end

    it 'yields' do
      expect { |b| sidekiq_middleware.call(@worker, @message, @queue, &b) }.to yield_with_no_args
    end
  end
  
  describe "middleware config" do
    it "should be in the sidekiq middleware chain" do
      Sidekiq.client_middleware.entries.map(&:klass).should include(RequestStore::SidekiqMiddleware)
    end
  end

end