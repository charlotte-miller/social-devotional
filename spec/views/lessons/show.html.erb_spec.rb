require 'spec_helper'

describe "lessons/show" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :position => 2,
      :title => "Title",
      :description => "MyText",
      :backlink => "",
      :video_url => "Video Url",
      :audio_url => "Audio Url",
      :created_at => Time.now
    ))
  end

  it "renders attributes in <p>" do
    render
    assert_select "#lesson", :count => 1
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/Video Url/)
    rendered.should match(/Audio Url/)
  end
end
