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
#  keywords                :text             default(""), not null
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
  # it { should validate_uniqueness_of(:title)}#.scope_to(:podcast_id)}
  
  it "builds from factory", internal:true do
    lambda { create(:study) }.should_not raise_error
  end
  
  describe 'new_from_podcast_channel(normalized_channel, attribute_overrides={})' do
    it "builds from a Podcast::Normalized::Channel" do
      pending 'TODO'
    end
    
    it "applies attribute_overrides" do
      pending 'TODO'
    end
  end
  
  describe '#touch' do
    let!(:study)           { create(:study_w_lesson) }
    let(:existing_lesson)  { study.lessons.first }
    let(:add_lesson)       { create(:lesson, study:study, published_at:Time.now+1.day )}
    
    it "updates #updated_at" do
      inital_timestamp = study.updated_at
      Timecop.travel(1.second) { study.touch }
      study.updated_at.should be > inital_timestamp
    end
    
    it "updates lessons_count" do
      study.lessons_count.should eql 1
      lambda {add_lesson}.should change(study, :lessons_count).by(1)
    end
    
    it "updates #last_published_at" do
      study.last_published_at.should     be_same_second_as existing_lesson.published_at # initial published_at assigned
      add_lesson.published_at.should_not be_same_second_as existing_lesson.published_at # create a lesson w/ a different published_at
      study.last_published_at.should     be_same_second_as add_lesson.published_at      # check that it's assigned correctly
    end
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
  
  describe '#include?(lesson)' do
    it "requires an argument of @lesson" do
      lambda { subject.include?() }.should raise_error(ArgumentError, 'wrong number of arguments (0 for 1)')
      lambda { subject.include?(nil) }.should raise_error(ArgumentError, 'Study#include? requires a @lesson')
    end
    
    it "determins if a lesson is part of a study" do
      study = create(:study_w_lesson)
      inside_lesson  = study.lessons.first
      outside_lesson = create(:lesson)
      
      study.include?( inside_lesson  ).should be_true
      study.include?( outside_lesson ).should be_false
    end
  end
  
  describe '#should_include?(lesson)' do
    it "requires an argument of @lesson" do
      lambda { subject.include?() }.should raise_error(ArgumentError, 'wrong number of arguments (0 for 1)')
      lambda { subject.include?(nil) }.should raise_error(ArgumentError, 'Study#include? requires a @lesson')
    end
    
    # this doesn't mean it's bad to add this lesson... just that this isn't yet the lesson's 'home'
    it "returns false if lessons are empty" do
      Study.new.should_include?( Lesson.new ).should be_false
    end
    
    # essentally delegates logic to Lesson#belongs_with?
    it "returns true if this lesson belongs_with? the studies last lesson" do
      study  = build_stubbed(:study_w_lesson)
      lesson = study.lessons.last
      
      # positive and negative case
      [true, false].each do |bool|
        lesson.stub(belongs_with?:bool)
        study.should_include?( Lesson.new ).should eql bool
      end
    end
  end
  
  describe '[private]', internal:true do
  end
end
