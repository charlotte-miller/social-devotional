require 'spec_helper'

describe "admin/lessons/show" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :study_id => 1,
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
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/Video Url/)
    rendered.should match(/Audio Url/)
  end
end
