require 'spec_helper'

describe "studies/show" do
  before(:each) do
    @study = assign(:study, build_stubbed(:study_w_lessons,
      :title => "Road to Damascus",
      :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
      :ref_link => "http://www.church.org/podcast/1234"
    ))
    @lessons = assign(:lessons, @lessons = @study.lessons)
  end

  it "renders attributes in <p>" do
    render
    assert_select '#study',   count:1
    assert_select '.lessons', count:2
    @lessons.each {|lesson| assert_select "#lesson_#{lesson.id}"}
    
    rendered.should have_content "Road to Damascus"
    rendered.should have_content "God famously meets us in the low places.  This is a study on God intersecting our high-points"
    rendered.should have_content "http://www.church.org/podcast/1234"
    rendered.should match(url_to_regex @lessons.first.video.url)
  end
end
