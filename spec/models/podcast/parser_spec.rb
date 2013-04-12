# == Schema Information
#
# Table name: studies
#
#  id            :integer          not null, primary key
#  slug          :string(255)      not null
#  podcast_id    :integer          not null
#  title         :string(255)      not null
#  description   :string(255)
#  ref_link      :string(255)
#  video_url     :string(255)
#  lessons_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Podcast::Parser do
  before(:all) do
    @podcast_xml = File.read(File.join(Rails.root, 'spec/files/podcast_xml', 'itunes.xml')) 
  end
  subject { Podcast::Parser.new(@podcast_xml) }
  
  describe '.new(xml_str)' do
    it "requires an xml string" do
      lambda { Podcast::Parser.new }.should raise_error(ArgumentError)
      lambda { Podcast::Parser.new('') }.should raise_error(ArgumentError)
      lambda { Podcast::Parser.new('<not xml>')}.should raise_error(RSS::NotWellFormedError)
      lambda { Podcast::Parser.new(@podcast_xml) }.should_not raise_error
    end
  end
  
  describe '#last_updated' do
    it('handles itunes') { subject.last_updated.should == Time.parse('Tue, 26 Mar 2013 21:10:35 +0000') }    
  end
  
end