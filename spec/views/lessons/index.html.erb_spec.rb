require 'spec_helper'

describe "lessons/index" do
  before(:each) do
    assign(:lessons, [
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video_url => "Video Url",
        :audio_url => "Audio Url",
        :created_at => Time.now
      ),
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video_url => "Video Url",
        :audio_url => "Audio Url",
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of lessons" do
    render #template: ''
    assert_select ".lesson", :count => 2

  end
end
