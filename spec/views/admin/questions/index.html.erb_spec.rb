require 'spec_helper'

describe "questions/index" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :lesson_id => 1,
        :group_id => 2,
        :text => "MyText",
        :answers_count => 3
      ),
      stub_model(Question,
        :lesson_id => 1,
        :group_id => 2,
        :text => "MyText",
        :answers_count => 3
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
