require 'spec_helper'

describe "lessons/index" do
  before(:each) do
    @study  = assign(:study,  build_stubbed(:study) )
    assign(:lessons, [
      stub_model(Lesson,
        :study    => @study,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video_url => "Video Url",
        :audio_url => "Audio Url",
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      ),
      stub_model(Lesson,
        :study    => @study,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video_url => "Video Url",
        :audio_url => "Audio Url",
        :created_at => Time.now,
        :study_title => 'Matthew Study'
      )
    ])
  end

  it "renders a list of lessons" do
    render #template: ''
    assert_select ".lesson", :count => 2

  end
end
