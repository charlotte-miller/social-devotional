require 'spec_helper'

describe "lessons/index" do
  before(:each) do
    @study   = assign(:study,  build_stubbed(:study) )
    @lessons = assign(:lessons, [
      stub_model(Lesson,
        :study    => @study,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video => video_file,
        :audio => audio_file,
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      ),
      stub_model(Lesson,
        :study    => @study,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video => video_file,
        :audio => audio_file,
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      )
    ])
  end

  it "renders a list of lessons" do
    render #template: ''
    
    assert_select ".lesson", :count => 2
    @lessons.each do |lesson|
      rendered.should match( url_to_regex(lesson.video.url) )
      rendered.should match( url_to_regex(lesson.audio.url) )
    end
  end
end
