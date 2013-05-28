# == Schema Information
#
# Table name: studies
#
#  id                      :integer          not null, primary key
#  slug                    :string(255)      not null
#  podcast_id              :integer          not null
#  title                   :string(255)      not null
#  description             :string(255)
#  ref_link                :string(255)
#  poster_img_file_name    :string(255)
#  poster_img_content_type :string(255)
#  poster_img_file_size    :integer
#  poster_img_updated_at   :datetime
#  lessons_count           :integer          default(0)
#  last_published_at       :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe Study do
  it { should have_many(:lessons) }
  it { should belong_to(:podcast) }
  it { should have_one(:church).through(:podcast) }
  it { should delegate_method(:church_name).to(:podcast)}
  
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:podcast) }
    
  it "builds from factory", internal:true do
    lambda { create(:study) }.should_not raise_error
  end
  
  describe '- scopes' do
  end
  
  describe '#lessons.number(n, strict=false)' do
    before(:each) do
      @study = create(:study_with_n_lessons, n:2 )
      @lesson1, @lesson2 = @lessons = @study.reload.lessons # position assigned after_create
    end
    
    it "returns a lesson at(n) index" do
      @study.lessons.number(1).should eql @lesson1
      @study.lessons.number(2).should eql @lesson2
    end
    
    it "returns nil when no lesson matches" do
      @study.lessons.number(3).should be_nil
    end
    
    it "returns an ArgumentError if 'strict=true'" do
      lambda {@study.lessons.number(3, :strict) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
  describe '#stand_alone?' do
    it "returns true if the study has one lesson" do
      create(:study_w_lesson).stand_alone?.should  be_true
      create(:study_w_lessons).stand_alone?.should be_false
    end
  end
  
  describe 'private methods', internal:true do
    describe '#searchable_title( str )' do
      subject {Study.new.send(:searchable_title, @original_str)}
      it "downcases the str" do
        @original_str = "LOUD"
        should eql 'loud'
      end
      
      it "removes common leading words" do
        %w{a an and the for by}.each do |over_used|
          @original_str = over_used + ' glory and honor'
          should eql 'glory and honor'
        end
      end
    end
    
    
  end
end
