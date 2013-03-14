require 'spec_helper'

describe "studies/index" do
  before(:each) do
    assign(:studies, [
      stub_model(Study,
        :slug => "Slug",
        :title => "Title",
        :description => "Description",
        :ref_link => "Ref Link",
        :video_url => "Video Url",
        :created_at => Time.now
      ),
      stub_model(Study,
        :slug => "Slug",
        :title => "Title",
        :description => "Description",
        :ref_link => "Ref Link",
        :video_url => "Video Url",
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of studies" do
    render
    assert_select ".study", :count => 2
  end
end
