require 'spec_helper'

describe "studies/index" do
  before(:each) do
    assign(:studies, [
      stub_model(Study,
        :slug => "Slug",
        :title => "Title",
        :description => "Description",
        :ref_link => "Ref Link",
        :video_url => "Video Url"
      ),
      stub_model(Study,
        :slug => "Slug",
        :title => "Title",
        :description => "Description",
        :ref_link => "Ref Link",
        :video_url => "Video Url"
      )
    ])
  end

  it "renders a list of studies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Ref Link".to_s, :count => 2
    assert_select "tr>td", :text => "Video Url".to_s, :count => 2
  end
end
