require 'spec_helper'

describe "answers/index" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :question => nil,
        :author => nil,
        :source_id => 1,
        :source_type => "Source Type",
        :text => "MyText",
        :blocked_count => 2,
        :stared_count => 3
      ),
      stub_model(Answer,
        :question => nil,
        :author => nil,
        :source_id => 1,
        :source_type => "Source Type",
        :text => "MyText",
        :blocked_count => 2,
        :stared_count => 3
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Source Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
