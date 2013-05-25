require 'spec_helper'

describe "admin/studies/show" do
  before(:each) do
    @study = assign(:study, build_stubbed(Study,
      :slug => "road-to-damascus",
      :title => "Road to Damascus",
      :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
      :ref_link => "http://www.church.org/podcast/1234"
    ))
  end

  it "renders attributes in <p>" do
    render
    assert_select "#study"
        
    rendered.should have_content "road-to-damascus"
    rendered.should have_content "Road to Damascus"
    rendered.should have_content "God famously meets us in the low places.  This is a study on God intersecting our high-points"
    rendered.should have_content "http://www.church.org/podcast/1234"
    # rendered.should match(/Lessons/)
  end
end
