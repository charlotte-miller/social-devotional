require 'spec_helper'

describe "lessons/show" do
  before(:each) do
    @study = assign(:study, build_stubbed(:study_w_lessons,
      :title => "Road to Damascus",
      :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
      :ref_link => "http://www.church.org/podcast/1234"
    ))
    @church  = assign(:church, build_stubbed(:church))
    @lessons = assign(:lessons, @study.lessons)
    @lesson  = assign(:lesson, @lessons.first)
    @video   = assign(:video, @lessons.first.video)
    
    render
  end

  it "renders the Study's info" do
    [ @study.title,
      @study.description,
      @study.ref_link,
      @church.name,
    ].each {|info| rendered.should have_content(info) }    
  end
  
  it "renders the Study's media" do
    # assert_select '#study',   count:1
    rendered.should match( url_to_regex( @lesson.audio.url ))
    [:webm, :mp4, :webm_hd, :mp4_hd, :mp4_mobile].each do |format|
      rendered.should match( url_to_regex( @lesson.video.url(format) ))
    end
  end
    
  it "renders links to the Study's lessons" do
    # assert_select '.lessons', count:@lessons.length
    @lessons.each do |lesson| 
      # assert_select "#lesson_#{lesson.id}"
      assert_select "img[src=#{lesson.poster_img.url(:thumbnail)}]"
      rendered.should match( url_to_regex(study_lesson_path(@study, lesson)) )
    end
  end
end
