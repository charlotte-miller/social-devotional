require 'spec_helper'

describe "admin/studies/index" do
  before(:each) do
    assign(:studies, [
      build_stubbed(Study,
        :slug => "road-to-damascus",
        :title => "Road to Damascus",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        :ref_link => "http://www.church.org/podcast/1234"
      ),
      build_stubbed(Study,
        :slug => "road-to-damascus",
        :title => "Road to Damascus",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        :ref_link => "http://www.church.org/podcast/1234"
      )
    ])
  end

  it "renders a list of studies" do
    render
    assert_select ".study", :count => 2
    
    rendered.should have_content "road-to-damascus"
    rendered.should have_content "Road to Damascus"
    rendered.should have_content "God famously meets us in the low places.  This is a study on God intersecting our high-points"
    rendered.should have_content "http://www.church.org/podcast/1234"
  end
end
