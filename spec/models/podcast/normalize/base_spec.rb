require 'spec_helper'

describe Podcast::Normalize::Base do
  
  describe '#plain_text(str)' do
    it "strips tags and lead/trailing whitespace" do
      str = <<-TEXT
        <div>
          <p>
            <a href="javascript://alert('spam')">Friendly Link</a>
            <script>alert('spam')</script>
          </p>
        </div>
      TEXT
      
      subject.send(:plain_text, str).should == 'Friendly Link'
    end
  end
  
  describe '#sanitize(str)' do
    it "removes javascript:// calls" do
      str = <<-TEXT
        <a href="javascript://alert('spam')">Click Me</a>
        <img src="javascript://alert('spam')" />
      TEXT
      clean = subject.send(:sanitize, str)
      clean.should match '<a>Click Me</a>'
      clean.should match '<img />'
    end
    
    it "removes style attributes" do
      str = <<-TEXT
        <p style="text-size:large;">Click Me</p>
      TEXT
      clean = subject.send(:sanitize, str)
      clean.should == '<p>Click Me</p>'
    end
  end
  
  describe '#sanitize_url(str)' do
    it "returns the url as a string" do
      good_url = 'http://www.marshill.org'
      subject.send(:sanitize_url, good_url).should == good_url
    end
    
    it "returns nil when the link is non http(s)" do
      bad_url = "javascript://alert('spam')"
      subject.send(:sanitize_url, bad_url).should be_nil
      
      bad_url = "ftp://ftp.example.com"
      subject.send(:sanitize_url, bad_url).should be_nil
    end
  end
end