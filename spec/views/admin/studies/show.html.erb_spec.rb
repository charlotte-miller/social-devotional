require 'spec_helper'

describe "studies/show" do
  before(:each) do
    @study = assign(:study, stub_model(Study,
      :slug => "Slug",
      :title => "Title",
      :description => "Description",
      :ref_link => "Ref Link",
      :video_url => "Video Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Slug/)
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/Ref Link/)
    rendered.should match(/Video Url/)
  end
end
