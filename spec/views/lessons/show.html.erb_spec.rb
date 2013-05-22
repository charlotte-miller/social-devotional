require 'spec_helper'

describe "lessons/show" do
  before(:each) do
    @study  = assign(:study,  build_stubbed(:study) )
    @lesson = assign(:lesson, stub_model(Lesson,
      :study    => @study,
      :position => 2,
      :title => "Title",
      :description => "MyText",
      :video => video_file,
      :audio => audio_file,
      :created_at => Time.now,
      :study_title => 'Matthew Study'
    ))
  end

  it "renders attributes in <p>" do
    render
    assert_select "#lesson", :count => 1
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match( url_to_regex(@lesson.video.url) )
    rendered.should match( url_to_regex(@lesson.audio.url) )
  end
end
