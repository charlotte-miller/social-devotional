require 'spec_helper'

describe "studies/index" do
  before(:each) do
    assign(:studies, [
      build_stubbed(Study,
        :title => "Road to Damascus",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        lessons: [build_stubbed(:lesson)]
      ),
      build_stubbed(Study,
        :title => "Road to Damascus",
        :description => "God famously meets us in the low places.  This is a study on God intersecting our high-points",
        lessons: [build_stubbed(:lesson)]
      )
    ])
  end

  it "renders a list of studies" do
    render
    assert_select ".study", :count => 2
    
    rendered.should have_content "Road to Damascus"
    rendered.should have_content "God famously meets us in the low places.  This is a study on God intersecting our high-points"
  end
end
