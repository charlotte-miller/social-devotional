require 'spec_helper'

describe "admin/lessons/index" do
  before(:each) do
    assign(:lessons, [
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "backlink",
        :video => v = video_file,
        :audio => a = audio_file,
        :created_at => Time.now
      ),
      stub_model(Lesson,
        :study_id => 1,
        :position => 2,
        :title => "Title",
        :description => "MyText",
        :backlink => "backlink",
        :video => v,
        :audio => a,
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of lessons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title", :count => 2
    assert_select "tr>td", :text => "MyText", :count => 2
    assert_select "tr>td", :text => "backlink", :count => 2
    assert_select "tr>td", :text => "Video", :count => 2
    assert_select "tr>td", :text => "Audio", :count => 2
  end
end
