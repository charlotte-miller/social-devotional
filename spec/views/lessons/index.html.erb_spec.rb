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
        :audio_url => "Audio Url"
      ),
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "",
        :video_url => "Video Url",
        :audio_url => "Audio Url"
      )
    ])
  end

  it "renders a list of lessons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Video Url".to_s, :count => 2
    assert_select "tr>td", :text => "Audio Url".to_s, :count => 2
  end
end
